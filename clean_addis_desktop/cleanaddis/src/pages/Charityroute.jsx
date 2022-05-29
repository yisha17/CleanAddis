import React from 'react'
import { userrole } from './LoginForm'
import { Navigate, Outlet } from 'react-router'
import authHeader from '../services/auth-header'
import getService from '../services/get.service';
import {decodeToken } from "react-jwt";
import {useState, useEffect} from "react";
import Uhome from './userpages/uhome/Uhome';
let t
function firstFunction(){
    let token ;
    var decodedToken;
    var id;
    var userinfo
    var user = JSON.parse(localStorage.getItem("user"))
    if (user){
        console.log("there is  user")
        token = `"${user.access}"`
        const decoder = () => decodedToken = decodeToken(token) 
        id = decoder().user_id
        userinfo = ""
        
        getService.getUserRole(id).then(
            (response)=>{
            userinfo = response.data
            if ((userinfo.role) === "City Admin"){
                t = true
                
            }
            else{  
                t = false
                 
            }},
            (error)=>{
                t = false
            })
    }
    else{
        console.log("there is no user")
        t = false
    }
    
    
        
}
firstFunction()
const Charityroute = () => {
    return (
        t ? <Outlet /> : <Navigate to="/login"/>
    )
}

export default Charityroute;
