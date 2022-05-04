import React from 'react'
import './datatable.scss'
import { DataGrid } from '@mui/x-data-grid'
import { userColumns, userRows } from '../../../datatablesource'


const Datatable = () => {
  return (
    <div  style={{ height: 400, width: '100%' }} className="items-center">
       <DataGrid 
        rows={userRows}
        columns={userColumns}
        pageSize={5}
        rowsPerPageOptions={[5]}
        checkboxSelection
      />
    </div>
  )
}

export default Datatable
