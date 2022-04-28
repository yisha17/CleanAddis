import React, {useEffect, useState} from 'react'
import useForm from "./useForm";

const SignupForm = ({submitForm}) => {


  const {handleChange, handleFormSubmit, values, errors } = useForm(
      submitForm
      );
 
  return (
  <div className='container'>
       <div className='app-wrapper'>
           <div>
               <h2 className="title">Create Account</h2>
           </div>
           <form classNAme="form-wrapper">
           <div data-role="fieldcontain">
    <fieldset data-role="controlgroup">
    	<legend>Choose a role:</legend>
         	<input type="radio" name="radio-choice-1" nameclassName="radio" id="radio-choice-1" checked="checked" value={values.personal} onChange={handleChange}/>
         	<label for="radio-choice-1">Personal</label>

         	<input type="radio" name="radio-choice-1" className="radio" id="radio-choice-2" value={values.admin} onChange={handleChange}/>
         	<label for="radio-choice-1">Administrator</label>

    </fieldset>
</div>
                <div className='name'>
                    <label className='label'>First Name</label>
                    <input className='input' type='text' name='firstname' value={values.firstname} onChange={handleChange} ></input>
                {errors.firstname && <p className='error'>{errors.firstname}</p>}
                </div>
                <div className='name'>
                    <label className='label'>Last Name</label>
                    <input className='input' type='text' name='lastname' value={values.lastname} onChange={handleChange}></input>
                {errors.lastname && <p className='error'>{errors.lastname}</p>}
                </div>
                <div className='name'>
                    <label className='label'>Choose Username</label>
                    <input className='input' type='text' name='username' value={values.username} onChange={handleChange}></input>
                {errors.username && <p className='error'>{errors.username}</p>}
                </div>
                <div className='name'>
                    <label className='label'>Assigned Subcity</label>
                    <input className='input' type='text'name='subcity' value={values.subcity} onChange={handleChange}></input>
                {errors.subcity && <p className='error'>{errors.subcity}</p>}
                </div>
                <div className='name'>
                    <label className='label'>Assigned Woreda</label>
                    <input className='input' type='number' name='woreda' value={values.woreda} onChange={handleChange}></input>
                {errors.woreda && <p className='error'>{errors.woreda}</p>}
                </div>
                <div className='name'>
                    <label className='label'>Your Personal Email</label>
                    <input className='input' type='email' name='email' value={values.email} onChange={handleChange}></input>
                {errors.email && <p className='error'>{errors.email}</p>}
                </div>
                <div className='name'>
                    <label className='label'>Create your Password</label>
                    <input className='input' type='text' name='password' value={values.password} onChange={handleChange}></input>
                {errors.password}
                </div>
                <div className='name'>
                    <label className='label'>Confirm your Password</label>
                    <input className='input' type='text' name='confirm' value={values.confirm} onChange={handleChange}></input>
                {errors.confirm}
                </div>
                <div data-role="fieldcontain">
    <fieldset data-role="controlgroup">
    	<legend>Choose Administrator role:</legend>
         	<input type="radio" name="radio-choice-2" className="radio" id="radio-choice-1" checked="checked" value={values.personal} onChange={handleChange}/>
         	<label for="radio-choice-2">City Administrator</label>

         	<input type="radio" name="radio-choice-2" className="radio" id="radio-choice-2" value={values.admin} onChange={handleChange}/>
         	<label for="radio-choice-2">Admin</label>

    </fieldset>
</div>
                <div>
                    <br>
                    </br>
                    <br>
                    </br>

                </div>
                <div>
                    <button className='submit' onClick={handleFormSubmit}>
                        Sign up
                    </button>
                </div>

           </form>
       </div>    
  </div>
  );
};
 export default SignupForm;