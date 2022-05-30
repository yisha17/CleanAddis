const validation = (values) => {

  let errors={};

  if(!values.firstname){
    errors.firstname="First Name is Required."
  }
  if(!values.lastname){
    errors.lastname="Last Name is Required."
  }
  if(!values.username){
    errors.username="User Name is Required."
  }
  if(!values.subcity){
    errors.subcity="Subcity is Required."
  }
  if(!values.woreda){
    errors.woreda="Woreda is Required."
  }
  if(!values.email){
    errors.email="E-mail is Required."
  } else if(!/\S+@\S+\S+/.test(values.email)){
      errors.email="Email is Invalid."
  } 
  if(!values.password){
    errors.password="Password is Required."
  } else if(values.password.length < 5){
      errors.password="Password must have more than 5 characters"
  }
  if(!values.confirm){
    errors.confirm="Confirm Password"
  }
  return errors;

};

export default validation;