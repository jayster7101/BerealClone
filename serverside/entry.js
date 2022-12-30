const http = require('http');

const server = http.createServer((req, res) => {
    console.log(`${req.method} request received for ${req.url}`);

    // Set the response status code and content type
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');

    // Send a response back to the client
    res.end('Hello, Worldd!');
});

server.listen(3000, () => {
  console.log('Server listening on port 3000');
});
