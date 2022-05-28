import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "https://localhost:8000/api";

const getAllUsers = () => {
    return axios.get(API_URI + "/users/",{headers:authHeader()});
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



const getService = {
    getAllUsers,
    getAllWaste,
    getAllAnnouncement,
    getAllDonations,
    getAllReport,
    getAllSeminar,
    getAllWaste,
    getAllWork,
    getCompanies,
    getPublicPlace,

};
export default getService;