import "./single.scss"
import {Link} from 'react-router-dom'
import { useEffect,useState} from "react";
import Modal from "../../../components/cityadmincomponents/adatatable/Modal"
import getService from "../../../services/get.service";
const Asingle = () => {
  const [announcementData, setAnnouncementData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getAnnouncementSingle(id)
    .then((response) => setAnnouncementData(response.data))
    console.log("here is the announcementdata",announcementData)
}, [])
  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative flex ">
          <div className="flex">
          <Link to="/cityadmin/announcement"  onClick={<Modal />}> 
           <div className="editButton  border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer">close</div>
          </Link>
          </div> 
          
          <div className="item flex gap-5">  
          <div className="details">
            <h1 className="itemname text-4xl m-5">Announcement </h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Title:</span>
              <span className="itemvalue font-light ml-3">{announcementData.notification_title}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Description:</span>
              <span className="itemvalue font-light ml-3">{announcementData.notification_body}</span>
            </div>        
            
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">For:</span>
              <span className="itemvalue font-light ml-3">{announcementData.address}</span>
            </div> 
                   
          </div>
          </div>
        </div>
        
      </div>
     
    </div>
    </div>
    </div>
  );
};


export default Asingle
