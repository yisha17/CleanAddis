import React from 'react'
import { userrole } from './LoginForm'
import { Navigate, Outlet } from 'react-router'
import authHeader from '../services/auth-header'
import getService from '../services/get.service';
import {decodeToken } from "react-jwt";
import {useState, useEffect} from "react";
import Uhome from './userpages/uhome/Uhome';

const user = JSON.parse(localStorage.getItem("user"))
let token = "";
token = `"${user.access}"`
const decodedToken = decodeToken(token)
const id = decodedToken.user_id
var userinfo = ""
const isadmin = () =>
    getService.getUserRole(id).then(
    (response)=>{
    userinfo = response.data
    //console.log("here is the role from the protected route",userinfo.is_superuser)
    if ((userinfo.is_superuser) == true){
        return true 
    }
    else{
        return(
            false
        )
    }
    })
const Adminroute = () => {
        const info = isadmin()
        return isadmin ? <Outlet /> : <Navigate to="/login" />
}

export default Adminroute
