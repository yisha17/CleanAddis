//import "./cityadminsidebar.scss"
import { useState } from "react"
import React from 'react'
import Arrow from './Arrow.png'

const CityadminSidebar = () => {
  const [open,setOpen] = useState(true);
  return (

      <div className={`${open ? "w-72" : "w-20"} duration-300 h-screen bg-green-500  relative`}>
        
      <img src={Arrow}   className={`absolute cursor-pointer rounded-full right-3 top-9 w-7 border-2  
      border-green-500 rotate  ${!open && "rotate-180"}`}
      onClick={()=>setOpen(!open)}/>
      <h2 className="text-white -semibold">City Admin</h2>
         
      </div>

  )
}

export default CityadminSidebar
