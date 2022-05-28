import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "http://localhost:8010/proxy";

const deleteUser = (id) => {
    return axios.delete(`${API_URI}/users/${id}`,{headers:authHeader()});
};  
const deleteWaste  = () => {
    return axios.delete(`${API_URI}/waste/${id}`,{headers:authHeader()})
};
const deleteSeminar = () => {
    return axios.delete(`${API_URI}/seminar/${id}`,{headers:authHeader()})
}
const deleteAnnouncement = () => {
    return axios.delete(`${API_URI}/announcement/${id}`,{headers:authHeader()})
}
const deleteWork = () => {
    return axios.delete(`${API_URI}/work/${id}`,{headers:authHeader()})
}
const deletePublicPlace = () => {
    return axios.delete(`${API_URI}/publicplace/${id}`,{headers:authHeader()})
}

const deleteService = {
    deleteUser,
    deleteWaste,
    deleteAnnouncement,
    deleteSeminar,
    deleteWaste,
    deletePublicPlace,
    deleteWork
};
export default deleteService;
