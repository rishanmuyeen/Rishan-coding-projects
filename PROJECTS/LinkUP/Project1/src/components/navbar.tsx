import {Link} from 'react-router-dom'
import {auth} from '../config/firebase'
import {useAuthState} from 'react-firebase-hooks/auth'
import '../App.css'
import {signOut} from 'firebase/auth'
export const Nav=()=>{
    const [user] = useAuthState(auth);
    const signUserOut = async()=>{
        await signOut(auth);
    }
    return(
        <div className='navbar'>
            <div className='navigation'>
                <div className='name'><h1>LinkUp</h1></div>
            <Link to='/' className='navbtn'>Home</Link>
            {!user ? (
                <Link to='/login' className='navbtn'>Login</Link>
            ):(
            <Link to='/createpost' className='navbtn'>Create new Post</Link>)}
            </div>

            <div>
                {user &&(
                    <>
                        <p id='username'>{user?.displayName}</p>
                        <img src={user?.photoURL || ""} width='50' height='50' id='userimg'/><br/>
                        <button onClick={signUserOut} id='signoutbtn'>Log out</button>
                    </>
                )}
            </div>
        </div>
    )
}