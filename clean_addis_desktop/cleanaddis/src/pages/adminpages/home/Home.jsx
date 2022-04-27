import "./home.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"

const Home = () => {
  return (
      <div className="flex">
          <CityadminSidebar/>
          
          <div className="p-7 text-2x1 font-semibold flex-1 h-screen">
          <CityadminNavbar />
          home container
          </div>
        
   </div>
  )
}

export default Home
