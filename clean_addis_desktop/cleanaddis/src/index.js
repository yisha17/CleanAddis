import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import Login from './pages/Login';
import Services from './pages/Services';
import reportWebVitals from './reportWebVitals';
import {BrowserRouter,Routes,Route} from 'react-router-dom';
import Recycler from './pages/Recycler';
import Companies from './pages/Companies';
import Home from './pages/adminpages/home/Home';
import Rlist from './pages/adminpages/reportlist/List';
import Alist from './pages/adminpages/announcementlist/List';
import Slist from './pages/adminpages/seminarlist/List';
import Wlist from './pages/adminpages/worklist/List';
import Plist from './pages/adminpages/publicplacelist/List';
import Ssingle from './pages/adminpages/ssinglepage/Single';
import Asingle from './pages/adminpages/asinglepage/Single';
import Wsingle from './pages/adminpages/wsinglepage/Single';
import Psingle from './pages/adminpages/psinglepage/Single';
import Rsingle from './pages/adminpages/rsinglepage/Single';
import New from '../../cleanaddis/src/pages/adminpages/new/New';
import Ulist from './pages/userpages/ulist/List';
import Recyclerlist from './pages/recyclerpages/rlist/List';
import Uwlist from './pages/userpages/wastelist/List'
import Usingle from '../../cleanaddis/src/pages/userpages/usinglepage/Single';
import Recyclersingle from '../../cleanaddis/src/pages/recyclerpages/rsinglepage/Single';
import Unew from '../../cleanaddis/src/pages/userpages/unew/Unew';
import {announcementInputs, reportuserInputs} from "../src/formsource"
import Uhome from '../src/pages/userpages/uhome/Uhome'
import Rhome from '../src/pages/recyclerpages/rhome/Rhome'

ReactDOM.render(
    <React.StrictMode>
      <BrowserRouter>
        <Routes>
          <Route path="/" element = {<App />}/>
          <Route path="Login" element = {<Login />}/>
          <Route path="Services" element = {<Services />}/>
          <Route path="Companies" element = {<Companies/>}/>
          <Route path="Recycler" element = {<Recycler />}/>
          <Route path="cityadmin">
            <Route index element={<Home />}/>   
            <Route path="new" element={<New inputs = {announcementInputs} title="Add new Announcement"/>}/>
                <Route path="report">
                  <Route index element={<Rlist/>} /> 
                  <Route path=":reportId" element={<Rsingle />}/>
                  </Route >
                  <Route path="announcement">
                  <Route index element={<Alist/>} /> 
                  <Route path=":announcementId" element={<Asingle />}/>
                  <Route path="new" element={<New inputs = {announcementInputs} title="Add new Announcement"/>}/>
                  </Route >
                  <Route path="work">
                  <Route index element={<Wlist/>} /> 
                  <Route path=":workid" element={<Wsingle />}/>
                  <Route path="new" element={<New inputs = {announcementInputs} title="Add new work"/>}/>
                  </Route>
                  <Route path="seminar">
                  <Route index element={<Slist/>} /> 
                  <Route path=":semiarid" element={<Ssingle />}/>
                  <Route path="new" element={<New inputs = {announcementInputs} title="Add new work"/>}/>
                  </Route>
                  <Route path="publicplace">
                  <Route index element={<Plist/>} /> 
                  <Route path=":publicid" element={<Psingle />}/>
                  <Route path="new" element={<New inputs = {announcementInputs} title="Add new work"/>}/>
                  </Route>
          </Route>
          <Route path="itadmin">
            <Route index element={<Uhome />}/>
              <Route path="user">
                  <Route index element={<Ulist/>} /> 
                  <Route path=":reportId" element={<Usingle />}/>
                  <Route path="new" element={<Unew inputs = {announcementInputs} title="Add user"/>}/>
              </Route >
              <Route path="waste">
                  <Route index element={<Uwlist/>} /> 
                  <Route path=":reportId" element={<Usingle />}/>
              </Route >
          </Route>
          <Route path="recycler">
            <Route index element={<Rhome />}/>
              <Route path="waste">
                  <Route index element={<Recyclerlist/>} /> 
                  <Route path=":wasteId" element={<Usingle />}/>
                  <Route path="new" element={<Unew inputs = {announcementInputs} title="Add user"/>}/>
              </Route >
              <Route path="profile">
                  <Route index element={<Rhome/>}/> 
              </Route >
          </Route>
          


          
        </Routes>
      </BrowserRouter>
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
