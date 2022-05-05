import "./ulist.scss"
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"
import Datatable from "../../../components/cityadmincomponents/datatable/Datatable"

const List = () => {
  return (
    <div className="list flex">
    <UserSidebar />
    <div className="listContainer pt-3 pl-3">
      <UserNavbar className="pt-3 " />
      <Datatable />
    </div>
    </div>
  )
}

export default List
