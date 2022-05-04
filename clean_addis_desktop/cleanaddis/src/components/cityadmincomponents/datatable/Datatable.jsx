import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { userColumns, userRows } from '../../../datatablesource'


const Datatable = () => {
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">view</div> 
           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-slate-500 cursor-pointer ">delete</div>
         </div>
     )   
    }},]

  return (
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={userRows}
        columns={userColumns.concat(actionColumn)}
        pageSize={10}
        rowsPerPageOptions={[5]}
        checkboxSelection
      />
    </div>
  )
}

export default Datatable
