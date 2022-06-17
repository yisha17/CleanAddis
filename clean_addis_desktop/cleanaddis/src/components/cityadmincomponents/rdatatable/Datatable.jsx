import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { reportColumns } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import { useState, useEffect} from 'react'
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"
import getService from '../../../services/get.service'

const Rdatatable = () => {
  const [tableData, setTableData] = useState([])
  useEffect(() => {getService.getAllReport()
      .then((response) => setTableData(response.data))
  }, [])
  var idvalue = 0
    const viewfunction=(id) =>{
      localStorage.setItem("selected",JSON.stringify(id));
      setShowMyModal(true);
    }
    const [showMyModal,setShowMyModal]  = useState(false)
    const handleOnCLose = () => setShowMyModal(false)
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
          <Link to ="/cityadmin/report" onClick={() => viewfunction(params.row.id)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">view</div> 
           </Link>
           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-slate-500 cursor-pointer ">delete</div>
         </div>
     )   
    }},]

  return (
    <div>
      
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={tableData}
        columns={reportColumns.concat(actionColumn)}
        pageSize={10}
        rowsPerPageOptions={[5]}
        checkboxSelection
      />
    </div>
    <div>
        <Modal  visible={showMyModal}/>
      </div>
    
    </div>
  )
}

export default Rdatatable
