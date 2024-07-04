import {auth,provider} from '../config/firebase'
import {signInWithPopup} from 'firebase/auth'
import {useNavigate} from 'react-router-dom'

export const Login=()=>{
    const navigate = useNavigate();//used to redirect to a different page when the fuction is called

    const signInWithGoogle= async ()=>{
        const result = await signInWithPopup(auth,provider);
        navigate('/');
    }


    return(
        <div>
            <h1>Login page</h1>
            <p>Sign in with Google to continue</p>
            <button onClick={signInWithGoogle}>Sign in with Google</button>
        </div>
    )
}