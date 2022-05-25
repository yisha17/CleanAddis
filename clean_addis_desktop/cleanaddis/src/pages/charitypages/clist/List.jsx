import "./list.scss"
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"
import Udatatable from "../../../components/usercomponents/udatatable/Datatable"
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Ulist = () => {
  return (
    <div className="list flex">
    <UserSidebar />
    <div className="listContainer pt-3 pl-3">
      <UserNavbar className="pt-3 " />
     
      <Udatatable />
    </div>
    </div>
  )
}

export default Ulist
