const path = require('path')
const { spawnSync, execSync } = require('child_process')
const component = require('../../component.json')

const { registry, name, version } = component
let { RC_TAG } = process.env

if (!RC_TAG) {
  const buildNumber = process.env.TRAVIS_BUILD_NUMBER || component.build
  RC_TAG = `${version}-${buildNumber}-rc`
} 

const imageTags = {
  base: `${registry}/${name}`,
  releaseCandidate: `${registry}/${name}:${RC_TAG}`,
  latest: `${registry}/${name}:latest`,
  version: `${registry}/${name}:${version}`,
  test: `${registry}/test:latest`,
  apiTest: `${registry}/api-test:latest`,
  e2eTest: `${registry}/e2e-test:latest`
}

const ROOT = path.join(__dirname, '../..')
const opts = { cwd: ROOT, stdio: 'inherit' }

function copyDemoData () {
  execSync('rm -rf ./data/demo_data', opts)
  execSync('cp -r ./data/demo_baseline ./data/demo_data', opts)
}

function packageRestServer () {
  execSync(`docker build -f docker/Dockerfile -t ${imageTags.releaseCandidate} -t ${imageTags.latest} .`, opts)
}

function packageTests () {
  execSync(`docker build -f docker/Dockerfile.test -t ${imageTags.apiTest} .`, opts)
}

function packageApiTests () {
  execSync(`docker build -f docker/Dockerfile.apitest -t ${imageTags.apiTest} .`, opts)
}

function packageE2ETests () {
  execSync(`docker build -f docker/Dockerfile.e2etest -t ${imageTags.e2eTest} .`, opts)
}

module.exports = {
  imageTags,
  copyDemoData,
  packageRestServer,
  packageTests,
  packageApiTests,
  packageE2ETests
}