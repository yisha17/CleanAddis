import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "https://localhost:8000/api";


const createuser = (username, email,password,role) => {
    return axios
    .post(API_URL + "/users/",{
        username,
        email,
        password,
        role,
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
const createannouncement = (notificationTitle,notificationDescription,formDate,toDate,published,recipient) => {
    return axios
    .post(API_URL + "/announcement/",{
        notificationTitle,
        notificationDescription,
        formDate,
        toDate,
        published,
        recipient,

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
const createseminar = (seminarTitle,seminarDescription,seminarType) => {
    return axios
    .post(API_URL + "/seminar/",{
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
const createpublicplace = (placeName,placeType,rating,longitude,latitude) => {
    return axios
    .post(API_URL + "/seminar/",{
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
const creatework = (workID,date,hour) => {
    return axios
    .post(API_URL + "/seminar/",{
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


const postService = {
    createuser,
    createannouncement,
    createseminar,
    createpublicplace,
    creatework
};



export default postService;