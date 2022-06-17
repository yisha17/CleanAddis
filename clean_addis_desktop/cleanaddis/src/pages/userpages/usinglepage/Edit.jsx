import React from 'react'
import { Link } from 'react-router-dom'
import Editormodal from '../../../components/usercomponents/udatatable/Edit'
import { useEffect,useState} from "react";
import getService from "../../../services/get.service";
import editService from '../../../services/edit.service';

const Edit = () => {
  const [role,setRole] = useState("");
  const [userData, setUserData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getUserSingle(id)
    .then((response) => setUserData(response.data))
    //console.log("data",announcementData.notification_title)//.then(
    //)
    
}, [])

const Editrole = (id) => async (e) =>{
  e.preventDefault();

  await editService.editrole(role,id).then(
    (response)=>{
      alert("Role Updated")
    },
    (error) => {
        console.log(error);
    }
);
  };
  return (
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/itadmin/user"  onClick={<Editormodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Edit User   </h1>
        <form onSubmit={Editrole(id)}>
        
          <img src={userData.profile}
          alt="" className="imgitem w-32 h-32 object-cover  rounded-full"  /> 
          <div className="details">
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Name:</span>
              <span className="itemvalue font-light ml-3">{userData.firstname} {userData.last_name}</span>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Username:</span>
              <span className="itemvalue font-light ml-3">{userData.username}</span>
            </div>
            </div>
            <div className="detailedItem mb-3 text-lg text-gray-600">
              <span className="itemkey font-bold">Email</span>
              <span className="itemvalue font-light ml-3">{userData.email}</span>
            </div> 
            
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Role</label>
                <select name="role" id="role"
                 placeholder="address"
                 onChange={(e)=> setRole(e.target.value)}
                 >
                  <option value="cityadmin">City Admin</option>
                  <option value="recycler">Recycler</option>
                  <option value="qorale">Qorale</option>
                  <option value="garbagecollector">Garbage Collector</option>
                  <option value="charity">Charity</option>
                  <option value="company">Company</option>
                </select>
                </div>
            
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Save Changes</button>
       </form>
        </div>                                                                                                                                                            
</div>
  )
}

export default Edit
