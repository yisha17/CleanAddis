import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "http://localhost:8010/proxy";

const getAllUsers = () => {
    return axios.get(API_URI + "/users/all/",{headers:authHeader()});
};  
const getAllWaste  = () => {
    return axios.get(API_URI+ "/waste/all/",{headers:authHeader()})
};
const getAllReport = () => {
    return axios.get(API_URI+ "/report/all/",{headers:authHeader()})
}
const getAllSeminar = () => {
    return axios.get(API_URI+ "/seminar/all/",{headers:authHeader()})
}
const getAllAnnouncement = () => {
    return axios.get(API_URI+ "/announcement/all/",{headers:authHeader()})
}
const getAllDonations = () => {
    return axios.get(API_URI+ "",{headers:authHeader()})
}
const getAllWork = () => {
    return axios.get(API_URI+ "/workschedule/all/",{headers:authHeader()})
}
const getCompanies = () => {
    return axios.get(API_URI+ "/companies/all/",{headers:authHeader()})
}
const getPublicPlace = () => {
    return axios.get(API_URI+ "/publicplace/all/",{headers:authHeader()})
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