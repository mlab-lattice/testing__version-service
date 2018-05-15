#!/usr/bin/env bash

set -e
set -u

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}/..

SERVICE_FILE=VersionService.js
VERSION=${1}

# https://stackoverflow.com/questions/17790123/shell-script-trying-to-validate-if-a-git-tag-exists-in-a-git-repository-in-an
if git rev-parse -q --verify "refs/tags/${VERSION}" > /dev/null; then
    echo "Version ${VERSION} already exists"
    exit 1
fi

cat > ${SERVICE_FILE} << EOF
const carbon = require('carbon-io')
const o  = carbon.atom.o(module).main
const _o = carbon.bond._o(module)
const __ = carbon.fibers.__(module)

__(() => {
  module.exports = o({
    _type: carbon.carbond.Service,
    gracefulShutdown: false,
    port: _o('env:PORT') || 8080,
    endpoints: {
      version: o({
        _type: carbon.carbond.Endpoint,
        get: () => ({ version: "${VERSION}" }),
      }),
      status: o({
        _type: carbon.carbond.Endpoint,
        get: () => ({ ok: true }),
      }),
    },
  })
})
EOF

git add ${SERVICE_FILE}
git commit -m "version ${VERSION}"
git tag -a ${VERSION} -m "version ${VERSION}"
