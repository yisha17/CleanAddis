import React from 'react';
import '../App.css';
import { Button } from './Button';
import './HeroSection.css';

function HeroSection() {
  return (
    <div className='hero-container'>
     
      <h1>CLEAN ADDIS</h1>
      <p>LET'S CLEAN OUR CITY TOGETHER</p>
      <div className='hero-btns'>
        <Button
          className='btns'
          buttonStyle='btn--outline'
          buttonSize='btn--large'
        >
          GET STARTED
        </Button>
        <Button
          className='btns'
          buttonStyle='btn--primary'
          buttonSize='btn--large'
          onClick={console.log('hey')}
        >
          SUPPORT US
        </Button>
      </div>
    </div>
  )
//   return (<>

// <div class="container-fluid bg-overlayspec">
//             <div class="centered" id="hi"> 
//             <span>
//             <h1>CLEAN ADDIS</h1>
//       <p className='lets'>LET'S MAKE OUR CITY CLEAN TOGETHER</p>
//       </span></div>
         
//         </div>
 
     
//       <div className='hero-btns'>
//         {/* <Button
//           className='btns'
//           buttonStyle='btn--outline'
//           buttonSize='btn--large'
//         >
//           GET STARTED
//         </Button> */}
//         <Button
//           className='btns'
//           buttonStyle='btn--primary'
//           buttonSize='btn--large'
//           onClick={console.log('hey')}
//         >

//         </Button>
//       </div>

//     </>
//   );
}

export default HeroSection;
