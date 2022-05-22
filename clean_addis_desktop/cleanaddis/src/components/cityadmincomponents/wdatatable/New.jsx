import React from 'react'
import Newmodal from '../../cityadmincomponents/wdatatable/NewModal'
import { Link } from 'react-router-dom'

const New = () => {
  return (
    <div className='bg-white p-2 rounded'>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/work"  onClick={<Newmodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
          
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Public Place</h1>
        <form action="/" method="post">
        <div class="flex flex-col mb-4">
        <label class="mb-2 font-bold text-lg text-gray-900" for="myfile">Image:</label>
          <input class="border py-2 px-3 text-grey-800" type="file" id="myfile" name="myfile"/>
          </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Pulic Place Name</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Public Place Type</label>
                <select name="cars" id="cars">
                  <option value="volvo">Toilet</option>
                  <option value="saab">Park</option>
                </select>
                </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="email">Location</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="last_name" id="last_name"/>
           
            </div>
            
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Publish</button>
        </form>
        </div>
</div>
  
  )
}

export default New
