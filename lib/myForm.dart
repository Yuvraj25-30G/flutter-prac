import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/main.dart';
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;

class Myform extends StatefulWidget {
  const Myform({Key? key}) : super(key: key);

  @override
  State<Myform> createState() => _MyformState();
}

enum SingingCharacter { Singh, Kochar }
String message = "Snackbar Message";

class _MyformState extends State<Myform> {
  final _formKey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp email_valid =RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  RegExp phone_valid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  bool validateEmail(String email) {
    String _email = email.trim();
    if (email_valid.hasMatch(_email)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatePhone(String phone) {
    String _phone = phone.trim();
    if (phone_valid.hasMatch(_phone)) {
      return true;
    } else {
      return false;
    }
  }

  String dropdownvalue = 'Role';
  SingingCharacter? _character = SingingCharacter.Singh;


  var items = [
    'Role',
    'Developer',
    'Teacher',
    'Product Owner',
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Form"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: '123456789',
                    labelText: 'phone *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your phone";
                    } else {
                      bool result = validatePhone(value);
                      if (result) {
                        return null;
                      } else {
                        return "Wrong Phone Number";
                      }
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'Email please',
                    labelText: 'Email *',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email";
                    } else {
                      bool result = validateEmail(value);
                      if (result) {
                        // create account event
                        return null;
                      } else {
                        return "Invalid Email";
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                DropdownButtonFormField(
                  icon: const Icon(Icons.arrow_downward),
                  value: dropdownvalue,
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.password),
                    hintText: 'Password please',
                    labelText: 'password *',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    } else {
                      //call function to check password
                      bool result = validatePassword(value);
                      if (result) {
                        // create account event
                        return null;
                      } else {
                        return " Password should contain Capital, small letter & Number & Special";
                      }
                    }
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ListTile(
                  title: const Text('Singh is king'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.Singh,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Komchar'),
                  leading: Radio<SingingCharacter>(
                    value: SingingCharacter.Kochar,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent[400],
                    onPrimary: Colors.black,
                  ),
                  child: const Text('Pick and open file',),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const MyHomePage(
                          title: '',
                        );
                      },
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent[400],
                    onPrimary: Colors.black,
                  ),
                  child: const Text('Submit'),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Future<void> submit() async{
                        String dataurl = "localhost:54399/#/";
                        var req = http.Request('POST',Uri.parse(dataurl));
                        // Map<String, String> headers = {"Authorization": 'Token ' + token};
                        // req.headers.addAll(headers);
                      }
                      final snackBar = SnackBar(
                        content: const Text('Letsgoo Successful password'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text("validate password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
