import "./list.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"
import Datatable from "../../../components/cityadmincomponents/datatable/Datatable"

const List = () => {
  return (
    <div className="list flex">
    <CityadminSidebar />
    <div className="listContainer ">
      <CityadminNavbar />
      <Datatable />
    </div>
    </div>
  )
}

export default List
