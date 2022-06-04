import 'package:flutter/material.dart';
import 'register_page.dart';
import 'user_model.dart' as user;
import 'post_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Start Page',
      home: Scaffold(
        appBar: AppBar(title: const Text('Login or Register')),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Gumana ka',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                padding: const EdgeInsets.all(10),
                child: buildTextField('Enter Username', usernameController)),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: buildTextField('Enter Password', passwordController)),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('LOGIN'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    int check = await user.loginUser(
                        usernameController.text, passwordController.text);
                    if (check == 200) {
                      //display success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.blue,
                          content: Container(
                            height: 50.0,
                            child: const Center(
                              child: Text(
                                'Login Succesful',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                      usernameController.clear();
                      passwordController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShowPostPage()));
                    } else {
                      //display error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Container(
                            height: 50.0,
                            child: const Center(
                              child: Text(
                                'Failed to Login using credentials',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Do not have an Account? Cry or'),
                TextButton(
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShowTasksPage()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController _controller) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 213, 82, 125))),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 234, 146, 175))),
          labelText: label,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 11, 69, 169)),
          floatingLabelStyle:
              const TextStyle(color: Color.fromARGB(255, 90, 113, 241)),
          errorText: _validate ? 'Value can\'t be empty' : null),
      style: const TextStyle(color: Colors.indigo),
      validator: (value) {
        //validates if value in controller/textfield is not empty
        if (value == null || value.isEmpty) {
          return 'Please $label';
        }

        return null;
      },
    );
  }
}
