{createServer} = require 'http'
{randomBytes} = require 'crypto'
{encode, decode} = require 'coden'

dnode = require 'dnode'
reconnect = require 'reconnect'

{inspect} = require 'util'
        
class Handler
    constructor: (@hdls) ->
    tryAppend: ->
        @hdls.push [@id, @match, @handler] if @id? and @match? and @handler?
    Id: (@id) ->
        @tryAppend()
        @
    Match: (@match) ->
        @tryAppend()
        @
    Handler: (@handler) ->
        @tryAppend()
        @

class Backend
    constructor: (@host, port) ->
        @port = 8522 unless port?
        @hdls = []
    addHandler: ->
        new Handler @hdls
    register: ->
        hdls = @hdls
        d = dnode()
        d.on 'remote', (remote) ->
            k = randomBytes(256).toString 'base64'
            encode k, (err, result) ->
                remote.auth k, result.toString(), (addHandler) ->
                    addHandler h... for h in hdls
        c = net.connect {@host, @port}
        c.pipe(d).pipe c
        #r = reconnect (c) ->
        #    c.pipe(d).pipe c
        #r.connect {@host, @port}

module.exports = {Backend}
