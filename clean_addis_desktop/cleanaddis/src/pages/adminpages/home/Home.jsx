import "./home.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
const Home = () => {
  return (
      <div className="flex">
          <CityadminSidebar/>
          <div className="p-7 text-2x1 font-semibold h-screen">
            <h1>Homepage</h1>
          </div>
        
   </div>
  )
}

export default Home
