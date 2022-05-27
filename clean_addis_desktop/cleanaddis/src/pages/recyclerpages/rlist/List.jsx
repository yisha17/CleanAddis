import "./list.scss"
import RecyclerSidebar from "../../../components/recyclercomponents/rsidebar/RecyclerSidebar"
import RecyclerNavbar from "../../../components/recyclercomponents/rnavbar/RecyclerNavbar"
import Rdatatable from "../../../components/recyclercomponents/rdatatable/Datatable"
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Ulist = () => {
  return (
    <div className="list flex">
    <RecyclerSidebar />
    <div className="listContainer pt-3 pl-3">
      <RecyclerNavbar className="pt-3 " />
     
      <Rdatatable />
    </div>
    </div>
  )
}

export default Ulist
