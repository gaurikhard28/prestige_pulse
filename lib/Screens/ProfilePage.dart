import 'package:flutter/material.dart';


  @override
  Widget ProfileTextField(BuildContext context,String labelText,String value,Function(String) onChange,String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            initialValue: value,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.purple, decorationColor: Colors.purpleAccent),
              border: InputBorder.none,
            ),
            onChanged: onChange,
            validator: validator,
          ),
        ),
      ),
    );
  }
  @override
  Widget ProfileRadioButtons(BuildContext context,String value,Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(
                    value: 'Male',
                    groupValue: value,
                    onChanged: (newValue) {
                      onChanged(newValue!);
                    },
                    activeColor: Colors.purple,
                    focusColor: Colors.purple,
                  ),
                  Text('Male'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 'Female',
                    groupValue: value,
                    onChanged: (newValue) {
                      onChanged(newValue!);
                    },
                    activeColor: Colors.purple,
                    focusColor: Colors.purple,
                  ),
                  Text('Female'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget ProfileSubmitButton(BuildContext context,VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple[700],
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: MediaQuery.of(context).size.width - 40,
        height: 45,
        child: Center(
          child: Text(
            'Submit',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String gender = 'Male';
  String country = '';
  String state = '';
  String city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Your Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.purple],
            ),
          ),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ProfileTextField(
                      context,
                       'Name',
                     name,
                      (value) {
                        setState(() {
                          name = value;
                        });
                      },
                       (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    ProfileTextField(
                      context,
                       'Email',
                       email,
                       (value) {
                        setState(() {
                          email = value;
                        });
                      },
                       (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    ProfileTextField(
                      context,
                       'Phone',
                     phone,
                    (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                     (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    ProfileRadioButtons(
                      context,
                     gender,
                       (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    ProfileTextField(
                      context,
                    'Country',
                    country,
                      (value) {
                        setState(() {
                          country = value;
                        });
                      },
                          (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your country';
                        }
                        return null;
                      },
                    ),
                    ProfileTextField(
                      context,
                      'State',
                      state,
                       (value) {
                        setState(() {
                          state = value;
                        });
                      },
                          (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your state';
                        }
                        return null;
                      },
                    ),
                    ProfileTextField(
                      context,
                      'City',
                     city,
                  (value) {
                        setState(() {
                          city = value;
                        });

                      },
                          (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your city';
                        }
                        return null;
                      },
                    ),
                    ProfileSubmitButton(
                      context,
                       () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Saved profile'),
                            ),
                          );
                          // Do something with the data
                        }
                      },
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
