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

exports.version = fs.readFile('./version.latest', 'UTF-8')
    .then(v => v.trim())

exports.ecrImgUri = async function () {
    const ecrUri = await exports.ecrUri
    const version = await exports.version
    return `${ecrUri}/${PROJECT_NAME}-ecs-${STAGE}:${version}`
}()

if (require.main === module) {
    const key = process.argv[2]
    if (key) {
        exports[key].then(console.log)
    } else {
        for (let k in exports) {
            exports[k].then(v => console.log({ [k]: v }))
        }
    }
}
