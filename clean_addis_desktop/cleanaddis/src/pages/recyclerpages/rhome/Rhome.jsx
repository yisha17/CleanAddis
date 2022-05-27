import "./rhome.scss"
import RecyclerSidebar from "../../../components/recyclercomponents/rsidebar/RecyclerSidebar"
import RecyclerNavbar from "../../../components/recyclercomponents/rnavbar/RecyclerNavbar"


const Rhome = () => {
  return (
      <div className="flex">
          <RecyclerSidebar/>
          <div className="p-7 text-2x1  h-screen">
          <RecyclerNavbar />
            
            <div>
              
            </div>
          </div>
        
   </div>
  )
}

export default Rhome
