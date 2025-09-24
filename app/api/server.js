const express = require('express');
const cors = require('cors');
const helmet = require('helmet');

const app = express();
const PORT = process.env.PORT || 8080;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'healthy', 
    timestamp: new Date().toISOString(),
    service: 'k8s-demo-api'
  });
});

// API routes
app.get('/api/status', (req, res) => {
  res.json({
    message: 'Kubernetes Demo API is running!',
    version: '1.0.0',
    environment: process.env.NODE_ENV || 'development',
    timestamp: new Date().toISOString()
  });
});

app.get('/api/users', (req, res) => {
  const users = [
    { id: 1, name: 'Alice Johnson', email: 'alice@example.com', role: 'Developer' },
    { id: 2, name: 'Bob Smith', email: 'bob@example.com', role: 'DevOps Engineer' },
    { id: 3, name: 'Carol Davis', email: 'carol@example.com', role: 'Platform Engineer' }
  ];
  
  res.json({
    users,
    count: users.length,
    timestamp: new Date().toISOString()
  });
});

app.get('/api/kubernetes', (req, res) => {
  res.json({
    message: 'Welcome to the Kubernetes Demo!',
    features: [
      'Containerized microservices',
      'Service discovery',
      'Load balancing',
      'Health checks',
      'Ingress routing'
    ],
    cluster: {
      node: process.env.HOSTNAME || 'unknown',
      namespace: process.env.NAMESPACE || 'default'
    }
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Something went wrong!',
    message: err.message 
  });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({ 
    error: 'Not Found',
    message: `Route ${req.originalUrl} not found` 
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 K8s Demo API server running on port ${PORT}`);
  console.log(`📊 Health check available at /health`);
  console.log(`🔗 API endpoints available at /api/*`);
});
