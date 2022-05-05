import "./uhome.scss"
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"
import Uwidget from "../../../components/usercomponents/uwidgets/Uwidget"
import Ufeatured from "../../../components/usercomponents/ufeatured/Ufeatured"
import Uchart from "../../../components/usercomponents/uchart/Uchart"
import Utables from "../../../components/usercomponents/utable/Utables"

const Uhome = () => {
  return (
      <div className="flex">
          <UserSidebar/>
          <div className="p-7 text-2x1  h-screen">
          <UserNavbar />
            <div className="widgets w-full flex flex-1 p-3 gap-10   ">
              <Uwidget type="workers"/>
              <Uwidget type="publicplaces" />
              <Uwidget type="reports" />
              <Uwidget type="announcements"/>
            </div>
            <div className="charts widgets w-full flex flex-1 p-3 gap-10  pt-3">
              <Ufeatured />
              <Uchart />

            </div>
            <div>
              <div className="listContainer shadow-2xl">
                <div className="listTitle  pt-8 pb-4 flex self-center justify-center items-center"> Latest announcements </div>
                <Utables />
              </div>
            </div>
          </div>
        
   </div>
  )
}

export default Uhome
