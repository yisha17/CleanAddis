import axios from "axios";
const API_URL = " http://localhost:8010/proxy"
//lcp --proxyUrl



const login = (username, password) => {
    return axios
    .post(API_URL + `/auth/`,{
        username,
        password,
        
        
    })
    .then((response) => {
        if(response.data.access){
            localStorage.setItem("user",JSON.stringify(response.data));
            console.log("there is a response")
            return String(response.data.access)
           
        }
        else{
            console.log("the is no response")        
        }
        
    });
};
const logout = () =>{
    localStorage.removeItem("user");
};

const getCurrentUser = () => {
    return JSON.parse(localStorage.getItem("user"));
}

const AuthService = {
    login,
    logout,
    getCurrentUser,
};
export default AuthService;