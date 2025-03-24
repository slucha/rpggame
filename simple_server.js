// Simple Express server to serve static HTML files
const express = require('express');
const path = require('path');
const app = express();
const PORT = 8080;

// Get Gitpod workspace info from environment variables
const gitpodWorkspaceId = process.env.GITPOD_WORKSPACE_ID || '';
const gitpodWorkspaceUrl = process.env.GITPOD_WORKSPACE_URL || '';

// Add CORS headers to all responses
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

// Log all incoming requests
app.use((req, res, next) => {
  console.log(`Request: ${req.method} ${req.path}`);
  console.log(`Headers:`, req.headers);
  next();
});

// Serve static files from the public directory
app.use(express.static(path.join(__dirname, 'public')));

// Direct string response - most basic possible response
app.get('/hello', (req, res) => {
  res.send('Hello, world! If you can see this text, basic HTTP is working.');
});

// Direct JSON response
app.get('/api/test', (req, res) => {
  res.json({ 
    message: 'This is a direct JSON response from Express', 
    time: new Date().toISOString(),
    workspaceId: gitpodWorkspaceId ? gitpodWorkspaceId : 'Not in Gitpod'
  });
});

// Home page route
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Game page route
app.get('/game', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'game.html'));
});

// Offline page route
app.get('/offline', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'offline.html'));
});

// Test page route
app.get('/test', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'test.html'));
});

// Minimal test page route
app.get('/minimal', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'minimal.html'));
});

// Health check route
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok', message: 'Server is running' });
});

// Fallback route for any other path
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'offline.html'));
});

// Start the server - listen on all network interfaces
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running at http://localhost:${PORT}`);
  console.log(`You can access the game at http://localhost:${PORT}/game`);
  console.log(`You can access the test page at http://localhost:${PORT}/test`);
  console.log(`You can access the minimal page at http://localhost:${PORT}/minimal`);
  
  // Create and display Gitpod URL if available
  if (gitpodWorkspaceId) {
    const gitpodUrl = `https://8080-${gitpodWorkspaceId}.${gitpodWorkspaceUrl.split('//')[1].split('.')[1]}.gitpod.io`;
    console.log(`\nGitpod URL: ${gitpodUrl}`);
    console.log(`Game URL: ${gitpodUrl}/game`);
    console.log(`Test URL: ${gitpodUrl}/test`);
    console.log(`Minimal URL: ${gitpodUrl}/minimal`);
    console.log(`Hello URL: ${gitpodUrl}/hello`);
    console.log(`API Test URL: ${gitpodUrl}/api/test`);
  } else {
    console.log('\nFor Gitpod, use the URL provided in the Gitpod UI for port 8080');
  }
}); 