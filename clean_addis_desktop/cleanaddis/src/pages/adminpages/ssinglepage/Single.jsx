import "./single.scss"
import {Link} from 'react-router-dom'
import Modal from "../../../components/cityadmincomponents/sdatatable/Modal"
import getService from "../../../services/get.service";
import { useEffect,useState} from "react";
const Asingle = () => {
  const [seminarData, setSeminarData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getSeminarSingle(id)
    .then((response) => setSeminarData(response.data))
}, [])
  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative flex ">
          <div className="flex">
          <Link to="/cityadmin/seminar"  onClick={<Modal />}> 
           <div className="editButton  border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer">close</div>
          </Link>
          </div> 
          
          <div className="item flex gap-5"> 
          <img src={seminarData.imageLink} 
          alt="" className="imgitem w-32 h-32 object-cover  rounded-full"  /> 
          <div className="details">
            <h1 className="itemname text-4xl m-5">Seminar </h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Title:</span>
              <span className="itemvalue font-light ml-3">{seminarData.seminarTitle}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Link:</span>
              <span className="itemvalue font-light ml-3">{seminarData.link}</span>
            </div>        
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">From:</span>
              <span className="itemvalue font-light ml-3">{seminarData.fromDate}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">To:</span>
              <span className="itemvalue font-light ml-3">{seminarData.toDate}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">Type:</span>
              <span className="itemvalue font-light ml-3">{seminarData.seminarType}</span>
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
