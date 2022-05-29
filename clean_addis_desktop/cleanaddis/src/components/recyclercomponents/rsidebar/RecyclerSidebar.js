//import "./cityadminsidebar.scss"
import { useState } from "react"
import React from 'react'
import Arrow from './Arrow.png'
import Dashboard from './Dashboard.png'
import User from './User.png'
import Shout from './Shout.png'
import Work from './Work.png'
import Report from './Report.png'
import Uhome from '../../../pages/userpages/uhome/Uhome';
import {Link } from "react-router-dom"

const CityadminSidebar = () => {
  const [open,setOpen] = useState(true);
  const Menus =[
    {title:"Profile", src:User ,link:"/recycler/"},
    {title:"Waste", src:Report,link:"/recycler/waste"},
 
  ]
  return (

      <div className={`${open ? "w-72" : "w-20"} duration-300 h-screen p-5 pt-8 bg-green-500  relative`}>
        
      <img src={Arrow}   className={`absolute cursor-pointer rounded-full right-3 top-9 w-7 border-2  
      border-green-500 rotate  ${!open && "rotate-180"}`}
      onClick={()=>setOpen(!open)}/>
      <div className="flex gap-x-4 items-left">
        <Link to="/user">
      <h2 className={`text-white origin-left font-medium text-x1 duration-300`}>Recycler</h2>
      </Link>
      </div>
      <ul>
        {Menus.map((menu,index)=>(
       <Link to={menu.link}>
          <li key={index}
              className={`text-white text-sm font-medium flex items-center 
              gap-x-2  pt-8 cursor-pointer hover:bg-green-600 rounded-md`
              }>
            
             <img src={menu.src}  />
             <span className={`${!open && 'hidden'} origin-left duration-200`}>
             {menu.title} </span>
              
          </li>
          </Link>
        ))}
      </ul>
      </div>

  )
}

export default CityadminSidebar
