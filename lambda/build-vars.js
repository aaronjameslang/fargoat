#! /usr/bin/env node

/**
 * This module exports/prints various build variables
 *
 * Serverless can use the exports in yml templates
 *   ${file(./build-vars.js):accountId}
 *
 * Other build scripts can capture the printed output
 *   $(./build-vars.js accountId)
 */

require('dotenv').config()
const aws = require('aws-sdk')
const fs = require('fs').promises
const { exec } = require('child_process')
const { promisify } = require('util')

const PROJECT_NAME = process.env.PROJECT_NAME
if (!PROJECT_NAME) throw Error('No PROJECT_NAME')
const REGION = process.env.REGION
if (!REGION) throw Error('No REGION')
const STAGE = process.env.STAGE
if (!STAGE) throw Error('No STAGE')

exports.accountId = new aws.STS().getCallerIdentity()
    .promise().then(x => x.Account)

exports.ecrUri = async function () {
    const id = await exports.accountId
    return `${id}.dkr.ecr.${REGION}.amazonaws.com`
}()

exports.subnetId = async function () {
    const cmd = "serverless info -v -c vpc-serverless.yml | grep -Po '(?<=Subnet0Id: ).*$'"
    const execp = promisify(exec)
    return execp(cmd).then(({ stdout }) => stdout.trim())
}()

exports.ecrImgUri = async function () {
    const ecrUri = await exports.ecrUri
    const version = await exports.version
    return `${ecrUri}/${PROJECT_NAME}-ecs-${STAGE}:${version}`
}()

exports.version = fs.readFile('./version.latest', 'UTF-8')
    .then(v => v.trim())

if (require.main === module) {
    const key = process.argv[2]
    if (key) {
        exports[key].then(console.log)
    } else {
        const cache = {}
        for (let k in exports) {
            exports[k].then(v => {
                console.log({ [k]: v })
                cache[k] = v
            })
        }
        Promise.all(Object.values(exports)).then(() => {
            // Write to file
            // Hack because serverless is buggy rading js, but can read json fine
            fs.writeFile('build-vars.json', JSON.stringify(cache, null, 2) + '\n')
        })
    }
}
