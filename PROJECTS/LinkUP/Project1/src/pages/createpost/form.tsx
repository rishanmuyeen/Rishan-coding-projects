import {useForm} from 'react-hook-form'
import * as yup from 'yup'
import {yupResolver} from '@hookform/resolvers/yup'
import {addDoc,collection} from 'firebase/firestore'
import {db,auth} from '../../config/firebase'
import {useAuthState} from 'react-firebase-hooks/auth'
import '../../App.css'
import {useNavigate} from 'react-router-dom'

interface createFormData {
    Title: string;
    Description: string;
}


export const CreateForm = () =>{

    const [user] = useAuthState(auth);
    const Navigate = useNavigate();

    const schema = yup.object().shape({
        Title: yup.string().required('You must add a title!'),
        Description: yup.string().required('You must at least add a minimum of 10 characters!'),
    });

    const {register, handleSubmit, formState:{errors},} = useForm<createFormData>({
        resolver: yupResolver(schema)
    });

    const postsRef = collection(db,"posts");

    const onCreatePost = async (data: createFormData)=>{
        await addDoc(postsRef,{
            ...data,
            Username: user?.displayName,
            userID: user?.uid,
        });
        Navigate('/');
    };

    return (
        <div className='formbox'>
            <form onSubmit={handleSubmit(onCreatePost)}>
                <input placeholder='Title' {...register('Title')} className='inputbox'/>
                <p className='error'>{errors.Title?.message}</p>
                <textarea placeholder='Description...' {...register('Description')} className='inputbox'/>
                <p className='error'>{errors.Description?.message}</p>
                <input type="submit" className='subbtn'/>
            </form>
        </div>
    )
}