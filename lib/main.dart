import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart';

void main() {
  initializeApp(
    apiKey: "xxxx",
    authDomain: "qiita-glfbsi-proj.firebaseapp.com",
    databaseURL: "https://qiita-glfbsi-proj.firebaseio.com",
    projectId: "qiita-glfbsi-proj",
    storageBucket: "qiita-glfbsi-proj.appspot.com",
    messagingSenderId: "xxxx",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final _firebaseAuth = auth();
  final _googleSignIn = GoogleAuthProvider();

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    /// 戻り値は特になし
    await widget._firebaseAuth.setPersistence('session');
    /// 戻り値のcredencial自体もう利用しない
    await widget._firebaseAuth.signInWithPopup(widget._googleSignIn);
  }

  @override
  void initState() {
    super.initState();
    /// サインイン状態が変わったことによるリロードはここで一括して行うことにする
    widget._firebaseAuth.onAuthStateChanged.listen((user) {
      /// 画面のリロード
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            widget._firebaseAuth?.currentUser?.displayName != null
                ? Text(widget._firebaseAuth.currentUser.displayName)
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
