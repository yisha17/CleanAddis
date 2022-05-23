import React from 'react'
import Newmodal from '../../usercomponents/udatatable/NewModal'
import { Link } from 'react-router-dom'

const New = () => {
  return (
    <div className='bg-white p-2 rounded'>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/itadmin/user"  onClick={<Newmodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
          
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Add New user</h1>
        <form action="/" method="post">
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Username</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Email</label>
                <input class="border py-2 px-3 text-grey-800" type="Email" name="first_name" id="first_name"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Password</label>
                <input class="border py-2 px-3 text-grey-800" type="password" name="first_name" id="first_name"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Role</label>
                <select name="cars" id="cars">
                  <option value="cityadmin">City Admin</option>
                  <option value="recycler">Recycler</option>
                  <option value="qorale">Qorale</option>
                  <option value="garbagecollector">Garbage Collector</option>
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
