import axios from "axios";
import authHeader from "./auth-header";

const API_URI = "/user";

const getAllUsers = () => {
    return axios.get(API.URI + "/users/",{headers:authHeader()});
};  

const getAllWaste  = () => {
    return axios.get(API_URI+ "/waste",{headers:authHeader()})
};

const postService ={
    getAllUsers,
    getAllWaste,
};

export default postService;