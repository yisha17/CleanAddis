import React from 'react'
import { Link } from 'react-router-dom'
import { useEffect,useState} from "react";
import Editormodal from '../../../components/cityadmincomponents/adatatable/Edit'
import getService from "../../../services/get.service";
import editService from '../../../services/edit.service';

const Edit = () => {
  const [title,setTitle] = useState("");
  const [body,setBody] = useState("");
  const [address,setAddress] = useState("");
  const [announcementData, setAnnouncementData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getAnnouncementSingle(id)
    .then((response) => setAnnouncementData(response.data),
    //console.log("data",announcementData.notification_title)//.then(
     setTitle(announcementData.notification_title),
     setBody(announcementData.notification_body),
     setAddress(announcementData.address) )

    //)
    
}, [])

const Editannouncemnt = (id) => async (e) =>{
  e.preventDefault();

  await editService.editannouncement(title,body,address,id).then(
    (response)=>{
      alert("announcemnt edited")
    },
    (error) => {
        console.log(error);
    }
);
  };
  return (
    
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/announcement"  onClick={<Editormodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Edit Announcement</h1>
        <form onSubmit={Editannouncemnt(id)}>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Announcement Titles</label>
                <input 
                type="text"
                class="form-control border py-2 px-3 text-grey-800"
                id="username"
                value={`${title}`}
                onChange={(e)=> setTitle(e.target.value)}
                />
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Announcement Description</label>
                <input  
                class="border py-2 px-3 text-grey-800" 
                type="text" 
                name="description" 
                value={`${body}`}
                onChange={(e)=> setBody(e.target.value)}
                />  
                
            </div>
            
            <div class="flex flex-col mb-4">
            <label for="cars" class="mb-2 font-bold text-lg text-gray-900" >For:</label>
                  <select id="cars" name="cars" size="4" 
                 
                  onChange={(e)=> setAddress(e.target.value)}
                  multiple>
                    <option value="Addis Ketema">Addis Ketema</option>
                    <option value="Akaky Kaliti">Akaky Kaliti</option>
                    <option value="Arada">Arada</option>
                    <option value="Bole">Bole</option>
                    <option value="Gullele">Gullele</option>
                    <option value="Kirkos">Kirkos</option>
                    <option value="Kolfe keranio">Kolfe keranio</option>
                    <option value="Lideta">Lideta</option>
                    <option value="Nifas Silk">Nifas Silk</option>
                    <option value="Yeka">Yeka</option>
                    <option value="Lemi kura">Lemi kura</option>

                  </select>
             </div>
            <button
            type="submit" 
            class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" >Save Changes</button>
        </form>
        </div>                                                                                                                                                            
</div>
  )
}

export default Edit
