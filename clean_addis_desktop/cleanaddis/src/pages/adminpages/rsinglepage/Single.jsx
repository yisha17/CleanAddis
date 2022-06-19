import "./single.scss"
import { Link } from "react-router-dom";
import { useState,useEffect } from "react";
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"
import getService from "../../../services/get.service";
import editService from '../../../services/edit.service';
import {MapContainer, TileLayer} from 'react-leaflet';



const Rsingle = () => {
  const [reportData, setReportData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getReportSingle(id)
    .then((response) => setReportData(response.data))
    console.log("here is the reportdata",reportData)
}, [])
  const Longitude = reportData.longitude
  const Latitude =  reportData.latitude
const Resolvereport = (Longitude,Latitude,isResolved,id) => async (e) =>{
  e.preventDefault();
  if(status == "Resolved"){
    alert("report is already resolved")
    return true
  }
  else{
  console.log("here is the request",reportData.longitude)
  await editService.resolvereport(Longitude,Latitude,isResolved,id).then(
    (response)=>{
      alert("report Resolved")
      
    },
    (error) => {
        console.log(error);
    }
);
  }};
  var status = ""
  if(reportData.isResolved == true){
    status = "Resolved"
  }
  else{
    status = "pending"
  }
  
  const location = `https://maps.google.com/maps?q=${Longitude},${Latitude}&t=&z=13&ie=UTF8&iwloc=&output=embed`
  const [showMyModal,setShowMyModal]  = useState(false)
  const handleOnCLose = () => setShowMyModal(false)
  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-20 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative pr- ">
          <Link to="/cityadmin/report"  onClick={<Modal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
          <div className="item flex gap-10"> 
          <img src={reportData.image} 
          alt="" className="imgitem w-64 h-64 object-cover  "  /> 
          <div className="details">
            <h1 className="itemname text-4xl m-5">Report</h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Report Title:</span>
              <span className="itemvalue font-light ml-3">{reportData.reportTitle}</span>
            </div>     
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">ReportDescription:</span>
              <span className="itemvalue font-light ml-3">{reportData.reportTitle}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">Reported by:</span>
              <span className="itemvalue font-light ml-3">{reportData.reportedBy}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Location:</span>
             <iframe className="h-64 w-64"src={location} allowfullscreen ></iframe>
              </div> 
              <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">Reported by:</span>
              <span className="itemvalue font-light ml-3">{status}</span>
            </div> 
            <Link to="/cityadmin/report"  onClick={Resolvereport(Longitude,Latitude,true,id)}> <div className="cursor-pointer border-2 w-16 items-center flex justify-center hover:bg-green-300">Resolve</div>
           </Link>
            <div>

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


export default Rsingle
