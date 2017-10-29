https://console.firebase.google.com/

새 프로젝트 만들기: mydogs

웹 앱에 Firebase 추가

아래 스니펫을 복사하여 HTML 하단이나 다른 script 태그 앞에 붙여넣기 하세요.
<script src="https://www.gstatic.com/firebasejs/3.7.2/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyBYD7EWkc5zGib9LbwjIr7GXfE0QCu_sxk",
    authDomain: "mydogs-2c7f0.firebaseapp.com",
    databaseURL: "https://mydogs-2c7f0.firebaseio.com",
    storageBucket: "mydogs-2c7f0.appspot.com",
    messagingSenderId: "1096921026947"
  };
  firebase.initializeApp(config);
</script>

<script src="https://www.gstatic.com/firebasejs/3.7.2/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: API_KEY,
    authDomain: "mydogs-<HASH_VALUE>.firebaseapp.com",
    databaseURL: "https://mydogs-<HASH_VALUE>.firebaseio.com",
    storageBucket: "mydogs-<HASH_VALUE>.appspot.com",
    messagingSenderId: "1096921026947"
  };
  firebase.initializeApp(config);
</script>



npm install firebase --save

var firebase = require("firebase");
또는
import * as firebase from "firebase";


// Initialize Firebase
// TODO: Replace with your project's customized code snippet
var config = {
  apiKey: "<API_KEY>",
  authDomain: "<PROJECT_ID>.firebaseapp.com",
  databaseURL: "https://<DATABASE_NAME>.firebaseio.com",
  storageBucket: "<BUCKET>.appspot.com",
};
firebase.initializeApp(config);
