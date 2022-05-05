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
import Single from '../../cleanaddis/src/pages/adminpages/singlepage/Single'
import New from '../../cleanaddis/src/pages/adminpages/new/New'


ReactDOM.render(
    <React.StrictMode>
      <BrowserRouter>
        <Routes>
          <Route path="/" element = {<App />}/>
          <Route path="Login" element = {<Login />}/>
          <Route path="Services" element = {<Services />}/>
          <Route path="Companies" element = {<Companies/>}/>
          <Route path="Recycler" element = {<Recycler />}/>
          <Route path="cityadmin" element = {<Home />}/>
          <Route path="report">
            <Route index element={<List/>}/>
            <Route path=":reportId" element={<Single />}/>
            <Route path="new" element={<New />}/>
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
