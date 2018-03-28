const carbon = require('carbon-io')
const o  = carbon.atom.o(module).main
const _o = carbon.bond._o(module)
const __ = carbon.fibers.__(module)

__(() => {
  const version = _o('env:VERSION')
  if (version === undefined) {
    console.error("VERSION environment variable is required")
    process.exit(1)
  }

  module.exports = o({
    _type: carbon.carbond.Service,
    port: _o('env:PORT') || 8080,
    endpoints: {
      version: o({
        _type: carbon.carbond.Endpoint,
        get: () => ({ version }),
      }),
      status: o({
        _type: carbon.carbond.Endpoint,
        get: () => ({ ok: true }),
      }),
    },
  })
})
