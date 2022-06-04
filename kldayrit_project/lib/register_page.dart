import 'package:flutter/material.dart';
import 'user_model.dart' as user;

//import necessary packages
class ShowTasksPage extends StatefulWidget {
  const ShowTasksPage({Key? key}) : super(key: key);

  @override
  _ShowTasksPageState createState() => _ShowTasksPageState();
}

class _ShowTasksPageState extends State<ShowTasksPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  final bool _validate = false; //used for validation of input
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Task List"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'REGiSTER',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: buildTextField(
                    'Enter First Name', firstnameController, false),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: buildTextField(
                    'Enter Last Name', lastnameController, false),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: buildTextField(
                      'Enter Username', usernameController, false)),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: buildTextField(
                      'Enter Password', passwordController, true)),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('REGISTER'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int check = await user.registerUser(
                          firstnameController.text,
                          lastnameController.text,
                          usernameController.text,
                          passwordController.text);
                      if (check == 200) {
                        //display success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blue,
                            content: Container(
                              height: 50.0,
                              child: const Center(
                                child: Text(
                                  'Successfuly Registered New User',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        );
                        firstnameController.clear();
                        lastnameController.clear();
                        usernameController.clear();
                        passwordController.clear();
                      } else {
                        //display error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Container(
                              height: 50.0,
                              child: const Center(
                                child: Text(
                                  'Failed to Register User',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String label, TextEditingController _controller, bool password) {
    return TextFormField(
      obscureText: password,
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
          errorText: _validate ? 'Field can\'t be empty' : null),
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
