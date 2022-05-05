import React from 'react'
import './utable.scss'
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import Paper from '@mui/material/Paper';

const Tables = () => {
  const datas = [{
    id: 1,
    title: "cleaning announcment",
    from: "12/03/2021",
    to: "16/03/2021",
    published: "10/03/2021",
    for : "yeka subcity"
},
{
    id: 2,
    title: "cleaning announcment",
    from: "12/03/2021",
    to: "16/03/2021",
    published: "10/03/2021",
    for : "bole subcity"
},
{
    id: 3,
    title: "cleaning announcment",
    from: "12/03/2021",
    to: "16/03/2021",
    published: "10/03/2021",
    for : "arada subcity"
},
  {
       id: 1,
       title: "cleaning announcment",
       from: "12/03/2021",
       to: "16/03/2021",
       published: "10/03/2021",
       for : "yeka subcity"
   },
   {
       id: 2,
       title: "cleaning announcment",
       from: "12/03/2021",
       to: "16/03/2021",
       published: "10/03/2021",
       for : "bole subcity"
   },
   {
       id: 3,
       title: "cleaning announcment",
       from: "12/03/2021",
       to: "16/03/2021",
       published: "10/03/2021",
       for : "arada subcity"
   },
  ];
  return (
    <TableContainer component={Paper}>
    <Table sx={{ minWidth: 650 }} aria-label="simple table">
      <TableHead>
        <TableRow>
          <TableCell className="tablecell">ID</TableCell>
          <TableCell className="tablecell">Title</TableCell>
          <TableCell className="tablecell">From Date</TableCell>
          <TableCell className="tablecell">To Date</TableCell>
          <TableCell className="tablecell">Published</TableCell>
          <TableCell className="tablecell">For</TableCell>
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
            <TableCell className="tablecell" >{data.title}</TableCell>
            <TableCell className="tablecell">{data.from}</TableCell>
            <TableCell className="tablecell" >{data.to}</TableCell>
            <TableCell className="tablecell">{data.published}</TableCell>
            <TableCell className="tablecell">{data.for}</TableCell>
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
