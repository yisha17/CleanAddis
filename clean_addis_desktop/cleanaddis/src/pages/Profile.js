import React from 'react'
import CityadminNavbar from './../components/cityadmincomponents/navbar/CityadminNavbar'
import ProfileForm from './ProfileForm'
const Profile = () => {
  return (
    <div className="justify center items-center">
    <CityadminNavbar />
    <div className="justify-center items-center"><ProfileForm /></div>
    </div> 
  
  )
}

export default Profile
