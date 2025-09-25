import React, { useState, useEffect } from 'react'
import axios from 'axios'
import './App.css'

function App() {
  const [apiStatus, setApiStatus] = useState(null)
  const [users, setUsers] = useState([])
  const [kubernetesInfo, setKubernetesInfo] = useState(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState(null)

  const API_BASE_URL = process.env.NODE_ENV === 'production' 
    ? '/api'
    : 'http://localhost:8080/api'

  const fetchApiStatus = async () => {
    try {
      const response = await axios.get(`${API_BASE_URL}/status`)
      setApiStatus(response.data)
    } catch (err) {
      console.error('Failed to fetch API status:', err)
    }
  }

  const fetchUsers = async () => {
    setLoading(true)
    setError(null)
    try {
      const response = await axios.get(`${API_BASE_URL}/users`)
      console.log('Users API response:', response.data)
      // Ensure we have a valid response structure
      if (response.data && response.data.users) {
        setUsers(response.data.users)
      } else {
        console.warn('Invalid users response structure:', response.data)
        setUsers([])
      }
    } catch (err) {
      setError('Failed to fetch users')
      console.error('Failed to fetch users:', err)
      setUsers([]) // Set to empty array on error
    } finally {
      setLoading(false)
    }
  }

  const fetchKubernetesInfo = async () => {
    try {
      const response = await axios.get(`${API_BASE_URL}/kubernetes`)
      console.log('Kubernetes API response:', response.data)
      // Ensure we have a valid response structure
      if (response.data) {
        setKubernetesInfo(response.data)
      } else {
        console.warn('Invalid Kubernetes response structure:', response.data)
        setKubernetesInfo(null)
      }
    } catch (err) {
      console.error('Failed to fetch Kubernetes info:', err)
      setKubernetesInfo(null)
    }
  }

  useEffect(() => {
    fetchApiStatus()
    fetchUsers()
    fetchKubernetesInfo()
  }, [])

  // Add debugging info
  console.log('App render - users:', users, 'kubernetesInfo:', kubernetesInfo)

  return (
    <div className="app">
      <header className="app-header">
        <h1>🚀 Kubernetes Demo Application</h1>
        <p>Showcasing microservices with React frontend and Node.js backend</p>
      </header>

      <main className="app-main">
        {/* API Status Card */}
        <div className="card">
          <h2>📊 API Status</h2>
          {apiStatus ? (
            <div className="status-info">
              <p><strong>Status:</strong> {apiStatus.message}</p>
              <p><strong>Version:</strong> {apiStatus.version}</p>
              <p><strong>Environment:</strong> {apiStatus.environment}</p>
              <p><strong>Last Updated:</strong> {new Date(apiStatus.timestamp).toLocaleString()}</p>
            </div>
          ) : (
            <p>Loading API status...</p>
          )}
        </div>

        {/* Users Card */}
        <div className="card">
          <h2>👥 Users</h2>
          <button onClick={fetchUsers} disabled={loading}>
            {loading ? 'Loading...' : 'Refresh Users'}
          </button>
          {error && <p className="error">{error}</p>}
          {users && Array.isArray(users) && users.length > 0 && (
            <div className="users-list">
              {users.map(user => (
                <div key={user.id} className="user-item">
                  <h3>{user.name}</h3>
                  <p>📧 {user.email}</p>
                  <p>👤 {user.role}</p>
                </div>
              ))}
            </div>
          )}
          {users && Array.isArray(users) && users.length === 0 && (
            <p>No users found</p>
          )}
        </div>

        {/* Kubernetes Info Card */}
        <div className="card">
          <h2>☸️ Kubernetes Information</h2>
          {kubernetesInfo ? (
            <div className="k8s-info">
              <p><strong>Message:</strong> {kubernetesInfo.message}</p>
              <div className="features">
                <h3>Features:</h3>
                <ul>
                  {kubernetesInfo.features && Array.isArray(kubernetesInfo.features) && kubernetesInfo.features.map((feature, index) => (
                    <li key={index}>✅ {feature}</li>
                  ))}
                </ul>
              </div>
              <div className="cluster-info">
                <h3>Cluster Info:</h3>
                <p><strong>Node:</strong> {kubernetesInfo.cluster?.node || 'N/A'}</p>
                <p><strong>Namespace:</strong> {kubernetesInfo.cluster?.namespace || 'N/A'}</p>
              </div>
            </div>
          ) : (
            <p>Loading Kubernetes information...</p>
          )}
        </div>

        {/* Architecture Card */}
        <div className="card">
          <h2>🏗️ Architecture</h2>
          <div className="architecture">
            <div className="component">
              <h3>Frontend</h3>
              <p>React + Vite</p>
              <p>Port: 3000</p>
            </div>
            <div className="arrow">→</div>
            <div className="component">
              <h3>Backend</h3>
              <p>Node.js + Express</p>
              <p>Port: 8080</p>
            </div>
            <div className="arrow">→</div>
            <div className="component">
              <h3>Kubernetes</h3>
              <p>Deployments</p>
              <p>Services & Ingress</p>
            </div>
          </div>
        </div>
      </main>

      <footer className="app-footer">
        <p>Frontend: React + Vite | Backend: Node.js + Express</p>
      </footer>
    </div>
  )
}

export default App
