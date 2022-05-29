import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { wasteColumns, wasteData } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import { useState, useEffect } from 'react'
import Newmodal from "../../../components/cityadmincomponents/wdatatable/NewModal"
import Modal from '../wdatatable/Modal'
import EditModal from '../wdatatable/Edit'
import getService from '../../../services/get.service'

const Wdatatable = () => {
  const [tableData, setTableData] = useState([])
  useEffect(() => {getService.getAllWaste()
      .then((response) => setTableData(response.data))
  }, [])
    

    const [showMyModal,setShowMyModal]  = useState(false)
    const [showSingle, setSingle] = useState(false)
    const [showEdit, setEdit] = useState(false)
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
          <Link to ="/cityadmin/work" onClick={() => setSingle(true)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">View</div> 
           </Link>
           <Link to ="/cityadmin/work" onClick={() => setEdit(true)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">Edit</div> 
           </Link>
           

           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer ">Delete</div>
         </div>
     )   
    }},]

    

  return (
    
   
    <div>
     
      <div>
      </div>
      <div>
      <Link to ="/cityadmin/work" onClick={() => setShowMyModal(true)}>
           <div className="border rounded border-slate-300 justify-center flex items-center m-4  hover:bg-green-400 cursor-pointer pt-4 pb-5">Add New Work Schedule</div> 
           </Link>
      </div>
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={tableData}
        columns={wasteColumns.concat(actionColumn)}
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

export default Wdatatable
