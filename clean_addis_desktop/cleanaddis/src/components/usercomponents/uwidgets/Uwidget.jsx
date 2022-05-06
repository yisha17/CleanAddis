import React from 'react'
import "./uwidget.scss"
import WorkIcon from '@mui/icons-material/Work';
import EngineeringIcon from '@mui/icons-material/Engineering';
import ArrowUpwardIcon from '@mui/icons-material/ArrowUpward';
import NaturePeopleIcon from '@mui/icons-material/NaturePeople';
import ReportIcon from '@mui/icons-material/Report';
import CampaignIcon from '@mui/icons-material/Campaign';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
/*
--public places
--workers
--reports
--announcements
*/
const Widget = ({type}) => {
  let data;

  const amount =100;
  const diff = 20;

    switch(type){
      case "workers":
        data={
          title:"WORKERS",
          link:"See all workers",
          icon:<EngineeringIcon className="icon text-white" />
        };
          break;

        case "publicplaces":
            data={
              title:"PUBLIC PLACES",
              link:"See all public places",
              icon:<NaturePeopleIcon className="icon text-white" />
            };
              break;
      
      case "reports":
        data={
          title:"REPORTS",
          link:"See all reports",
          icon:<ReportIcon className="icon text-white" />
        };
          break;

      case "announcements":
        data={
          title:"ANNOUNCEMENTS",
          link:"See all announcements",
          icon:<CampaignIcon className="icon text-white" />
        };
          break;
      
          default:
            break;
       
    }
  return (
    <div >
      <div className="widget   p-2 content-center justify-between shadow-xl shadow-green-100 h-40  ">
        <div className="left col-auto">
          <span className="title font-bold text-xs text-gray-400">{data.title} </span>
          <span className="counter text-base font-light ">{amount}</span>
          <span className="link border-b-2  text-xs">{data.link}</span>
        </div>
        <div className="right">
          <div className="percentage positive flex self-center justify-between">
            <ArrowUpwardIcon />
            {diff}%
            </div>
          {data.icon} 
        </div>
      </div>
    </div>
  )
}

export default Widget
