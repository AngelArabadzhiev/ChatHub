
const WebSocketServer = require('websocket').server;
const http = require('http');

var server = http.createServer(function (request, response) {
    console.log((new Date()) + ' Received request for ' + request.url);
    response.writeHead(200);
    response.end();
});
server.listen(3000, function () {
    console.log('Server started on port 3000');
});
wsServer = new WebSocketServer({
    httpServer: server,
    autoAcceptConnections: false
});
wsServer.on('register', function () {
    console.log('Registered');
})
