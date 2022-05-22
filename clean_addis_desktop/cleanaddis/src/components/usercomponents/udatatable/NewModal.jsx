import React from 'react'
import Rsingle from '../../../pages/adminpages/rsinglepage/Single';
import { Link } from 'react'
import New from '../../../components/usercomponents/udatatable/New'

const Newmodal = ({visible, onClose}) => {

    if(!visible) return null;
    return (
    <div
    onClick={onClose} 
    className='fixed inset-0 bg-green-500 bg-opacity-30 backdrop-blur-sm flex justify-center items-center'>
    <div className=' p-2 rounded'>
    <New />
    </div>
    </div>
  )
} 

export default Newmodal
