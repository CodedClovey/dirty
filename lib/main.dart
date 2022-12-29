import 'package:flutter/material.dart';
import 'package:movieapp/new_event.dart';
import 'package:movieapp/app.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xff171c21),
          appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: const Color(0xff171c21),
          ),

          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _pass,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _email.text,
                              password: _pass.text
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                        String? k = await Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Mpage()));
                        setState(() { });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        primary: Colors.white24,
                        onPrimary: Colors.white,
                      ),
                      child: const Text("LOGIN"),
                    );
                  }
                ),
                Builder(
                  builder: (context) {
                    return TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut(); //extra
                          String? newText = await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SignUp()));
                          setState(() { });
                        },
                      child: const Text("SIGN UP"),
                    );
                  }
                )
              ],
            ),
          ),
        ));
  }
}
