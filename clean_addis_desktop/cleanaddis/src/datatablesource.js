import getService from "./services/get.service";


export const wasteColumns = [
    {field:'image',headerName:"Image",width:100},
    {field:'waste_name', headerName:"waste_name", width:150},
    {field: 'waste_type', headerName: "Type", width: 100 },
    {field: 'for_waste', headerName: "For", width: 100 },
    {field: 'quantity', headerName: "Quantity", width: 100 },
    {field: 'price_per_unit', headerName: "Price", width: 100 },
    {field: 'post_date', headerName: "Posted Date", width: 100 },
    {field: 'status', headerName: "status", width: 100,
    renderCell:(params) => {
        return(
            <div className={`status ${params.row.status}`}>{params.row.status}</div>
        ) 
       }},

];

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




