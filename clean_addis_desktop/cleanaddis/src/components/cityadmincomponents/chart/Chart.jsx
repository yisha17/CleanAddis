import React from 'react'
import "./chart.scss"
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip , ResponsiveContainer } from 'recharts';
const data = [
  {name:'january',amount:'5000'},
  {name:'february',amount:'3000'},
  {name:'march',amount:'2000'},
  {name:'april',amount:'4050'},

];
const Chart = (aspect) => { 
  return (
    <div className="chart flex flex-col shadow-xl shadow-green-100">
      <div className='title self-center'>Last 6 month performance</div>
      <ResponsiveContainer width="100%"  aspect={aspect}>
      <AreaChart
          width={500}
          height={400}
          data={data}
          margin={{
            top: 10,
            right: 30,
            left: 0,
            bottom: 0,
          }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="name" />
          <YAxis />
          <Tooltip />
          <Area type="monotone" dataKey="amount" stackId="1" stroke="#8884d8" fill="lightgreen" />
        </AreaChart>
      </ResponsiveContainer>
    </div>
  )
}

export default Chart
