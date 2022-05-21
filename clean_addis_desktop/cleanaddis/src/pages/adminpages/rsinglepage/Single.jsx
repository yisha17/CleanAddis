import "./single.scss"
import { Link } from "react-router-dom";
import { useState } from "react";
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Rsingle = () => {
  const [showMyModal,setShowMyModal]  = useState(false)
  const handleOnCLose = () => setShowMyModal(false)
  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative pr- ">
          <Link to="/cityadmin/report"  onClick={<Modal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
          <div className="item flex gap-5"> 
          <img src="https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80" 
          alt="" className="imgitem w-32 h-32 object-cover  rounded-full"  /> 
          <div className="details">
            <h1 className="itemname text-4xl m-5">Report</h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Report Title:</span>
              <span className="itemvalue font-light ml-3">Cleaning</span>
            </div>     
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">ReportDescription:</span>
              <span className="itemvalue font-light ml-3">12/03/2021</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Location:</span>
              <span className="itemvalue font-light ml-3"></span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">Reported by:</span>
              <span className="itemvalue font-light ml-3">someone</span>
            </div> 
            <Link to="/cityadmin/report"  onClick={<Modal />}> <div className="cursor-pointer border-2 w-16 items-center flex justify-center hover:bg-green-300">Resolve</div>
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
