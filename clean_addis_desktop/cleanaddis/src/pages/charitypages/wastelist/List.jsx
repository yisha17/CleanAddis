import "./list.scss"
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"
import Wdatatable from "../../../components/charitycomponents/wdatatable/Datatable"

const Cwlist = () => {
  return (
    <div className="list flex">
    <CharitySidebar />
    <div className="listContainer pt-3 pl-3">
      <CharityNavbar className="pt-3 " />
      <Wdatatable />
    </div>
    </div>
  )
}

export default Cwlist
