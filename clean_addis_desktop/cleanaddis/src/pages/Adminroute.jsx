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
        user = JSON.parse(localStorage.getItem("user"))
        token = `"${user.access}"`
        const decoder = () => decodedToken = decodeToken(token) 
        id = decoder().user_id
        userinfo = ""
        getService.getUserRole(id).then(
            (response)=>{
            userinfo = response.data
            console.log("admiroute user info is ",userinfo)
            if ((userinfo.is_superuser) === true){
                return true
                
            }
            else{  
                return false
                 
            }})
    }
    else{
        console.log("there is no user")
        return false
    }
    
    
        
}

const Adminroute = () => {
    
    
    return (
        firstFunction ? <Outlet /> : <Navigate to="/notadmin"/>
    )
}

export default Adminroute;
