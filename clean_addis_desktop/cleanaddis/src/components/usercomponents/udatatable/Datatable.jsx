import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { userColumns } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import { useState,useEffect } from 'react'
import Newmodal from "../../../components/usercomponents/udatatable/NewModal"
import Modal from '../udatatable/Modal'
import EditModal from '../udatatable/Edit'
import getService from '../../../services/get.service'
import deleteService from '../../../services/delete.service'

const Udatatable = () => {
  const [tableData, setTableData] = useState([])
  useEffect(() => {getService.getAllUsers()
      .then((response) => setTableData(response.data))

  }, [])
    var idvalue = 0
    const viewfunction=(id) =>{
      localStorage.setItem("selected",JSON.stringify(id))
      setSingle(true)
    }
    const deletefunction=async (id)=>{
      localStorage.setItem("selected",JSON.stringify(id));
      if (window.confirm('Are you sure you want to delete the user?')) {
       await deleteService.deleteUser(id).then(
          (response)=>{
            alert("announcement deleted") 
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
    const [showSingle, setSingle] = useState(false)
    const [showEdit, setEdit] = useState(false)
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
          <Link to ="/itadmin/user" onClick={() => 
            viewfunction(params.row.id)
          }>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">View</div> 
           </Link>
           <Link to ="/itadmin/user" onClick={() => setEdit(true)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">Edit</div> 
           </Link>
           

           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer "
           onClick={()=>deletefunction(params.row.id)}>Delete</div>
         </div>
     )   
    }},]

    

  return (
    <div>
      <div>
      <Link to ="/itadmin/user" onClick={() => setShowMyModal(true)}>
           <div className="border rounded border-slate-300 justify-center flex items-center m-4  hover:bg-green-400 cursor-pointer pt-4 pb-5">Add New User. </div> 
           </Link>
      </div>
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={tableData}
        columns={userColumns.concat(actionColumn)}
        pageSize={10}
        rowsPerPageOptions={[5]}
        checkboxSelection
      />
    </div>
    <div>
        <Newmodal  visible={showMyModal} id={idvalue}/>
        <Modal visible={showSingle}/>
        <EditModal visible={showEdit}/>
      </div>
    
    </div>
  )
}

export default Udatatable
