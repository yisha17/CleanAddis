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
const isrecycler = () =>
    getService.getUserRole(id).then(
    (response)=>{
    userinfo = response.data
    if ((userinfo.role) == "recycler"){
        return true 
    }
    else{
        return(
            false
        )
    }
    })
const Recyclerroute = () => {
        const info = isrecycler()
        return isadmin ? <Outlet /> : <Navigate to="/login" />
}

export default Recyclerroute
