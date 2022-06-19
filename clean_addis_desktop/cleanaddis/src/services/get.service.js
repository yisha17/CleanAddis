import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "http://localhost:8010/proxy";

const getUserRole = (id) => {
    return axios.get(API_URI + `/user/${id}`,{headers:authHeader()});
};
const getUserSingle = (id) => {
    return axios.get(API_URI + `/user/${id}`,{headers:authHeader()});
}
const getReportSingle = (id) =>{
    return axios.get(API_URI+ `/report/${id}`,{headers:authHeader()});
}
const getWasteSingle = (id) =>{
    return axios.get(API_URI+`/waste/${id}`,{headers:authHeader()});
}
const getAnnouncementSingle = (id) =>{
    return axios.get(API_URI+ `/announcement/${id}`,{headers:authHeader()});
}
const getPublicPlaceSingle = (id) =>{
    return axios.get(API_URI+ `/publicplace/${id}`,{headers:authHeader()});
}
const getSeminarSingle = (id) =>{
    return axios.get(API_URI+ `/seminar/${id}`,{headers:authHeader()});
}
const getAllUsers = () => {
    return axios.get(API_URI + "/users/all",{headers:authHeader()});
};  
const getAllWaste  = () => {
    return axios.get(API_URI+ "/waste/all/",{headers:authHeader()})
};
const getAllReport = () => {
    return axios.get(API_URI+ "/report/all/",{headers:authHeader()})
}
const getAllSeminar = () => {
    return axios.get(API_URI+ "/seminar/all",{headers:authHeader()})
}
const getAllAnnouncement = () => {
    return axios.get(API_URI+ "/announcement/all",{headers:authHeader()})
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
    return axios.get(API_URI+ "/publicplace/list/",{headers:authHeader()})
}
const getDonation = () => {
    return axios.get(API_URI+ "/waste/donations/",{headers:authHeader()})
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
    getUserRole,
    getUserSingle,
    getReportSingle,
    getAnnouncementSingle,
    getPublicPlaceSingle,
    getSeminarSingle,
    getWasteSingle,
    getDonation
};
export default getService;