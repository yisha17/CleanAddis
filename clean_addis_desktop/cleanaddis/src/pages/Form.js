import "./form.css"
import React, { useState } from 'react';
import SignupForm from './SignupForm';
import SignupFormSuccess from './SignupFormSuccess';
import Navbar from "../components/Navbar";

const Form = () => {
  const [formIsSubmitted, setFormIsSubmitted] = useState(false);
  
  const submitForm = () => {
    setFormIsSubmitted(true);
  };

  
  return (
    <div>
      <div>
        <Navbar />
      </div>
    <div>
        {!formIsSubmitted ? (
        <SignupForm submitForm={submitForm}/> 
        ) : (
          <SignupFormSuccess />
        )}
    </div>
    </div>

  );
};

export default Form;