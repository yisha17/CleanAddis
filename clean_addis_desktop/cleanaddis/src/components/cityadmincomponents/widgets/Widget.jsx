import React from 'react'
import "./widget.scss"
import WorkIcon from '@mui/icons-material/Work';
import ArrowUpwardIcon from '@mui/icons-material/ArrowUpward';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
const Widget = () => {
  return (
    <div >
      <div className="widget   p-2 content-center justify-between shadow-xl h-40  ">
        <div className="left col-auto">
          <span className="title font-bold text-xs text-gray-400">USERS </span>
          <span className="counter text-base font-light ">23123 </span>
          <span className="link border-b-2  text-xs">see all users</span>
        </div>
        <div className="right">
          <div className="percentage positive flex self-center justify-between">
            <ArrowUpwardIcon />
            20%
            </div>
          <WorkIcon className="icon text-white "/>
        </div>
      </div>
    </div>
  )
}

export default Widget
