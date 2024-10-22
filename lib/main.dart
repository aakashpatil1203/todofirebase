import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/addtaskscreen.dart';
import 'package:todofirebase/providertask.dart';
import 'package:todofirebase/tasklistscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBQDwXVe9tsOLmmHicqnIhm9UzQ22ZiVbE",
            authDomain: "todolist-6644e.firebaseapp.com",
            projectId: "todolist-6644e",
            storageBucket: "todolist-6644e.appspot.com",
            messagingSenderId: "974080910574",
            appId: "1:974080910574:web:26227435049cfee0eb7fff",
            measurementId: "G-VEMJJBPV9B"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do List',
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LogInPage(),
          '/tasks': (context) => const TaskListScreen(),
          '/addTask': (context) => const AddTaskScreen(),
        },
      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ToDo List"),
        titleTextStyle:const TextStyle(fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        backgroundColor:const Color.fromARGB(255, 170, 115, 229),
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20)
          )
        )  
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc44o1KcDcUxYxHLVP02gNx1P0cqDQ9gINF-smrMAC7DmX0lVdS1PUMTVpRUgnVHwgfMg&usqp=CAU",
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: userNameTextEditingController,
                decoration: InputDecoration(
                    hintText: "Enter username",
                    label: const Text("Enter username"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter username";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordTextEditingController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    hintText: "Enter password",
                    label: const Text("Enter password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter password";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    bool loginValidated = formkey.currentState!.validate();

                    if (loginValidated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful")));
                      // Navigate to the task list screen after successful login
                      Navigator.pushReplacementNamed(context, '/tasks');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Failed")));
                    }
                  },
                  style:const ButtonStyle(backgroundColor:MaterialStatePropertyAll( Color.fromARGB(255, 170, 115, 229))),
                   child: const Text("Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                   ),  
                )
            ],
          ),
        ),
      ),
    );
  }
}
