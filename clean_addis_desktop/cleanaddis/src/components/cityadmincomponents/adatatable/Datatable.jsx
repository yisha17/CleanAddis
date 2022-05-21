import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { userColumns, userRows } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import { useState } from 'react'
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Adatatable = () => {
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
          <Link to="1">
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">view</div> 
           </Link>
           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-slate-500 cursor-pointer ">delete</div>
         </div>
     )   
    }},]

    

  return (
    <div>
      <div>
      <Link to="1">
           <div className="border rounded border-slate-300 justify-center flex items-center m-4  hover:bg-green-400 cursor-pointer pt-4 pb-5">Add New Announcement </div> 
           </Link>
      </div>
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={userRows}
        columns={userColumns.concat(actionColumn)}
        pageSize={10}
        rowsPerPageOptions={[5]}
        checkboxSelection
      />
    </div>
    
    </div>
  )
}

export default Adatatable
