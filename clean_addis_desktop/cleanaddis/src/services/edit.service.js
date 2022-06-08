import axios from "axios";
import authHeader from "./auth-header";

<<<<<<< HEAD
const API_URL = "http://localhost:8010/proxy";
const edituser = (username, email,password,role,id) => {
    return axios
    .put(API_URL + `/users/${id}/update`,{
        username,
        email,
        password,
        role,},{headers:authHeader()})
    .then((response) => {
        if(response){
            console.log("the is  response")
        }
        else{
            console.log("the is no response")
            
            
        }
        
    });
};
const editannouncement = (notification_title,notification_body,address,id) => {
    return axios
    .put(API_URL + `/announcement/${id}/update`,{
        notification_title,
        notification_body,
        address,
        "notification_type":"Announcement",
    },{headers:authHeader()})
    .then((response) => {
        if(response){
        }
        else{
        }
        
    });
};
const editseminar = (seminarTitle,seminarDescription,seminarType,id) => {
    return axios
    .put(API_URL + `/seminar/${id}/update`,{
        seminarTitle,
        seminarDescription,
        seminarType
    },{headers:authHeader()})
    .then((response) => {
        if(response){
            console.log("the is  response")
        }
        else{
            console.log("the is no response")
        }
        
    });
};
const editpublicplace = (placeName,placeType,rating,longitude,latitude,id) => {
    return axios
    .put(API_URL + `/users/${id}/update`,{
        placeName,
        placeType,
        rating,
        longitude,
        latitude
    },{headers:authHeader()})
    .then((response) => {
        if(response){
            console.log("the is  response")
        }
        else{
            console.log("the is no response")
            
            
        }
        
    });
};
const editwork = (workID,date,hour,id) => {
    return axios
    .put(API_URL + `/workschedule/${id}/update`,{
       workID,
       date,
       hour
    },{headers:authHeader()})
    .then((response) => {
        if(response){
            console.log("the is  response")
        }
        else{
            console.log("the is no response")
            
            
        }
        
    });
};
=======
const API_URI = "https://localhost:8000/api";

const getAllUsers = (id) => {
    return axios.get(API_URI + "/users/"+{id},{
        
    },{headers:authHeader()});
};  
const getAllWaste  = () => {
    return axios.get(API_URI+ "/waste/",{headers:authHeader()})
};
const getAllReport = () => {
    return axios.get(API_URI+ "/report/",{headers:authHeader()})
}
const getAllSeminar = () => {
    return axios.get(API_URI+ "/seminar/",{headers:authHeader()})
}
const getAllAnnouncement = () => {
    return axios.get(API_URI+ "/announcement/",{headers:authHeader()})
}
const getAllDonations = () => {
    return axios.get(API_URI+ "",{headers:authHeader()})
}
const getAllWork = () => {
    return axios.get(API_URI+ "/workschedule/",{headers:authHeader()})
}
const getCompanies = () => {
    return axios.get(API_URI+ "/companies/",{headers:authHeader()})
}
const getPublicPlace = () => {
    return axios.get(API_URI+ "/publicplace/",{headers:authHeader()})
}


>>>>>>> main
const editService = {
    edituser,
    editannouncement,
    editseminar,
    editpublicplace,
<<<<<<< HEAD
    editwork
};
export default editService;
=======
    editework
};

export default postService;
>>>>>>> main
