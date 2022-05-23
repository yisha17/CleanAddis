import React from 'react'
import Newmodal from '../../cityadmincomponents/adatatable/NewModal'
import { Link } from 'react-router-dom'

const New = () => {
  return (
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/announcement"  onClick={<Newmodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Announcement</h1>
        <form action="/" method="post">
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="first_name">Announcement Title</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="first_name" id="first_name"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Announcement Description</label>
                <input class="border py-2 px-3 text-grey-800" type="text" name="last_name" id="last_name"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="email">From</label>
                <input class="border py-2 px-3 text-grey-800" type="date" name="email" id="email"/>
            </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="password">To</label>
                <input class="border py-2 px-3 text-grey-800" type="date" name="password" id="password"/>
            </div>
            <div class="flex flex-col mb-4">
            <label for="cars" class="mb-2 font-bold text-lg text-gray-900" >For:</label>
                  <select id="cars" name="cars" size="4" multiple>
                    <option value="">Yeka Subcity</option>
                    <option value="">Bole Subcity</option>
                    <option value="">Gulele Subcity</option>
                    <option value="">Lemi Kura Subcity</option>
                  </select>
             </div>
            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-4 rounded" type="submit">Publish</button>
        </form>
        </div>
</div>
  
  )
}

export default New
