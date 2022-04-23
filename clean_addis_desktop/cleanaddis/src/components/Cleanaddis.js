import React from 'react'
import { Link } from 'react-router-dom'

const cleanaddis = () => {
  return (
    <div className="bg-[url('assets/images/ca8_prev_ui.png')] bg-no-repeat h-screen flex flex-col justify-center items-center">
        <h1 className="lg:text-9xl md:text-7xl sm:text-5xl
        text-3xl font-black text-green-700 mb-14">
                CleanAddis 
        </h1>
        <Link className='py-6  px-10 bg-green-600 rounded-full text-white font-medium
        text-2xl hover:bg-green-500 transition duration-300 ease-in-out flex items-center animate-bounce
        ' to="/Login">Join us!</Link>

    </div>
  )
}

export default cleanaddis
