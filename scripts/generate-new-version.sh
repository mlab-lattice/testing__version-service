#!/usr/bin/env bash

set -e
set -u

# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd ${DIR}/..

SERVICE_FILE=VersionService.js
VERSION=${1}

if (git rev-parse -q --verify "refs/tags/${VERSION}" > /dev/null); then
    echo "Version ${VERSION} already exists"
    exit 1
fi

cat > ${SERVICE_FILE} << EOF
var carbon = require('carbon-io')
var o  = carbon.atom.o(module).main
var _o = carbon.bond._o(module)
var __ = carbon.fibers.__(module).main

__(function() {
  module.exports = o({
    _type: carbon.carbond.Service,
    port: _o('env:PORT') || 8080,
    endpoints: {
      version: o({
        _type: carbon.carbond.Endpoint,
        get: function(req) {
          return { version: "${1}" }
        }
      }),
      status: o({
        _type: carbon.carbond.Endpoint,
        get: function(req) {
          return { ok: true }
        }
      })
    }
  })
})
EOF

git add ${SERVICE_FILE}
git commit -m "version ${1}"
git tag -a ${VERSION} -m "version ${VERSION}"
