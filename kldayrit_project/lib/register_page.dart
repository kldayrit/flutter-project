import 'package:flutter/material.dart';

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
                child: buildTextField('Enter First Name', firstnameController),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: buildTextField('Enter Last Name', lastnameController),
              ),
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
                  child: const Text('REGISTER'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      firstnameController.clear();
                      lastnameController.clear();
                      usernameController.clear();
                      passwordController.clear();
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
