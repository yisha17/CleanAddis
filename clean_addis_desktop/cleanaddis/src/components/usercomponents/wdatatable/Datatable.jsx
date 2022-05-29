import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import {useEffect, useState} from 'react'
import { wasteColumns, wasteData } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import getService from '../../../services/get.service'

import Modal from '../wdatatable/Modal'


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
          <Link to ="/itadmin/waste" onClick={() => setSingle(true)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">View</div> 
           </Link>
           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer ">Delete</div>
         </div>
     )   
    }},]

    

  return (
    <div>
     
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
       
        <Modal visible={showSingle}/>
       
      </div>
    
    </div>
  )
}

export default Wdatatable
