import 'package:flutter/material.dart';
import 'package:movieapp/app.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff171c21),

      appBar: AppBar(
        backgroundColor: const Color(0xff171c21),
        title: const Text("Sign Up"),
      ),

      body: Container(
        padding: const EdgeInsets.all(25.0),

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
            TextButton(
              onPressed: () async {
                try {
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _email.text,
                    password: _pass.text,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
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
              child: const Text("SIGN UP"),
            ),
          ],
        ),
      ),
    );
  }
}
