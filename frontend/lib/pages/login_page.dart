import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/encrypt_service.dart';
import '../components/my_button.dart';
import '../controllers/controller_manager.dart';
import '../controllers/profile_controller.dart';
import '../models/profile.dart';
import '../pages/home_page.dart';
import '../pages/register_form.dart';
import '../components/my_colours.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final ProfileController profileController =
      ControllerManager.instance.profileController;
  final EncryptService encryptService = EncryptService();
  final formKey = GlobalKey<FormState>();
  final TextEditingController loginTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  String mood = "";
  int intensity = 0;
  String selectedDate = "";
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    profileController.init();
    loginTEController.text = "";
    passwordTEController.text = "";
  }

  @override
  void dispose() {
    loginTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }

  void attemptLogin() {
    if (formKey.currentState!.validate()) {
      String login = loginTEController.text;
      String password = passwordTEController.text;
      Profile? profile = profileController.searchLogin(login);
      if (profile==null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login or Password is incorrect")),
        );
        return;
      }
      String correctLogin = encryptService.decrypt(profile.login);
      String correctPassword = encryptService.decrypt(profile.password);
      if (login == correctLogin && password == correctPassword) {
        AuthService authService = AuthService();
        authService.login(profile.id);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome back ${authService.getLogin}!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login or Password is incorrect")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Image.asset("assets/images/logo_clear.png",
                  width: 40, height: 40),
              Text(
                "AnchoredMind",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        backgroundColor: MyColours.primary,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: MyColours.teal,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Center(child: Text("Sign-in", style: TextStyle(fontSize: 20),)),
                    SizedBox(height: 20),
                    TextFormField(
                  controller: loginTEController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                    hintText: "use Login",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your login';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: obscureText,
                  controller: passwordTEController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    hintText: "use Password1",
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ]),
            ),
            MyButton(
              name: "Login",
              icon: Icons.login,
              onPressed: attemptLogin,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterForm()),
                  );
                },
                child: Text(
                  'Create account',
                  style: TextStyle(color: MyColours.backgroundGreen),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterForm()),
                  );
                },
                child: Text(
                  'Change password',
                  style: TextStyle(color: MyColours.backgroundGreen),
                ),
              ),
            ])
          ]),
        ),
      ),
    );
  }
}
