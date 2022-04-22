import React from 'react';
import './Cards.css';
import CardItem from './CardItem';

function Cards() {
  return (
    <div className='cards'>
      <h1>A CLEAN PLACE IS A SAFE PLACE!</h1>
      <div className='cards__container'>
        <div className='cards__wrapper'>
          <ul className='cards__items'>
            <CardItem
              src='images/ca4.jpg'
              text=' Thats our mission to clean and green Addisababa City.'
              
              path='/services'
            />
            <CardItem
              src='images/ca5.jpg'
              text=' keep your city clean and green for the future generation to be seen! '
              
              path='/services'
            />
          </ul>
          <ul className='cards__items'>
            <CardItem
              src='images/ca8.jpg'
              text='You have a responsibility to keep your surrounding and city clean.'
          
              path='/services'
            />
            <CardItem
              src='images/ca11.jpg'
              text='Give your city clean look to maintain the dreambook.'
       
              path='/products'
            />
            <CardItem
              src='images/ca18.jpg'
              text='A green city,dream city!'
            
              path='/sign-up'
            />
          </ul>
        </div>
      </div>
    </div>
  );
}

export default Cards;
