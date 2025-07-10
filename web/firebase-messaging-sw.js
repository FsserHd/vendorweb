importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");


     firebase.initializeApp({
          apiKey: "AIzaSyDTt0LiCGeRxBP7PWcjeVcDDCITavRmsh8",
             authDomain: "square-new-d8e68.firebaseapp.com",
             projectId: "square-new-d8e68",
             storageBucket: "square-new-d8e68.firebasestorage.app",
             messagingSenderId: "211166356684",
             appId: "1:211166356684:web:a722c7d34180ca1a968e69",
     });

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});