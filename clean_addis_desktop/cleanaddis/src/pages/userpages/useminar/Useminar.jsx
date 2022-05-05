import React from 'react'
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"
import Utables from "../../../components/usercomponents/utable/Utables"
const Useminar = () => {
  return (
    <div className="seminarcontainer flex">
      <div><UserSidebar /> </div>
      <div><UserNavbar />
         <Utables />
      </div>
    </div>
  )
}

export default Useminar
