import React from 'react'
import { Link } from 'react-router-dom'
import Editormodal from '../../../components/cityadmincomponents/wdatatable/Edit'

const Edit = () => {
  return (
    <div>
    <div class="rounded justify-center item-center p-6 m-4">
    <Link to="/cityadmin/work"  onClick={<Editormodal />}> <div className="editButton  border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">close</div>
          </Link>
        <h1 class="block w-full text-center text-gray-800 text-2xl font-bold mb-6">Edit Work Schedule</h1>
        <form action="/" method="post">
        <div class="flex flex-col mb-4">
        <label class="mb-2 font-bold text-lg text-gray-900" for="myfile">Time:</label>
          <input class="border py-2 px-3 text-grey-800" type="datetime-local" id="myfile" name="myfile"/>
          </div>
            <div class="flex flex-col mb-4">
                <label class="mb-2 font-bold text-lg text-gray-900" for="last_name">Worker</label>
                <select name="cars" id="cars">
                  <option value="volvo">Toilet</option>
                  <option value="saab">Park</option>
                </select>
                  </div>

            <button class="block bg-green-400 hover:bg-green-600 text-white uppercase text-lg mx-auto p-2 rounded" type="submit">Save Changes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     </button>
        </form>
        </div>                                                                                                                                                            
</div>
  )
}

export default Edit
