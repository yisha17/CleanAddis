import "./list.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"
import Wdatatable from "../../../components/cityadmincomponents/wdatatable/Datatable"

const Plist = () => {
  return (
    <div className="list flex">
    <CityadminSidebar />
    <div className="listContainer pt-3 pl-3">
      <CityadminNavbar className="pt-3 " />
      <Wdatatable />
    </div>
    </div>
  )
}

export default Plist
