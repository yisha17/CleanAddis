import React from 'react'
import { userrole } from './LoginForm'
import { Navigate, Outlet } from 'react-router'
import authHeader from '../services/auth-header'
import getService from '../services/get.service';
import {decodeToken } from "react-jwt";
import {useState, useEffect} from "react";
import Uhome from './userpages/uhome/Uhome';
import Home from './adminpages/home/Home'

function firstFunction(){
    let data;
    let check;
    var user = JSON.parse(localStorage.getItem("user"))
    var id;
    var role
    if (user){
        user = JSON.parse(localStorage.getItem("user"))
        data = `"${user.role}"`
        role = data
        check = "City Admin"
        if (role === `"${check}"`){
            return true
        }
        else{
            return false
        }
    }
    else{
        return false
    }
    
    
        
}

const Cityroute = () => {
    
    return (
        
        firstFunction() ? <Outlet /> : <Navigate to="/login"/>
    )
}

export default Cityroute;
