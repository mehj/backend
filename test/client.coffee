{Backend} = require '../src'

backend = new Backend 'ec2-54-226-131-21.compute-1.amazonaws.com'

backend.addHandler()
.Id('a')
.Match(uri: protocol: 'http')
.Handler (req, res) ->
    res "<h1>#{Date.now()}</h1>", 200, 'Content-Type': 'text/html'
    
backend.addHandler()
.Id('b')
.Match(uri: protocol : 'https')
.Handler (req, res) ->
    res require('util').inspect(req), 200, 'Content-Type': 'text/html'
        
backend.register()
