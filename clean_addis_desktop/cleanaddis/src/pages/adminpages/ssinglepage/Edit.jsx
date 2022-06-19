import React from 'react'
import { Link } from 'react-router-dom'
import Editormodal from '../../../components/usercomponents/udatatable/Edit'
import getService from "../../../services/get.service";
import editService from '../../../services/edit.service';
import { useEffect,useState} from "react";

const Edit = () => {
  const [title,setTitle] = useState("");
  const [type,setType] = useState("");
  const [link,setLink] = useState("");
  const [image, setImage] = useState("")
  const [to, setTo] = useState("")

  const [seminarData, setSeminarData] = useState([])

  var id = JSON.parse(localStorage.getItem("selected"))
  useEffect(() => {getService.getSeminarSingle(id)
    .then((response) => setSeminarData(response.data))
     setTitle(seminarData.seminarTitle)
     setType(seminarData.seminarType)
     setLink(seminarData.link) 
     setImage(seminarData.imageLink)
     setTo(seminarData.ToDate)

}, [])
const Editseminar = (id) => async (e) =>{
  e.preventDefault();

  await editService.editseminar(title,type,link,image,to,id).then(
    (response)=>{
      alert("Seminar edited")
    },
    (error) => {
        console.log(error);
    }
);
  };
  return (
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/seminar"  onClick={<Editormodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Edit Seminar   </h1>
        <form onSubmit={Editseminar(id)}>
        <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name"> Title</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"
                placeholder={title}
                value={title}
                onChange={(e)=> setTitle(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Link </label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="last_name" id="last_name"
                value={link}
                onChange={(e)=> setLink(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-2">
              <label class="mb-2 font-bold text-lg text-gray-900" for="myfile">Image:</label>
              <input class="border py-2 px-3 text-grey-800" type="text" id="myfile" name="myfile"
              value={image}
              onChange={(e)=> setImage(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="password">To</label>
                <input class="border py-2 px-3 text-grey-800" type="date" name="password" id="password"
                value={to}
                onChange={(e)=> setTo(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name"
                >Type</label>
                <select name="cars" id="cars"
                value={type}
                onChange={(e)=> setType(e.target.value)}>
                  <option value="volvo">Plantation</option>
                  <option value="saab">Meeting</option>
                  <option value="saab">Cleaning</option>
                </select>
                </div>
            
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Save Changes</button>
       </form>
        </div>                                                                                                                                                            
</div>
  )
}

export default Edit
