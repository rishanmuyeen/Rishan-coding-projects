import './App.css';
import {BrowserRouter as Router,Route,Routes} from 'react-router-dom';
import {Main} from './main/main-page';
import {Login} from './pages/login-page'
import {Nav} from './components/navbar'
import {CreatePost} from './pages/createpost/createpost'


function App() {
  return(
  <Router>
    <Nav/>
    <Routes>
      <Route path='/' element={< Main />} />
      <Route path='/login' element={< Login />}/>
      <Route path='/createpost' element={< CreatePost />}/>
    </Routes>
  </Router>
  )
}

export default App
