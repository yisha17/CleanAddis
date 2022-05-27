import React from 'react'
import Navbar from '../components/Navbar'
import LoginForm from './LoginForm'
const Login = () => {
  return (
    <div className="justify center items-center">
    <Navbar />
    <div className="justify-center items-center"><LoginForm /></div>
    </div> 
  
  )
}

export default Login
