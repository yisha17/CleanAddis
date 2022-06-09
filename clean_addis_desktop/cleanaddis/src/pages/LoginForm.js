import React from 'react';
import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import Navbar from '../components/Navbar';
import AuthService from '../services/auth.service';
import getService from '../services/get.service';
import "./login.css"
import { isExpired, decodeToken } from "react-jwt";

export var userrole = ""
function LoginForm({ Login, error }) {
    AuthService.logout();
    const [username,setUsername] = useState("");
    const [password,setPassword] = useState("");


  const navigate  = useNavigate();
  
  let token = "";
  var id = 0;
  var userdetail = [];
  

  const HandleLogin = async (e) =>{
      e.preventDefault();
      try{
         
          await AuthService.login(username,password).then(
              (response)=>{
                token = `"${response}"`
                const decodedToken = decodeToken(token)
                id = decodedToken.user_id  
              },
              (error) => {
                
                  console.log(error);
              }
          );
          await getService.getUserRole(id).then(
            (response)=>{
              if ((response.data.is_superuser) === true){
                    navigate("/itadmin")
                    console.log("it is admin")
                    
              }
              else if ((response.data.role) === "City Admin"){
                console.log("it is cityadmin")
                navigate("/cityadmin")
                
              }
              else if ((response.data.role) ==="charity"){
                navigate("/charity")
                
              }
              else if ((response.data.role) ==="recycler"){
                navigate("/recycler")
              }
              else {
                navigate("/login")
              }
              
            },
            (error) => {
              navigate("/")
              console.log(error);
          }
          );
        
        }catch(err){
            navigate("/login")
            console.log(err);
        }
    };
  return (

    <div>
        <form onSubmit={HandleLogin}>
        <section class="h-screen">
  <div class="px-6 h-full text-gray-800">
    <div
      class="flex xl:justify-center lg:justify-between justify-center items-center flex-wrap h-full g-6"
    >
      <div
        class="grow-0 shrink-1 md:shrink-0 basis-auto xl:w-6/12 lg:w-6/12 md:w-9/12 mb-12 md:mb-0"
      >
        <img
          src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw1.webp"
          class="w-full"
          alt="Sample image"
        />
      </div>
      <div class="xl:ml-20 xl:w-5/12 lg:w-5/12 md:w-8/12 mb-12 md:mb-0">
       
          <div class="mb-6">
            <input
              type="text"
              class="form-control block w-full px-4 py-2 text-xl font-normal text-green-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              id="username"
              placeholder="Username"
              value={username}
              onChange={(e)=> setUsername(e.target.value)}
            />
          </div>

          <div class="mb-6">
            <input
              type="password"
              class="form-control block w-full px-4 py-2 text-xl font-normal text-green-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-green-700 focus:bg-white focus:border-blue-600 focus:outline-none"
              id="exampleFormControlInput2"
              placeholder="Password"
              value={password}
              onChange={(e)=>setPassword(e.target.value)}
            /> 
          </div>

          <div class="flex justify-between items-center mb-6">
            <div class="form-group form-check">
              <input
                type="checkbox"
                class="form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-green-600 checked:border-green-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain float-left mr-2 cursor-pointer"
                id="exampleCheck2"
              />
              <label class="form-check-label inline-block text-gray-800" for="exampleCheck2"
                >Remember me</label
              >
            </div>
            <a href="#!" class="text-gray-800">Forgot password?</a>
          </div>

          <div class="text-center lg:text-left">
            <button
              type="submit"
              class="inline-block px-7 py-3 bg-green-600 text-white font-medium text-sm leading-snug uppercase rounded shadow-md hover:bg-green-400 hover:shadow-lg focus:bg-green-400 focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out"
            >
              Login
            </button>
            
          </div>
        
      </div>
    </div>
  </div>1
</section>
</form>
    </div>
  )
}

export default LoginForm;

