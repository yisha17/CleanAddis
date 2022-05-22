import "./list.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"
import Rdatatable from "../../../components/cityadmincomponents/rdatatable/Datatable"
import Modal from "../../../components/cityadmincomponents/rdatatable/Modal"

const Rlist = () => {
  return (
    <div className="list flex">
    <CityadminSidebar />
    <div className="listContainer pt-3 pl-3">
      <CityadminNavbar className="pt-3 " />
     
      <Rdatatable />
    </div>
    </div>
  )
}

export default Rlist
