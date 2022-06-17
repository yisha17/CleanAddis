import React from 'react'
import Newmodal from '../../cityadmincomponents/adatatable/NewModal'
import { Link } from 'react-router-dom'
import {useState,useEffect}from 'react'
import AuthService from '../../../services/auth.service'
import postService from '../../../services/post.service'

const New = () => {
  const [title,setTitle] = useState("");
  const [body,setBody] = useState("");
  const [address,setAddress] = useState("");

  const Postannouncemnt = async (e) =>{
    e.preventDefault();
    try{
      await postService.createannouncement(title,body,address).then(
        (response)=>{
          alert("announcemnt posted") 
        },
        (error) => {
            console.log(error);
        }
    );
    }
    catch(err){
        console.log(err);
    }};

  return (
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/announcement"  onClick={<Newmodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Announcement</h1>
        <form onSubmit={Postannouncemnt}>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Announcement Title</label>
                <input 
                type="text"
                class="form-control border py-2 px-3 text-grey-800"
                id="username"
                placeholder="Title"
                value={title}
                onChange={(e)=> setTitle(e.target.value)}
                />
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Announcement Description</label>
                <input 
                class="border py-2 px-3 text-grey-800" 
                type="text" 
                name="description" 
                placeholder="body"
                value={body}
                onChange={(e)=> setBody(e.target.value)}
                />
                
            </div>
            
            <div class="flex flex-col mb-4">
            <label for="cars" class="mb-2 font-bold text-lg text-gray-900" >For:</label>
                  <select id="cars" name="cars" size="4" 
                  placeholder="address"
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
            class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Publish</button>
        </form>
        </div>
</div>
  
  )
}

export default New
