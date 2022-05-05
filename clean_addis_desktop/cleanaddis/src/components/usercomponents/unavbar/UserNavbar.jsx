import "./usernavbar.scss"
import Search from './Search.png'
import Notification from './Notification.png'
import List from './List.png'
import Avatar from './Avatar.png'


const CityadminNavbar = () => {
  return (
    <div className="text-sm flex content-center  ">
      <div className="flex justify-between content-ceneter ">
        <div className="search flex  content-center border-solid border-2 border-green-600 p-1">
          <input type="text" placeholder="Search..." className="border-none outline-none"/>
        <img src={Search}/>                                                                                                 
        </div>
        <div className="flex absolute  right-2 pr-2 ">
          <div className="item flex pr-3 content-center relative">
          <img src={Notification} width="30"/>
          <div className="bg-red-500 rounded text-white flex content-center justify-center top--1 right-4 absolute">
            1
          </div>
          </div>
          <div className="item flex content-center pr-8">
          <img src={List} width="30"/>
          </div>
          <div className="item flex content-center rounded border-solid">
          <img src={Avatar} width="30"/>
          </div>
        </div>
      </div>
      
    </div>
  )
}

export default CityadminNavbar
