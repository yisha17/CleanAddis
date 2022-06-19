import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { announcementColumns } from '../../../datatablesource'
import {Link,useNavigate} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import { useState,useEffect } from 'react'
import Newmodal from "../../../components/cityadmincomponents/adatatable/NewModal"
import Modal from '../adatatable/Modal'
import EditModal from '../adatatable/Edit'
import getService from '../../../services/get.service'
import deleteService from '../../../services/delete.service'


const Adatatable = () => {
  const [tableData, setTableData] = useState([])
  useEffect(() => {getService.getAllAnnouncement()
      .then((response) => setTableData(response.data))
  }, [])
  const viewfunction=(id) =>{
    localStorage.setItem("selected",JSON.stringify(id));
    setSingle(true);
  }
  const deletefunction=async (id)=>{
    localStorage.setItem("selected",JSON.stringify(id));
    if (window.confirm('Are you sure you want to delete the announcement?')) {
     await deleteService.deleteAnnouncement(id).then(
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
  const editfunction = (id) => {
    localStorage.setItem("selected",JSON.stringify(id));
    setEdit(true);
  }
    const [showMyModal,setShowMyModal]  = useState(false)
    const [showSingle, setSingle] = useState(false)
    const [showEdit, setEdit] = useState(false)
    const actionColumn = [{field:"action", headerName:"Action", width:230,
    renderCell:(params) => {
     return(
         <div className = "cellAction flex gap-4">
          <Link to ="/cityadmin/announcement" onClick={() => viewfunction(params.row.id)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">View</div> 
           </Link>
           <Link to ="/cityadmin/announcement" onClick={() => editfunction(params.row.id)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">Edit</div> 
           </Link>
           

           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer ">Delete</div>
         </div>
     )   
    }},]

    

  return (
    <div>
      <div>
      <Link to ="/cityadmin/announcement" onClick={() => setShowMyModal(true)}>
           <div className="border rounded border-slate-300 justify-center flex items-center m-4  hover:bg-green-400 cursor-pointer pt-4 pb-5">Add New Announcements </div> 
           </Link>
      </div>
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={tableData}
        columns={announcementColumns.concat(actionColumn)}
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

export default Adatatable
