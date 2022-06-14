import "./list.scss"
import CharitySidebar from "../../../components/charitycomponents/csidebar/CharitySidebar"
import CharityNavbar from "../../../components/charitycomponents/cnavbar/CharityNavbar"
import Wdatatable from "../../../components/charitycomponents/wdatatable/Datatable"
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Charitylist = () => {
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

export default Charitylist
