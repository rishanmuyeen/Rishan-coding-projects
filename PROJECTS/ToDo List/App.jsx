import { useState } from 'react'
import './App.css'

function App() {
  const [TodoList,setTodoList] = useState([]); //Array
  const [Task,setTask] = useState(""); //variable to store

  const handleChange = (event) =>{   //function 
    setTask(event.target.value);
  };

  const addTask = () =>{      //using the data collected above to store in list
    const task ={
      id: TodoList.length === 0? 1 : TodoList[TodoList.length-1].id + 1,
      taskname: Task,
    }
    const newTodoList = [...TodoList,task];
    setTodoList(newTodoList);
  };

  const delateTask = (id) =>{
    const newTodoList = TodoList.filter((task) =>{
      return (id === task.id ? false : true )
    })
    setTodoList(newTodoList)
  }

  return (
    <div className='App'>
      <div className='addTask'>
        <input onChange={handleChange} placeholder='Enter the task'/>
        <button onClick={addTask}>Add Tasks</button>
      </div>
      
      <div className='list'>
        {TodoList.map((task) =>{
          return(
          <div>
             <h1>{task.taskname}</h1>
             <button id='cancelbtn' onClick={() => delateTask(task.id)}>X</button>
          </div>
          )
        })}
      </div>

    </div>     
  );
};

export default App
