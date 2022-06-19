import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "http://localhost:8010/proxy";

const deleteUser = (id) => {
    return axios.delete(`${API_URI}/user/delete/${id}`,{headers:authHeader()});
};  
const deleteWaste  = (id) => {
    return axios.delete(`${API_URI}/waste/delete/${id}`,{headers:authHeader()})
};
const deleteSeminar = (id) => {
    return axios.delete(`${API_URI}/seminar/delete/${id}`,{headers:authHeader()})
}
const deleteAnnouncement = (id) => {
    return axios.delete(`${API_URI}/announcement/delete/${id}`,{headers:authHeader()})
}
const deleteWork = (id) => {
    return axios.delete(`${API_URI}/work/delete/${id}`,{headers:authHeader()})
}
const deletePublicPlace = (id) => {
    return axios.delete(`${API_URI}/publicplace/delete/${id}`,{headers:authHeader()})
}
const deleteReport = (id) => {
    return axios.delete(`${API_URI}/report/delete/${id}`,{headers:authHeader()})
}


const deleteService = {
    deleteUser,
    deleteWaste,
    deleteAnnouncement,
    deleteSeminar,
    deleteWaste,
    deletePublicPlace,
    deleteWork,
    deleteReport
};
export default deleteService;
