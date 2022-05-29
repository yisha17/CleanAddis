import React from 'react';
import { Link } from  'react-router-dom';
import Login from '../pages/Login';
import Companies from '../pages/Companies';
import Recycler from '../pages/Recycler';


const Navbar = () => {
  return (
    <nav className="flex justify-between items-center h-16 bg-white text-black
     relative shadow-sm font-medium">
        <Link to="/" className="pl-8 text-2xl font-black">
          CleanAddis
          </Link>
          <div className="px-4 cursor-pointer md:hidden font-normal">
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://wwwsw3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
          </div>  
          <div className="pr-8 md:block hidden font- ">
            <Link className="p-4 hover:bg-green-500 rounded-full transition duration-300 ease-in-out" to="/">Home</Link>
            <Link className="p-4 hover:bg-green-500 rounded-full transition duration-300 ease-in-out" to="/Services">Services</Link>
            <Link className="p-4 hover:bg-green-500 rounded-full transition duration-300 ease-in-out" to="/Recycler">Recycler</Link>
            <Link className="p-4 hover:bg-green-500 rounded-full transition duration-300 ease-in-out" to="/Contactus">Contact Us</Link>
            <Link className="p-4 border-4 border-green-500 rounded-full hover:bg-green-500 " to="/login">Login</Link>
          </div>
    </nav>
  );
};

export default Navbar;
