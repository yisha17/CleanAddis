
import './App.css';
import Navbar from './components/Navbar';
import Cleanaddis from './components/Cleanaddis';
import Services from './pages/Services';
import Login from './pages/Login';
import { Routes } from 'react-router-dom';
import {BrowserRouter, Route} from 'react-router-dom';
import Hero from './components/Hero';
import Footer from './components/Footer';
import Home from './pages/adminpages/home/Home';
function App() {
  
  return (
  
    <>
      <Navbar />
      <Cleanaddis />
      <Hero />
      <Footer />
    </>
  );
}

export default App;
