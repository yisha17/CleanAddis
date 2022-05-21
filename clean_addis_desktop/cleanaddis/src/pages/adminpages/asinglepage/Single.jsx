import "./single.scss"
import {Link} from 'react-router-dom'
import Modal from "../../../components/cityadmincomponents/adatatable/Modal"
const Asingle = () => {
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
          <h1 className="title flex p-10 gap-5">Information</h1>
          <div className="item flex gap-5"> 
          <img src="https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80" 
          alt="" className="imgitem w-32 h-32 object-cover  rounded-full"  /> 
          <div className="details">
            <h1 className="itemname text-4xl m-5">Announcement </h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">title:</span>
              <span className="itemvalue font-light ml-3">Cleaning</span>
            </div>     
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">from:</span>
              <span className="itemvalue font-light ml-3">12/03/2021</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">to:</span>
              <span className="itemvalue font-light ml-3">12/03/2021</span>
            </div> 
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold ">for:</span>
              <span className="itemvalue font-light ml-3">yeka subcity</span>
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
