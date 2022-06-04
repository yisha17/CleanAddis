import React from 'react'
import {useState,useEffect} from 'react'
import getService from '../services/get.service';
import AuthService from '../services/auth.service';
import {decodeToken } from "react-jwt";
import { Link, useNavigate } from 'react-router-dom';

const ProfileForm = () => {
    let token ;
    var decodedToken;
    var id;
    var userinfo
    var user = JSON.parse(localStorage.getItem("user"))
    const [userData, setUserData] = useState([])
    const navigate = useNavigate()
    if (user){
        user = JSON.parse(localStorage.getItem("user"))
        token = `"${user.access}"`
        const decoder = () => decodedToken = decodeToken(token) 
        id = decoder().user_id
        userinfo = []
       
    }
    useEffect(() => {getService.getUserRole(id)
        .then((response) => setUserData(response.data))
        console.log("here is the userdata",userData.email)
    }, [])
    function HandleLogout()  {
        AuthService.logout();
        navigate("/login")
    }
            
  return (
    <div class="h-screen bg-green-400 py-20 px-3">
    
    <div class="max-w-md mx-auto md:max-w-lg">
        <div class="w-full">
            <div class="bg-white p-3 rounded text-center py-5">
                <div class="flex justify-center">
                    <img class="rounded-full"  width="100"/>Image
                </div>
                
                <div class="text-center">
                    <h1 class="text-2xl mt-2">{userData.first_name} {userData.last_name}</h1>

                    <div class="flex justify-between mt-3 px-4">
                        <div  class="flex flex-col">
                            <span class="font-bold text-1xl"><h1>{userData.first_name}</h1></span>
                            <span class="text-sm text-green-600">First Name</span>
                        </div>
                        
                        <div  class="flex flex-col">
                            <span class="font-bold text-1xl">{userData.last_name}</span>
                            <span class="text-sm text-green-600">Last Name</span>
                        </div>
                        
                        <div  class="flex flex-col">
                            <span class="font-bold text-1xl">{userData.username}</span>
                            <span class="text-sm text-green-600">Username</span>
                        </div>
                    </div>
                    <div class="flex justify-between mt-3 px-4">
                        <div  class="flex flex-col">
                            <span class="font-bold text-1xl">{userData.role}</span>
                            <span class="text-sm text-green-600">Role</span>
                        </div>
                        
                        <div  class="flex flex-col">
                            <span class="font-bold text-1xl">{userData.device_id}</span>
                            <span class="text-sm text-green-600">Device ID</span>
                        </div>
                        
                        <div  class="flex flex-col">
                            <span class="font-bold text-1xl">{userData.email}</span>
                            <span class="text-sm text-green-600">Email</span>
                        </div>
                    </div>
                    
                    <div class="flex flex-row px-4 mt-4">
                        <button class="h-10 w-full text-white text-md rounded bg-green-700 hover:bg-green-400">Edit</button>
                        <button onClick={HandleLogout}class="h-10 w-full text-white text-md rounded bg-red-500 hover:bg-red-800 ml-2">Logout</button>
                    </div>
                    
                    
                </div>
            </div>
        </div>
    </div>
    
</div>
  );
}

export default ProfileForm;
