import React from 'react'
import { Link } from 'react-router-dom'
import Editormodal from '../../../components/usercomponents/udatatable/Edit'

const Edit = () => {
  return (
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/itadmin/user"  onClick={<Editormodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Edit Seminar   </h1>
        <form action="/" method="post">
        <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name"> Title</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"/>
            </div>
            <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Link </label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="last_name" id="last_name"/>
            </div>
            <div class="flex flex-col mb-2">
              <label class="mb-2 font-bold text-lg text-gray-900" for="myfile">Image:</label>
              <input class="border py-2 px-3 text-grey-800" type="file" id="myfile" name="myfile"/>
            </div>
            <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="email">From</label>
                <input class="border py-2 px-3 text-grey-800" type="date" name="email" id="email"/>
            </div>
            <div class="flex flex-col mb-2">
                <label class="mb-2 font-bold text-lg text-gray-900" for="password">To</label>
                <input class="border py-2 px-3 text-grey-800" type="date" name="password" id="password"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Type</label>
                <select name="cars" id="cars">
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
