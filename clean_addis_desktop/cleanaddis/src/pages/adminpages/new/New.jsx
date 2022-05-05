import "./new.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"

const New = () => {
  return (
    <div className="new flex">
    <CityadminSidebar />    
      <div className="newcontainer pt-3 pl-2">
        <CityadminNavbar />
        New
      </div>
    </div>
  )
}

export default New
