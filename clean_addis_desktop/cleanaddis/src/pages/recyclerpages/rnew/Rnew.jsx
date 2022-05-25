import "./unew.scss"
import UserSidebar from "../../../components/usercomponents/usidebar/UserSidebar"
import UserNavbar from "../../../components/usercomponents/unavbar/UserNavbar"



const Unew = ({inputs,title}) => {

  

  return (
    <div className="new flex">
    <UserSidebar />    
      <div className="newcontainer pt-3 pl-2 flex-6 w-full">
        <UserNavbar />
      <div className = "top flex font-bold text-3xl shadow-xl pt-7 m-2 w-full text-gray-400">
        <h1 >{title}</h1>
      </div>
      <div className = "bottom flex shadow-xl  m-10 pt-14 pb-14 ">
      <div className = "left items-center">
        <img src="https://images.unsplash.com/photo-1559308078-88465deb35cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80" alt="" className="w-28 h-28 rounded-full object-cover " />
      </div>
        <div className = "right">
          <form className="flex flex-col gap-6">
            {inputs.map(input=>(
            <div className="formInput" key={input.id}>
            <label className="items-center justify-center  "> {input.lable}</label>
            <input type={input.type} placeholder={input.placeholder} />
            </div>))}
            

            <div>
           
            <button className=" border-solid border-4 border-green-400 items-center ml-5 rounded-full  hover:text-white hover:bg-green-400 ">Create</button>
            
            </div>
          </form>
        </div>
      </div>
      </div>
    </div>
  )
}

export default Unew
