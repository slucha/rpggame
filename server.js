const http = require('http');
const fs = require('fs');
const path = require('path');

const server = http.createServer((req, res) => {
    // Serve standalone.html for both / and /standalone.html
    const filePath = req.url === '/' ? '/standalone.html' : req.url;
    const fullPath = path.join(__dirname, 'public', filePath);

    fs.readFile(fullPath, (err, content) => {
        if (err) {
            res.writeHead(404);
            res.end('File not found');
            return;
        }

        // Set correct content type for HTML files
        const ext = path.extname(fullPath);
        const contentType = ext === '.html' ? 'text/html' : 'text/plain';
        
        res.writeHead(200, { 'Content-Type': contentType });
        res.end(content);
    });
});

const PORT = 3000;
server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
}); 