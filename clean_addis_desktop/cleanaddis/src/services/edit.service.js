import axios from "axios";
import authHeader from "./auth-header";

const API_URL = "http://localhost:8010/proxy";
const editrole = (role,id) => {
    return axios
    .put(API_URL + `/user/${id}/update/`,{
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
const editseminar = (seminarTitle,seminarType,link,imageLink,toDate,id) => {
    return axios
    .put(API_URL + `/seminar/${id}/update`,{
        seminarTitle,
        seminarType,
        link,
        imageLink,
        toDate
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
    .put(API_URL + `/publicplace/${id}/update`,{
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
const resolvereport = (longitude,latitude,isResolved,id) => {
    return axios
    .put(API_URL + `/report/${id}/update`,{
        longitude,
        latitude,
        isResolved,
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
const editService = {
    editrole,
    editannouncement,
    editseminar,
    editpublicplace,
    editwork,
    resolvereport
};
export default editService; 
