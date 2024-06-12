import { Post as IP } from '../main/main-page';
import { addDoc, collection, query, where, getDocs, deleteDoc, doc } from 'firebase/firestore';
import { db, auth } from '../config/firebase';
import '../App.css';
import { useAuthState } from 'react-firebase-hooks/auth';
import { useEffect, useState } from 'react';

interface Props {
  post: IP;
}

interface Like {
  id: string;
  userID: string;
}

export const Post = (props: Props) => {
  const { post } = props;
  const [user] = useAuthState(auth);
  const [likes, setLikes] = useState<Like[] | null>(null);

  const likesRef = collection(db, 'likes');
  const likesDoc = query(likesRef, where('postID', '==', post.id));

  const getLikes = async () => {
    const data = await getDocs(likesDoc);
    setLikes(data.docs.map((doc) => ({ id: doc.id, userID: doc.data().userID })));
  };

  const hasLiked = likes?.find((like) => like.userID === user?.uid);

  useEffect(() => {
    getLikes();
  }, []);

  const addLike = async () => {
    if (user) {
      await addDoc(likesRef, {
        userID: user.uid,
        postID: post.id,
      });
      getLikes(); // Update likes after adding
    }
  };

  const removeLike = async () => {
    if (user && hasLiked) {
      const likeDoc = doc(db, 'likes', hasLiked.id);
      await deleteDoc(likeDoc);
      getLikes(); // Update likes after removing
    }
  };

  const handleLikeToggle = () => {
    if (hasLiked) {
      removeLike();
    } else {
      addLike();
    }
  };

  return (
    <div className='contentbox'>
      <div className='title'>
        <h1>{post.Title}</h1>
      </div>
      <div className='body'>
        <p>{post.Description}</p>
      </div>
      <div className='footer'>
        <p>@{post.Username}</p>
        <button onClick={handleLikeToggle}>
          {hasLiked ? <>&#128078;</> : <>&#128077;</>}
        </button>
        {likes !== null && <p>Likes: {likes.length}</p>}
      </div>
    </div>
  );
};
