import "./list.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"
import Adatatable from "../../../components/cityadmincomponents/adatatable/Datatable"

const Alist = () => {
  return (
    <div className="list flex">
    <CityadminSidebar />
    <div className="listContainer pt-3 pl-3">
      <CityadminNavbar className="pt-3 " />
      <Adatatable />
    </div>
    </div>
  )
}

export default Alist
