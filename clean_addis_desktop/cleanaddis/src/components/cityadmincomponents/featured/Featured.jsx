import React from 'react'
import "./featured.scss"
import MoreVertIcon from "@mui/icons-material/MoreVert"
import { CircularProgressbar, buildStyles  } from "react-circular-progressbar"
import "react-circular-progressbar/dist/styles.css";

const Featured = () => {
  return (
    <div className="featured shadow-xl shadow-green-100 p-4">
      <div className="top flex justify-between text-slate-500">
        <h1 className='title text-lg'>Total Revenue</h1>
        <MoreVertIcon fontSize="small"/>
      </div>
      <div className="bottom flex flex-col items-center justify-center">
        <div className="featuredchart items-center">
          <CircularProgressbar value={70} text={"70%"} strokeWidth={2}  styles={buildStyles({ 
             pathColor: `rgba(0, 152, 0, ${50 / 100})`,
             textColor: 'rgba(0, 152, 0, ${80 / 100})',
             trailColor: '#d6d6d6',
             backgroundColor: '#3e98c7',
            })} />
        </div>
        <p className="title items-center">
          Total reports resolved today
        </p>
        <p className="amount items-center">
         54
        </p>
      </div>
    </div>
  )
}

export default Featured
