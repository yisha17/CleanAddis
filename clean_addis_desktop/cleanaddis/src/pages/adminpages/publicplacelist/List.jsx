import "./list.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"
import Pdatatable from "../../../components/cityadmincomponents/pdatatable/Datatable"

const Plist = () => {
  return (
    <div className="list flex">
    <CityadminSidebar />
    <div className="listContainer pt-3 pl-3">
      <CityadminNavbar className="pt-3 " />
      <Pdatatable />
    </div>
    </div>
  )
}

export default Plist
