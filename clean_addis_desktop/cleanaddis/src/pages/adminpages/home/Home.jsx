import "./home.scss"
import CityadminSidebar from "../../../components/cityadmincomponents/sidebar/CityadminSidebar"
import CityadminNavbar from "../../../components/cityadmincomponents/navbar/CityadminNavbar"
import Widget from "../../../components/cityadmincomponents/widgets/Widget"
import Featured from "../../../components/cityadmincomponents/featured/Featured"
import Chart from "../../../components/cityadmincomponents/chart/Chart"

const Home = () => {
  return (
      <div className="flex">
          <CityadminSidebar/>
          <div className="p-7 text-2x1  h-screen">
          <CityadminNavbar />
            <div className="widgets w-full flex flex-1 p-3 gap-10   ">
              <Widget type="workers"/>
              <Widget type="publicplaces" />
              <Widget type="reports" />
              <Widget type="announcements"/>
            </div>
            <div className="charts widgets w-full flex flex-1 p-3 gap-10  pt-3">
              <Featured />
              <Chart />

            </div>
            <div>
              <div className="listContainer shadow-xl shadow-green-100">
                <div className="listTitle self-center pt-4"> latest transactions </div>
              </div>
            </div>
          </div>
        
   </div>
  )
}

export default Home
