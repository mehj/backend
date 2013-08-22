{Backend} = require '../src'

backend = new Backend '127.0.0.1'

backend.addHandler()
.Id('b')
.Match(uri: protocol: 'HTTP')
.Handler (req, res) ->
    res "<h1>#{Date.now()}</h1>", 200, 'Content-Type': 'text/html'
    
backend.register()
