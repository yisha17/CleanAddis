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
import List from './pages/adminpages/list/List';
import Single from '../../cleanaddis/src/pages/adminpages/singlepage/Single';
import New from '../../cleanaddis/src/pages/adminpages/new/New';
import Ulist from './pages/userpages/ulist/Ulist';
import Usingle from '../../cleanaddis/src/pages/userpages/usinglepage/Usingle';
import Unew from '../../cleanaddis/src/pages/userpages/unew/Unew';
import {announcementInputs, reportuserInputs} from "../src/formsource"
import Uhome from '../src/pages/userpages/uhome/Uhome'
import Useminar from '../src/pages/userpages/useminar/Useminar'
import Uannouncement from '../src/pages/userpages/uannouncement/Uannouncement'

ReactDOM.render(
    <React.StrictMode>
      <BrowserRouter>
        <Routes>
          <Route path="/" element = {<App />}/>
          <Route path="Login" element = {<Login />}/>
          <Route path="Services" element = {<Services />}/>
          <Route path="Companies" element = {<Companies/>}/>
          <Route path="Recycler" element = {<Recycler />}/>
          <Route path="announcement">
            <Route index element={<List/>}/>
            <Route path=":announcementId" element={<Single />}/>
            <Route path="new" element={<New inputs = {announcementInputs} />}/>
          </Route>
          <Route path="waste">
          <Route path=":wasteId" element={<Single />}/>
            <Route index element={<List/>}/>
            <Route path=":wasteId" element={<Single />}/>
            <Route path="new" element={<New inputs = {announcementInputs} />}/>
          </Route>
         
          <Route path="work">
            <Route index element={<List/>}/>
            <Route path=":workId" element={<Single />}/>
            
          </Route>
          <Route path="cityadmin">
            <Route index element={<Home />}/>   
            <Route path="new" element={<New inputs = {announcementInputs} title="Add new Announcement"/>}/>
                <Route path="report">
                  <Route index element={<List/>} /> 
                  <Route path=":reportId" element={<Single />}/>
                  </Route >
                  <Route path="announcement">
                  <Route index element={<List/>} /> 
                  <Route path=":announcementId" element={<Single />}/>
                  <Route path="new" element={<New inputs = {announcementInputs} title="Add new Announcement"/>}/>
                  </Route >
                  <Route path="work">
                  <Route index element={<List/>} /> 
                  <Route path=":workid" element={<Single />}/>
                  <Route path="new" element={<New inputs = {announcementInputs} title="Add new work"/>}/>
                  </Route>
          </Route>
          <Route path="user">
            <Route index element={<Uhome />}/>
            <Route path="report">
                  <Route index element={<Ulist/>} /> 
                  <Route path=":reportId" element={<Usingle />}/>
                  <Route path="new" element={<Unew inputs = {announcementInputs} title="Add report"/>}/>
                  </Route >
            <Route path="announcement">
                  <Route index element={<Uannouncement/>} /> 
                  <Route path=":announcementId" element={<Usingle />}/>
                  <Route path="new" element={<Unew inputs = {announcementInputs} title="Add new Announcement"/>}/>
                  </Route >
            <Route path="seminar">
                  <Route index element={<Useminar/>} /> 
                  <Route path=":announcementId" element={<Usingle />}/>
                  <Route path="new" element={<Unew inputs = {announcementInputs} title="Add new Announcement"/>}/>
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
