import React from 'react'
import Single from '../../../pages/userpages/usinglepage/Single';
import Edit from '../../../pages/userpages/usinglepage/Edit'

const Editormodal = ({visible, onClose}) => {

    if(!visible) return null;
    return (
    <div
    onClick={onClose} 
    className='fixed inset-0 bg-green-500 bg-opacity-30 backdrop-blur-sm flex justify-center items-center'>
    <div className='bg-white p-2 rounded'>
    <Edit />
    </div>
    </div>
  )
} 

export default Editormodal
