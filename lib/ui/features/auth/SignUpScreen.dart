import 'package:expense_app/data/models/user_model.dart';
import 'package:expense_app/ui/features/auth/bloc/user_bloc.dart';
import 'package:expense_app/ui/features/auth/bloc/user_event.dart';
import 'package:expense_app/ui/features/auth/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var mobNoController = TextEditingController();

  var passController = TextEditingController();

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                Center(
                  child: SizedBox(
                    height: 250,
                    child: Image.asset('assets/images/secondScreenImage.png'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Name is Required";
                    } else {
                      return null;
                    }
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Email is Required";
                    } else if(!emailRegExp.hasMatch(value)){
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "MobNo is Required";
                    } else if(value.length!=10){
                      return "Please enter a valid mobile no";
                    } else {
                      return null;
                    }
                  },
                  controller: mobNoController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Password is Required";
                    } else if(value.length<=6){
                      return "Password must be greater than 6 characters";
                    } else {
                      return null;
                    }
                  },
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserLoadingState) {
                      isLoading = true;
                      setState(() {});
                    }

                    if (state is UserSuccessState) {
                      isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("User Registered successfully!!")));
                      Navigator.pop(context);
                    }

                    if (state is UserFailureState) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Error: ${state.errorMsg}")));
                    }
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size(200, 50),
                      ),
                      onPressed: () {
                       if(formKey.currentState!.validate()){
                         ///creating a user
                         context.read<UserBloc>().add(RegisterUserEvent(
                             newUser: UserModel(
                                 userName: nameController.text,
                                 userEmail: emailController.text,
                                 userMobNo: mobNoController.text,
                                 userPass: passController.text)));
                       }
                      },
                      child: isLoading ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 11,
                          ),
                          Text('Signing Up..')
                        ],
                      ) : Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
