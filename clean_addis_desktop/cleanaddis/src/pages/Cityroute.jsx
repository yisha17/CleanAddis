import React from 'react'
import { userrole } from './LoginForm'
import { Navigate, Outlet } from 'react-router'
import authHeader from '../services/auth-header'
import getService from '../services/get.service';
import {decodeToken } from "react-jwt";
import {useState, useEffect} from "react";
import Uhome from './userpages/uhome/Uhome';
import Home from './adminpages/home/Home'
let t
function firstFunction(){
    let token ;
    var decodedToken;
    var id;
    var userinfo;
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
            console.log("cityroute user info is ",userinfo)
            if ((userinfo.role) === "City Admin"){
                return true
                
            }
            else{  
                return false
                 
            }},
            (error)=>{
                return false
            })
    }
    else{
        console.log("there is no user")
        return false
    }
    
    
        
}

const Cityroute = () => {
    
    return (
        
        firstFunction ? <Outlet /> : <Navigate to="/notcity"/>
    )
}

export default Cityroute;
