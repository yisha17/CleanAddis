import "./single.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"


const Single = () => {
  return (
    <div>
      <div className="list flex">
    <CityadminSidebar />
    
    <div className="listContainer pt-3 pl-3">
    <CityadminNavbar className="pt-3 " />
      single
    </div>
    </div>
    </div>
  )
}

export default Single
