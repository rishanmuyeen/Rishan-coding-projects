// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
import {getAuth, GoogleAuthProvider} from 'firebase/auth'
import {getFirestore} from 'firebase/firestore'
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAuny2MYriyHaPWrtl8Jpa7ltdvr5oShkU",
  authDomain: "react-project-8b6f6.firebaseapp.com",
  projectId: "react-project-8b6f6",
  storageBucket: "react-project-8b6f6.appspot.com",
  messagingSenderId: "75427401017",
  appId: "1:75427401017:web:8ef3d1edf4ea146abb2ce8",
  measurementId: "G-ZEWQT08MS9"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

export const auth = getAuth(app);
export const provider = new GoogleAuthProvider();
export const db = getFirestore(app);