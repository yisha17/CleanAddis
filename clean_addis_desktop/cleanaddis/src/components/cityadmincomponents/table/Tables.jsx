import React from 'react'
import './table.scss'
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';
import getService from '../../../services/get.service'
import { useState, useEffect } from 'react'

const Tables = () => {
  const [loading, setLoading] = useState(true);
  const [datas, setDatas] = useState([])

  useEffect(() => {
    const fetchData = async () =>{
      setLoading(true);
      try {
        const {data: response} = await getService.getAllWaste();
        setDatas(response);
        console.log(datas);
      } catch (error) {
        console.error(error.message);
      }
      setLoading(false);
    }

    fetchData();
  }, []);
  
  return (
    <TableContainer component={Paper}>
    <Table sx={{ minWidth: 650 }} aria-label="simple table">
      <TableHead>
        <TableRow>
          <TableCell className="tablecell">Image</TableCell>
          <TableCell className="tablecell">Name</TableCell>
          <TableCell className="tablecell">Type</TableCell>
          <TableCell className="tablecell">For</TableCell>
          <TableCell className="tablecell">Quantity</TableCell>
          <TableCell className="tablecell">Posted Date</TableCell>
          <TableCell className="tablecell">Status</TableCell>
        </TableRow>
      </TableHead>
      <TableBody>
        {datas.map((data) => (
          <TableRow
            key={data.id} 
          >
            <TableCell>
              {data.id}
            </TableCell>
            <TableCell className="tablecell" >{data.image}</TableCell>
            <TableCell className="tablecell">{data.waste_name}</TableCell>
            <TableCell className="tablecell" >{data.waste_type}</TableCell>
            <TableCell className="tablecell">{data.for_waste}</TableCell>
            <TableCell className="tablecell">{data.quantity}</TableCell>
            <TableCell className="tablecell">{data.post_date}</TableCell>
            <TableCell className="tablecell">
            <span className={`status ${data.status}`} >{data.status}
            </span></TableCell>

          </TableRow>
        ))}
      </TableBody>
    </Table>
  </TableContainer>
  );
};

export default Tables
