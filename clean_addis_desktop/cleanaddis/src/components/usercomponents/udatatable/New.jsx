import React from 'react'
import Newmodal from '../../usercomponents/udatatable/NewModal'
import { Link } from 'react-router-dom'
import {useState,useEffect}from 'react'
import AuthService from '../../../services/auth.service'
import postService from '../../../services/post.service'

const New = () => {
  const [username,setUsername] = useState("");
  const [email,setEmail] = useState("");
  const [password,setPassword] = useState("");
  const [role,setRole] = useState("");
  

  const Createuser = async (e) =>{
    e.preventDefault();
    try{
      await postService.createuser(username,email,password,role).then(
        (response)=>{
          alert("user created") 
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
    <div className='bg-white p-2 rounded'>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/itadmin/user"  onClick={<Newmodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
          
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Add New user</h1>
        <form onSubmit={Createuser}>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="username">Username</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="username" 
                id="username"
                placeholder="Username"
                value={username}
                onChange={(e)=> setUsername(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="email">Email</label>
                <input class="border py-2 px-3 text-grey-800" type="Email" name="email" 
                id="email"
                placeholder="Email"
                value={email}
                onChange={(e)=> setEmail(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="password">Password</label>
                <input class="border py-2 px-3 text-grey-800" type="password" name="password"
                id="password"
                placeholder="Password"
                value={password}
                onChange={(e)=> setPassword(e.target.value)}/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="role">Role</label>
                <select name="role"
                id="role"
                placeholder="Role"
                onChange={(e)=> setRole(e.target.value)}>
                  <option value="recycler">Recycler</option>
                  <option value="City Admin">City Admin</option>
                  <option value="Qorale">Qorale</option>
                  <option value="Grabage Collector">Garbage Collector</option>
                  <option value="charity">Charity</option>
                  <option value="company">Company</option>
                </select>
                </div>
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Publish</button>
        </form>
        </div>
</div>
  
  )
}

export default New
