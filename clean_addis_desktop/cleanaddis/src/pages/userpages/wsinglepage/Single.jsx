import "./single.scss"
import {Link} from 'react-router-dom'
import { useEffect,useState} from "react";
import Modal from "../../../components/usercomponents/wdatatable/Modal"
import getService from "../../../services/get.service";
const Single = () => {
  const [wasteData, setWasteData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getWasteSingle(id)
    .then((response) => setWasteData(response.data))
    console.log("here is the wastedata",wasteData)
}, [])
  

  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative flex ">
          <div className="flex">
          <Link to="/itadmin/waste"  onClick={<Modal />}> 
           <div className="editButton  border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer">close</div>
          </Link>
          </div> 
          
          <div className="item flex gap-5"> 
          <img src={wasteData.image}
          alt="" className="imgitem w-32 h-32 object-cover  rounded-full"  /> 
          <div className="details">
            <h1 className="itemname text-4xl m-5">Waste </h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Name:</span>
              <span className="itemvalue font-light ml-3">{wasteData.waste_name}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Type:</span>
              <span className="itemvalue font-light ml-3">{wasteData.waste_type}</span>
            </div>        
            
            
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Description:</span>
              <span className="itemvalue font-light ml-3">{wasteData.description}</span>
            </div>        
            
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">For:</span>
              <span className="itemvalue font-light ml-3">{wasteData.for_waste}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">Posted by:</span>
              <span className="itemvalue font-light ml-3">{wasteData.seller}</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">Posted On:</span>
              <span className="itemvalue font-light ml-3">{wasteData.post_date}</span>
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


export default Single
