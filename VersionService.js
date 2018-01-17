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
          return { version: "v2.0.0" }
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
