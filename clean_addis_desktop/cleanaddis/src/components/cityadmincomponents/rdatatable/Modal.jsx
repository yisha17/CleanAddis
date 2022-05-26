import React from 'react'
import Rsingle from '../../../pages/adminpages/rsinglepage/Single';

const Modal = ({visible, onClose}) => {

    if(!visible) return null;
    return (
    <div
    onClick={onClose} 
    className='fixed inset-0 bg-green-500 bg-opacity-30 backdrop-blur-sm flex justify-center items-center'>
    <div className='bg-white p-2 rounded'>
    <Rsingle />
    </div>
    </div>
  )
} 

export default Modal
