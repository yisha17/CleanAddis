import React from 'react'
import Newmodal from '../../cityadmincomponents/sdatatable/NewModal'
import { Link } from 'react-router-dom'
import {useState,useEffect}from 'react'
import AuthService from '../../../services/auth.service'
import postService from '../../../services/post.service'

const New = () => {
  const [title,setTitle] = useState("");
  const [link,setLink] = useState("");
  const [image,setImage] = useState("");
  const [to,setTo] = useState("");
  const [type,setType] = useState("");
  const Postseminar = async (e) =>{
    e.preventDefault();
    console.log("here is the date",to)
    try{
      await postService.createseminar(title,type,link,image,to).then(
        (response)=>{
          alert("seminar posted") 
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
    <div  className='bg-white p-2 rounded'>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/seminar"  onClick={<Newmodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Seminar</h1>
        <form onSubmit={Postseminar}>
            <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name"> Title</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"
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
              <label class="mb-2 font-bold text-lg text-gray-900">Image:</label>
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
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Type</label>
                <select name="cars" id="cars"
                value={type}
                onChange={(e)=> setType(e.target.value)}>
                  <option selected value hidden> -- select Type -- </option>
                  <option value="Plantation">Plantation</option>
                  <option value="Meeting">Meeting</option>
                  <option value="Cleaning">Cleaning</option>
                </select>
                </div>  
            
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Publish seminar</button>
        </form>
        </div>
</div>
  
  )
}

export default New
