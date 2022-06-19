import React from 'react'
import { Link } from 'react-router-dom'
import Editormodal from '../../../components/cityadmincomponents/pdatatable/Edit'
import "./single.scss"
import getService from "../../../services/get.service";
import editService from '../../../services/edit.service';
import { useEffect,useState} from "react";

const Edit = () => {
  const [name,setName] = useState("");
  const [type,setType] = useState("");
  const [publicData, setPublicData] = useState([])
  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getPublicPlaceSingle(id)
    .then((response) => setPublicData(response.data))
     setName(publicData.placeName)
     setType(publicData.placeType) 
}, [])
const Longitude = publicData.longitude
const Latitude =  publicData.latitude
const Rating = publicData.rating
const Editpublicplace = (id) => async (e) =>{
  e.preventDefault();

  await editService.editpublicplace(name,type,Rating,Longitude,Latitude,id).then(
    (response)=>{
      alert("public place edited")
    },
    (error) => {
        console.log(error);
    }
);
  };

  return (
    <div>
    <div className="singlecontainer  pt-3 pl-3">
      <div className="top flex">
        <div className="left shadow-2xl shadow-transparent p-10 relative flex ">
          <div className="flex">
    <Link to="/cityadmin/publicplace"  onClick={<Editormodal />}> <div className="editButton  border rounded border-slate-300  hover:bg-red-600 cursor-pointer">close</div>
          </Link></div>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Edit Public Place</h1>
        <form onSubmit={Editpublicplace(id)}>
        <div class="flex flex-col mb-4">
          </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Name</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"
                placeholder={`${publicData.placeName}`}
                value={name}
                onChange={(e)=> setName(e.target.value)}/>
            </div>
           
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Type</label>
                <select name="cars" id="cars"
                value={type}
                 onChange={(e)=> setType(e.target.value)}>
                  <option value="Park">Park</option>
                  <option value="Toilet">Toilet</option>
                  <option value="Parking">Parking</option>
                  <option value="Trashcan">Trashcan</option>
                </select>
                  </div>
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-2 rounded" type="submit">Save Changes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     </button>
        </form>
        </div>                                                                                                                                                            
</div>
</div>
</div>
  )
}

export default Edit
