import React, { useEffect, useState } from 'react';
import './App.css';
import Axios from 'axios';

function App() {
  const [reason,setReason] = useState("");
  const [excuse,setExcuse] = useState("");

  useEffect(()=>{
    if(reason){
      Axios.get(`https://excuser-three.vercel.app/v1/excuse/${reason}`)
      .then((res)=>{
        setExcuse(res.data[0].excuse);
      
      })
      .catch((error)=>{
        console.error(error);
      })
    }
    
  }, [reason])
  

  return (
    <div className='App'>
      <h1>Generate an Excuse</h1>
      <div>
        <button onClick={()=>setReason("party")} className='buttons'>Party</button>
        <button onClick={()=>setReason("family")} className='buttons'>Family</button>
        <button onClick={()=>setReason("office")} className='buttons'>Office</button>
      </div>
      <h1>The reason:</h1>
      <div className='pdiv'><p>{excuse}</p></div>
    </div>
  );
};

export default App;
