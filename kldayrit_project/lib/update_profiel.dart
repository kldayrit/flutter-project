import 'package:flutter/material.dart';
import 'user_model.dart' as user;

class ShowUpdateProfilePage extends StatefulWidget {
  const ShowUpdateProfilePage({Key? key}) : super(key: key);

  @override
  _ShowUpdateProfilePageState createState() => _ShowUpdateProfilePageState();
}

class _ShowUpdateProfilePageState extends State<ShowUpdateProfilePage> {
  TextEditingController oldpasswordController = TextEditingController(text: "");
  TextEditingController newpasswordController = TextEditingController(text: "");
  TextEditingController firstnameController =
      TextEditingController(text: user.first);
  TextEditingController lastnameController =
      TextEditingController(text: user.last);
  final bool _validate = false; //used for validation of input
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Update Profile"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'UPDATE PROFILE',
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
                      'Enter Old Password', oldpasswordController, true)),
              Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: buildTextField(
                      'Enter New Password', newpasswordController, true)),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('UPDATE'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int check = await user.updateUser(
                          firstnameController.text,
                          lastnameController.text,
                          oldpasswordController.text,
                          newpasswordController.text);
                      if (check == 200) {
                        //display success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blue,
                            content: Container(
                              height: 50.0,
                              child: const Center(
                                child: Text(
                                  'Profile Updated\nExit and Return to Profile to See Changes',
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
                        oldpasswordController.clear();
                        newpasswordController.clear();
                      } else {
                        //display error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Container(
                              height: 50.0,
                              child: const Center(
                                child: Text(
                                  'Failed to Update Profile',
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
        //allow no changes in pasword
        if (password && value!.isEmpty) {
          return null;
        }
        if (value == null || value.isEmpty) {
          return 'Please $label';
        }

        return null;
      },
    );
  }
}
