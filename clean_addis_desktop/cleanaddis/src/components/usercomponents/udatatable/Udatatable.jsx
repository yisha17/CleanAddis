import React from 'react'
import './udatatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { userColumns, userRows } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'


const Datatable = () => {
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
  <Link to="New">
   <div className=" border rounded border-slate-300 p-1 bg-green-200 hover:bg-yellow w-20 cursor-pointer relative left">Add new</div> 
   </Link>
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

export default Datatable
