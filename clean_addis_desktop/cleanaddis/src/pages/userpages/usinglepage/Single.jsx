import "./single.scss"
import {Link} from 'react-router-dom'
import {useState,useEffect} from 'react';
import Modal from "../../../components/usercomponents/udatatable/Modal";
import getService from "../../../services/get.service";

const Asingle = () => {
  const [userData, setUserData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getUserSingle(id)
    .then((response) => setUserData(response.data))
}, [])
  return (
    <div>
      <div className="single flex">
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative flex ">
          <div className="flex">
          <Link to="/itadmin/user"  onClick={<Modal />}> 
           <div className="editButton  border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer">close</div>
          </Link>
          </div> 
          
          <div className="item flex gap-5"> 
          <img src={userData.profile}
          alt="" className="imgitem w-32 h-32 object-cover  rounded-full"  /> 
          <div className="details">
            <h1 className="itemname text-4xl m-5">User </h1>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Name:</span>
              <span className="itemvalue font-light ml-3">{userData.firstname} {userData.last_name}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Username:</span>
              <span className="itemvalue font-light ml-3">{userData.username}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Role</span>
              <span className="itemvalue font-light ml-3">{userData.role}</span>
            </div>        
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Email</span>
              <span className="itemvalue font-light ml-3">{userData.email}</span>
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
