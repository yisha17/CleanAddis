import "./list.scss"
import CharitySidebar from "../../../components/charitycomponents/csidebar/CharitySidebar"
import CharityNavbar from "../../../components/charitycomponents/cnavbar/CharityNavbar"
import Rdatatable from "../../../components/charitycomponents/cdatatable/Datatable"
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Ulist = () => {
  return (
    <div className="list flex">
    <CharitySidebar />
    <div className="listContainer pt-3 pl-3">
      <CharityNavbar className="pt-3 " />
     
      <Rdatatable />
    </div>
    </div>
  )
}

export default Ulist
