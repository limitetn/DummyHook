import React from 'react'
import ReactDOM from 'react-dom/client'
import './style.css'
import DemoOne from './components/ui/demo.tsx'

ReactDOM.createRoot(document.getElementById('app')!).render(
  <React.StrictMode>
    <DemoOne />
  </React.StrictMode>,
)