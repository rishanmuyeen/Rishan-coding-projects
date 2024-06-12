import { getDocs, collection, DocumentData, QueryDocumentSnapshot } from 'firebase/firestore';
import { db } from '../config/firebase';
import { useEffect, useState } from 'react';
import { Post } from '../main/post';

export interface Post {
  id: string; // Add id field here if it's part of Post
  Description: string;
  Title: string;
  Username: string;
  userId: string;
}

export const Main = () => {
  const postsRef = collection(db, "posts");
  const [postList, setPostList] = useState<Post[] | null>(null);

  const getPosts = async () => {
    const data = await getDocs(postsRef);
    const posts = data.docs.map((doc: QueryDocumentSnapshot<DocumentData>) => ({
      ...doc.data(),
      id: doc.id,
    } as Post));
    setPostList(posts);
  };

  useEffect(() => {
    getPosts();
  }, []);

  return (
    <div>
      <h1>Home page</h1>
      {postList?.map((post) => (
        <Post post={post}/>
      ))}
      <hr />
      <footer>
        <div>
          <p>
          LinkUp is a dynamic social media platform that brings people together in a seamless and engaging way. Whether you're connecting with old friends, meeting new ones, or exploring communities that share your interests, LinkUp makes it easy to stay in touch and stay informed. Share your stories, discover exciting content, and engage in lively discussions. With LinkUp, your social world is always just a click away. Join LinkUp today and start making connections that matter!
          </p>
        </div>
      </footer>
    </div>
  );
};
