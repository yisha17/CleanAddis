import axios from "axios";
import authHeader from "./auth-header";

const API_URL = "http://localhost:8010/proxy";


const createuser = (username, email,password,role) => {
    return axios
    .post(API_URL + "/users/web/",{
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
const createannouncement = (notification_title,notification_body,address) => {
    return axios
    .post(API_URL + "/announcement/",{
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
const createseminar = (seminarTitle,seminarType,link,imageLink,toDate) => {
    return axios
    .post(API_URL + "/seminar/",{
        seminarTitle,
        seminarType,
        link,
        imageLink,
        toDate,
        
        
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