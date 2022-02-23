import 'package:covid_vaccination/app/presentation/components/loading_widget.dart';
import 'package:covid_vaccination/app/presentation/user_home_page.dart';
import 'package:covid_vaccination/application/data/cubit/application_cubit.dart';
import 'package:covid_vaccination/application/presentation/application_page.dart';
import 'package:covid_vaccination/authentication/data/cubit/user_auth_cubit.dart';
import 'package:covid_vaccination/authentication/data/models/user.dart';
import 'package:covid_vaccination/authentication/presentation/components/authentication_button.dart';
import 'package:covid_vaccination/authentication/presentation/components/header.dart';
import 'package:covid_vaccination/authentication/presentation/components/hover_text_button.dart';
import 'package:covid_vaccination/authentication/presentation/components/login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _occupationController = TextEditingController();
  TextEditingController _nidController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  int index = 0;

  Widget getWidget(int state) {
    switch (state) {
      case 0:
        return buildLoginColumn();

      case 1:
        return buildNextColumn();

      case 2:
        return buildSignupColumn();

      default:
        return buildLoginColumn();
    }
  }

  handleApplicationRouting(int userId, BuildContext context) {
    context.read<ApplicationCubit>().getApplication(userId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplicationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Header(),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 300,
                  width: 400,
                  child: Lottie.asset(
                    'assets/lottie/getting_vaccinated.json',
                  ),
                ),
                Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.all(16),
                  child: BlocConsumer<UserAuthCubit, UserAuthState>(
                    listener: (context, state) {
                      if (state is UserAuthError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                          ),
                        );
                      }

                      if (state is UserAuthLoaded) {
                        index == 2
                            ? showLoginDialog(context)
                            : handleApplicationRouting(
                                state.user.userId, context);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserAuthInitial) {
                        return getWidget(index);
                      }

                      if (state is UserAuthLoading) {
                        return LoadingWidget();
                      }

                      return getWidget(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSignupColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          'Signup',
          style: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: -2.5,
          ),
        ),
        const Spacer(),
        TextFormField(
          controller: _nidController,
          decoration: InputDecoration(
            labelText: 'NID',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. XXXXXXXXXX',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.badge),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _occupationController,
                decoration: InputDecoration(
                  labelText: 'Occupation',
                  labelStyle: TextStyle(fontSize: 22),
                  hintText: 'eg. Advocate',
                  hintStyle: TextStyle(fontSize: 22),
                  prefixIcon: Icon(Icons.work),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 32),
            Container(
              width: 128,
              child: TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  labelStyle: TextStyle(fontSize: 22),
                  hintText: 'eg. 57',
                  hintStyle: TextStyle(fontSize: 22),
                  prefixIcon: Icon(Icons.schedule),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(fontSize: 22),
                  hintText: 'eg. Banasree',
                  hintStyle: TextStyle(fontSize: 22),
                  prefixIcon: Icon(Icons.map),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone no',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. 017-XXXX-XXXX',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.call),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 32),
        AuthenticationButton(
          text: 'SIGNUP',
          onTap: () {
            User user = User(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
              nid: _nidController.text,
              phoneNo: int.parse(_phoneController.text),
              location: _locationController.text,
              occupation: _occupationController.text,
              age: int.parse(_ageController.text),
            );

            context.read<UserAuthCubit>().registerUser(user);
          },
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: HoverTextButton(
            text: 'Already have an account? Login!',
            onTap: () {
              setState(() {
                index = 0;
              });
            },
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  buildNextColumn() {
    print("123456789");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Text(
          'Signup',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: 1.5,
          ),
        ),
        TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. Ikramul Hasan',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.person),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. ikramhasan.dev@gmail.com',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.email),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. 12345678',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.lock),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 0),
        AuthenticationButton(
          text: 'NEXT',
          onTap: () {
            setState(() {
              index = 2;
            });
          },
        ),
        const Spacer(),
        Align(
          alignment: Alignment.center,
          child: HoverTextButton(
            text: 'Already have an account? Login!',
            onTap: () {
              setState(() {
                index = 0;
              });
            },
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget buildLoginColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 0),
        Text(
          'Login',
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            height: 1.1,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 50),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. ikramhasan.dev@gmail.com',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.email),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(fontSize: 22),
            hintText: 'eg. 12345678',
            hintStyle: TextStyle(fontSize: 22),
            prefixIcon: Icon(Icons.lock),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 15),
        AuthenticationButton(
          text: 'LOGIN',
          onTap: () {
            context.read<UserAuthCubit>().loginUser(
                  _emailController.text,
                  _passwordController.text,
                );
          },
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: HoverTextButton(
            text: 'Don\'t have an account? Signup!',
            onTap: () {
              setState(() {
                index = 1;
              });
            },
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
