// Basic HTTP server with no dependencies
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 8080;

// Create the HTTP server
const server = http.createServer((req, res) => {
  console.log(`Request: ${req.method} ${req.url}`);
  
  // Basic routing
  if (req.url === '/' || req.url === '/index.html') {
    serveFile(res, 'public/index.html', 'text/html');
  } 
  else if (req.url === '/game' || req.url === '/game.html') {
    serveFile(res, 'public/game.html', 'text/html');
  }
  else if (req.url === '/test' || req.url === '/test.html') {
    serveFile(res, 'public/test.html', 'text/html');
  }
  else if (req.url === '/minimal' || req.url === '/minimal.html') {
    serveFile(res, 'public/minimal.html', 'text/html');
  }
  else if (req.url === '/standalone' || req.url === '/standalone.html') {
    serveFile(res, 'public/standalone.html', 'text/html');
  }
  else if (req.url === '/hello') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World from basic Node.js server');
  }
  else if (req.url === '/api/basic') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({
      message: 'API response from basic Node.js server',
      time: new Date().toISOString()
    }));
  }
  else {
    // Try to serve static files from public directory
    serveFile(res, 'public' + req.url, getContentType(req.url));
  }
});

// Helper function to serve files
function serveFile(res, filePath, contentType) {
  fs.readFile(filePath, (err, content) => {
    if (err) {
      if (err.code === 'ENOENT') {
        // File not found
        res.writeHead(404);
        res.end('404 - File Not Found');
      } else {
        // Server error
        res.writeHead(500);
        res.end(`Server Error: ${err.code}`);
      }
    } else {
      // Success
      res.writeHead(200, { 'Content-Type': contentType });
      res.end(content, 'utf-8');
    }
  });
}

// Helper function to get content type based on file extension
function getContentType(filePath) {
  const extname = path.extname(filePath);
  switch (extname) {
    case '.html':
      return 'text/html';
    case '.js':
      return 'text/javascript';
    case '.css':
      return 'text/css';
    case '.json':
      return 'application/json';
    case '.png':
      return 'image/png';
    case '.jpg':
      return 'image/jpg';
    default:
      return 'text/plain';
  }
}

// Start the server
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Basic server running at http://localhost:${PORT}`);
  console.log(`Try accessing:
  - http://localhost:${PORT}/
  - http://localhost:${PORT}/game
  - http://localhost:${PORT}/minimal
  - http://localhost:${PORT}/standalone
  - http://localhost:${PORT}/hello
  - http://localhost:${PORT}/api/basic`);
  
  console.log(`\nFor Gitpod, use these URLs:
  - https://8080-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io/
  - https://8080-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io/game
  - https://8080-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io/minimal
  - https://8080-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io/standalone
  - https://8080-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io/hello
  - https://8080-slucha-rpggame-k76dclncl0c.ws-eu118.gitpod.io/api/basic`);
}); 