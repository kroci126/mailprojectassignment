import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailproject/services/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Send Email'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email penerima", prefixIcon: Icon(Icons.email)),
                controller: ctrlEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return !EmailValidator.validate(value.toString())
                      ? 'Email tidak valid'
                      : null;
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_loginKey.currentState!.validate()) {
            await SendEmailService.sendEmail(ctrlEmail.text).then((value) {
              var result = json.decode(value.body);
              Fluttertoast.showToast(
                  msg: result['message'].toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  fontSize: 14);
            });
          } else {
            Fluttertoast.showToast(
                msg: "Please fill all fields correctly!",
                toastLength: Toast.LENGTH_SHORT,
                fontSize: 14);
          }
        },
        tooltip: 'SendEmail',
        child: Icon(Icons.send_and_archive),
      ),
    );
  }
}
