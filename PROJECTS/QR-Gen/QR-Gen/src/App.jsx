import { useState } from 'react'
import {QRCode} from 'react-qr-code'
import './App.css'

function App() {
  const [value, setValue] = useState('');
  const [input,setInput] = useState('');

  const Process = (event) =>{
    setValue(input)
  }

  return ( 
    <div>
      <h1>QR-Code Generator</h1>
      <input className='inputfield' type="text" placeholder='Enter a value to create the QR-Code' onChange={(event)=>{setInput(event.target.value)}}/>
      <br />
      <button disabled={input && input.trim() !== ' ' ? false:true} onClick={Process} className='btn'>Process</button>
      <div className='code'>
        <QRCode id='qr-code' value={value} size={400} />
      </div>
    </div>
  )
}

export default App
 