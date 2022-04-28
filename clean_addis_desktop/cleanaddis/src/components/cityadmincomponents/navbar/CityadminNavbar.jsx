import "./cityadminnavbar.scss"
import Search from './Search.png'
const CityadminNavbar = () => {
  return (
    <div className="navbar">
      <div className="wrapper">
        <div className="search flex">
          <input type="text" placeholder="Search..."/>
        <img src={Search}/>                                                                                                 
        </div>
        <div className="items">
          <div className="item"></div>
        </div>
      </div>
      
    </div>
  )
}

export default CityadminNavbar
