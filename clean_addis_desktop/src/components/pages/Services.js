import React from 'react'
import Navbar from '../components/Navbar'
import Footer from '../components/Footer'

const Services = () => {
  return ( 
    <>
    <Navbar />
    <div>
    <div class="bg-gray-100">
      <section class="cover bg-blue-teal-gradient relative bg-green-500 px-4 sm:px-8 lg:px-16 xl:px-40 2xl:px-64 overflow-hidden py-48 flex
      items-center min-h-screen">
        <div class="h-full absolute top-0 left-0 z-0">
          <img src="images/cover-bg.jpg" alt="" class="w-full h-full object-cover opacity-20"/>
        </div>

        <div class="lg:w-3/4 xl:w-2/4 relative z-10 h-100 lg:mt-16">
          <div>
            <h1 class="text-white text-4xl md:text-5xl xl:text-6xl font-bold leading-tight">A better life starts with a
              beautiful
              smile.</h1>
            <p class="text-blue-100 text-xl md:text-2xl leading-snug mt-4">Welcome to the Dentist Office of Dr. Thomas
              Dooley,
              where
              trust
              and comfort are priorities.</p>
            <a href="#" class="px-8 py-4 bg-white text-black rounded inline-block mt-8 font-semibold">Book
              Appointment</a>
          </div>
        </div>
      </section>
    </div>
    <section class="relative px-4 py-16 sm:px-8 lg:px-16 xl:px-40 2xl:px-64 lg:py-32">
      <div class="flex flex-col lg:flex-row lg:-mx-8">
        <div class="w-full lg:w-1/2 lg:px-8">
          <h2 class="text-3xl leading-tight font-bold mt-4">Welcome to the Dentist Office of Dr. Thomas Dooley</h2>
          <p class="text-lg mt-4 font-semibold">Excellence in Dentistry in the Heart of NY</p>
          <p class="mt-2 leading-relaxed">Donec convallis sollicitudin facilisis. Integer nisl ligula, accumsan non
            tincidunt ac, imperdiet in enim.
            Donec efficitur ullamcorper metus, eu venenatis nunc. Nam eget neque tempus, mollis sem a, faucibus mi.</p>
        </div>


        <div class="md:w-1/2 md:px-4 mt-4 md:mt-8 lg:mt-0 lg:w-1/4">
          <div class="bg-white rounded-lg border border-gray-300 p-8">
            <img src="images/periodontics.svg" alt="" class="h-20 mx-auto"/>

            <h4 class="text-xl font-bold mt-4">Periodontics</h4>
            <p class="mt-1">Let us show you how our experience.</p>
            <a href="#" class="block mt-4">Read More</a>
          </div>
        </div>
      </div>
    </section>
          </div>
    <Footer />
  </>
  )
}

export default Services
