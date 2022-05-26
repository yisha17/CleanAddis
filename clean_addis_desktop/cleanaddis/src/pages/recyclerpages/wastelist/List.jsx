import "./list.scss"
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"
import Wdatatable from "../../../components/usercomponents/wdatatable/Datatable"

const Uwlist = () => {
  return (
    <div className="list flex">
    <UserSidebar />
    <div className="listContainer pt-3 pl-3">
      <UserNavbar className="pt-3 " />
      <Wdatatable />
    </div>
    </div>
  )
}

export default Uwlist
