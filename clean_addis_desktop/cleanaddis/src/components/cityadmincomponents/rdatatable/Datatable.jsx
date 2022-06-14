import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { reportColumns } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import { useState, useEffect} from 'react'
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"
import getService from '../../../services/get.service'
import deleteService from '../../../services/delete.service'

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
    const deletefunction=async (id)=>{
      localStorage.setItem("selected",JSON.stringify(id));
      if (window.confirm('Are you sure you want to delete the r?')) {
       await deleteService.deleteReport(id).then(
          (response)=>{
            alert("report deleted") 
            window.location.reload()
          },
          (error) => {
              console.log(error);
          })
      } else {
        // Do nothing!
        console.log('Thing was not saved to the database.');
      }
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
           <Link to="/cityadmin/report" onClick={()=>deletefunction(params.row.id)} >
           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-500 cursor-pointer ">delete</div>
           </Link>
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
