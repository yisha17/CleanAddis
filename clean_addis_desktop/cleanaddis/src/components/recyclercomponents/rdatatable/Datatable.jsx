import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { userColumns, userRows } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import { useState } from 'react'
import Newmodal from "../../../components/recyclercomponents/rdatatable/NewModal"
import Modal from '../rdatatable/Modal'
import EditModal from '../rdatatable/Edit'

const Recyclerdatatable = () => {
    const [showMyModal,setShowMyModal]  = useState(false)
    const [showSingle, setSingle] = useState(false)
    const [showEdit, setEdit] = useState(false)
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
          <Link to ="/recycler/waste" onClick={() => setSingle(true)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">View</div> 
           </Link>
           <Link to ="/recycler/waste" onClick={() => setEdit(true)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">Edit</div> 
           </Link>
           

           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer ">Delete</div>
         </div>
     )   
    }},]

    

  return (
    <div>
      <div>
      <Link to ="/recycler/waste" onClick={() => setShowMyModal(true)}>
           <div className="border rounded border-slate-300 justify-center flex items-center m-4  hover:bg-green-400 cursor-pointer pt-4 pb-5">Add New Waste Amount Cap</div> 
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
    <div>
        <Newmodal  visible={showMyModal}/>
        <Modal visible={showSingle}/>
        <EditModal visible={showEdit}/>
      </div>
    
    </div>
  )
}

export default Recyclerdatatable
