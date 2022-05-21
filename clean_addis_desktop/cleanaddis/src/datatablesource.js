export const userColumns = [
    {field: 'id', headerName: "ID", width: 70 },
    {field:"title", headerName:"Title", width:230,
    renderCell:(params) => {
     return(
         <div className="cellwithImg flex justify-between items-center">
             <img className="cellImg w-14 h-14 rounded-full p-2" src={params.row.img} />
                {params.row.title}
         </div>
     )   
    }},
    {field: 'from', headerName: "from", width: 100 },
    {field: 'to', headerName: "to", width: 100 },
    {field: 'published', headerName: "published on date", width: 100 },
    {field: 'for', headerName: "For", width: 100 },
    {field: 'status', headerName: "status", width: 100,
    renderCell:(params) => {
        return(
            <div className={`status ${params.row.status}`}>{params.row.status}</div>
        ) 
       }},

];
export  const userRows = [{
    id: 1,
    title: "cleaning announcment",
    from: "12/03/2021",
    to: "16/03/2021",
    img: "https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    published: "10/03/2021",
    for : "yeka subcity",
    status :"delivered"
},
{
    id: 2,
    title: "cleaning announcment",
    from: "12/03/2021",
    to: "16/03/2021",
    img: "https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    published: "10/03/2021",
    for : "bole subcity",
    status :"delivered"
},
{
    id: 3,
    title: "cleaning announcment",
    from: "12/03/2021",
    to: "16/03/2021",
    img: "https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
    published: "10/03/2021",
    for : "arada subcity",
    status :"delivered"
},
  {
       id: 4,
       title: "cleaning announcment",
       from: "12/03/2021",
       to: "16/03/2021",
       img: "https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
       published: "10/03/2021",
       for : "yeka subcity",
       status :"pending"
   },
   {
       id: 5,
       title: "cleaning announcment",
       from: "12/03/2021",
       to: "16/03/2021",
       img: "https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
       published: "10/03/2021",
       for : "bole subcity",
       status :"pending"
   },
   {
       id: 6,
       title: "cleaning announcment",
       from: "12/03/2021",
       to: "16/03/2021",
       img: "https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
       published: "10/03/2021",
       for : "arada subcity",
       status :"delivered"
   },
  ];
export const rColumn = [
    
];
export const rRow = [
];

export const aColumn = [
];
export const aRow = [
];

export const sColumn = [
];
export const sRow = [
];

export const wColumn = [
];
export const wRow = [
]
export const pColumn = [
];
export const pRow = [
];




