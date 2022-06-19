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
export const donationsColumns = [
    {field:'image',headerName:"Image",width:200},
    {field:'waste_name', headerName:"waste_name", width:150},
    {field: 'quantity', headerName: "Quantity", width: 100 },
    {field: 'post_date', headerName: "Posted Date", width: 150 },
    {field: 'status', headerName: "status", width: 100,
    renderCell:(params) => {
        return(
            <div className={`status ${params.row.status}`}>{params.row.status}</div>
        ) 
       }},

];
export const reportColumns = [
        {field:"reportTitle", headerName:"Title", width:230,
        renderCell:(params) => {
         return(
             <div className="cellwithImg flex justify-between items-center">
                 <img className="cellImg w-14 h-14 rounded-full p-2" src={params.row.image} />
                    {params.row.reportTitle}
             </div>
         )   
        }},
        
        {field: 'reportDescription', headerName: "Description", width: 150 },
        {field: 'post_date', headerName: "Date", width: 110 },
        {field: 'isResolved', headerName: "Status", width: 100,
        renderCell:(params) => {
            return(
                <div className={`status ${params.row.isResolved}`}>{params.row.isResolved}</div>
            ) 
           }},
    
    ];
export const announcementColumns = [
        {field:"notification_title", headerName:"Title", width:230},
        {field: 'notification_body', headerName: "Description", width: 100 },
        {field: 'address', headerName: "For", width: 100,},
    
    ];
export const seminarColumns = [
        {field:"seminarTitle", headerName:"Title", width:130},
        {field: 'fromDate', headerName: "From Date", width: 110 },
        {field: 'toDate', headerName: "To Date", width: 120 },
        {field: 'link', headerName: "Link", width: 150 },
    ];
export const publicplaceColumns = [
        {field:"placeName", headerName:"Name", width:230,},
        {field: 'placeType', headerName: "Type", width: 100 },
        {field: 'rating', headerName: "Rating", width: 100 },
        {field: 'longitude', headerName: "Longitude", width: 100 },
        {field: 'latitude', headerName: "Latitude", width: 100,},
    ];

export const userRows = []
export const userColumns = [
        {field:"id",headerName:"ID",width:50},
        {field:"first_name", headerName:"First Name", width:100,},
        {field: 'last_name', headerName: "Last Name", width: 100 },
        {field: 'username', headerName: "username", width: 100 },
        {field: 'email', headerName: "Email", width: 200 },
        {field: 'role', headerName: "Role", width: 100,},
]

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




