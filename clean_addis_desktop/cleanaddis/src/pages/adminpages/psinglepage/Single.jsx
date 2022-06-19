import "./single.scss"
import {Link} from 'react-router-dom'
import Modal from "../../../components/cityadmincomponents/pdatatable/Modal"
import getService from "../../../services/get.service";
import editService from '../../../services/edit.service';
import { useState,useEffect } from "react";

const Asingle = () => {
  const [publicData, setPublicData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getPublicPlaceSingle(id)
    .then((response) => setPublicData(response.data))
   
}, [])
  const Longitude = publicData.longitude
  const Latitude =  publicData.latitude  
  const location = `https://maps.google.com/maps?q=${Longitude},${Latitude}&t=&z=13&ie=UTF8&iwloc=&output=embed`
  const [showMyModal,setShowMyModal]  = useState(false)
  const handleOnCLose = () => setShowMyModal(false)
  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative flex ">
          <div className="flex">
          <Link to="/cityadmin/publicplace"  onClick={<Modal />}> 
           <div className="editButton  border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer">close</div>
          </Link>
          </div> 
          
          <div className="item flex gap-5"> 

          <div className="details">
            <h1 className="itemname text-4xl m-5">Public Place</h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Name:</span>
              <span className="itemvalue font-light ml-3">{publicData.placeName}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Type:</span>
              <span className="itemvalue font-light ml-3">{publicData.placeType}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Rating:</span>
              <span className="itemvalue font-light ml-3">{publicData.rating}</span>
            </div>        
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Location:</span>
              <iframe className="h-64 w-64"src={location} allowfullscreen ></iframe>
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
