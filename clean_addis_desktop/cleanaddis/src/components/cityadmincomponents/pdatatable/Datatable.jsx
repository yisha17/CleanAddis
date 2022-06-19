import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { publicplaceColumns } from '../../../datatablesource'
import {Link} from 'react-router-dom'
import New from '../../../pages/adminpages/new/New'
import { useState,useEffect } from 'react'
import Newmodal from "../../../components/cityadmincomponents/pdatatable/NewModal"
import Modal from '../pdatatable/Modal'
import EditModal from '../pdatatable/Edit'
import getService from '../../../services/get.service'
import deleteService from '../../../services/delete.service'

const Pdatatable = () => {
    const [tableData, setTableData] = useState([])
    useEffect(() => {getService.getPublicPlace()
        .then((response) => setTableData(response.data))
    }, [])
    const viewfunction=(id) =>{
      localStorage.setItem("selected",JSON.stringify(id));
      setSingle(true);
    }
    const editfunction = (id) => {
      localStorage.setItem("selected",JSON.stringify(id));
      setEdit(true);
    }
    const deletefunction=async (id)=>{
      localStorage.setItem("selected",JSON.stringify(id));
      if (window.confirm('Are you sure you want to delete the public place?')) {
       await deleteService.deletePublicPlace(id).then(
          (response)=>{
            alert("Public Place successfully  deleted") 
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
          <Link to ="/cityadmin/publicplace" onClick={() => viewfunction(params.row.id)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">View</div> 
           </Link>
           <Link to ="/cityadmin/publicplace" onClick={() => editfunction(params.row.id)}>
           <div className="viewButton border rounded border-slate-300 p-1 hover:bg-blue-400 cursor-pointer">Edit</div> 
           </Link>
           

           <div className="deleteButton border rounded border-slate-300 p-1 hover:bg-red-600 cursor-pointer " onClick={()=>deletefunction(params.row.id)} >Delete</div>
         </div>
     )   
    }},]

    

  return (
    <div>
      <div>
      <Link to ="/cityadmin/publicplace" onClick={() => setShowMyModal(true)}>
           <div className="border rounded border-slate-300 justify-center flex items-center m-4  hover:bg-green-400 cursor-pointer pt-4 pb-5">Add New Public Places </div> 
           </Link>
      </div>
    <div  style={{ height: 500, width: '100%' }} className="items-center">
       <DataGrid 
        rows={tableData}
        columns={publicplaceColumns.concat(actionColumn)}
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

export default Pdatatable
