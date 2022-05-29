import React, { Component } from 'react'
import biologo from './public/image/biopicimg.jpg'

class About extends Component {
    render() {
        return (
            <section id="container-about" className="container-about">
                    <h1>CleanAddis-User</h1> 

                    <img src={biologo} width="180" height="180" alt="abtimg"/>
                    <p>First Name: CleanAddis <br />
                       Last Name: User <br /> 
                       Email: clean@clean.com <br /> 
                       username: clean <br />
                       Woreda:  00 <br />
                       Subcity: Lideta <br />
                       Role: Personal user


                    </p>
                
            </section>
        )
    }
}

export default About
