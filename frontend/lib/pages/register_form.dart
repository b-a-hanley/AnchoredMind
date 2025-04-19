import 'package:flutter/material.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import '../components/my_button.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../services/encrypt_service.dart';
import '../components/my_colours.dart';
import '../controllers/controller_manager.dart';
import '../controllers/profile_controller.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final ProfileController profileController =
      ControllerManager.instance.profileController;
  final EncryptService encryptService = EncryptService();
  final formKey = GlobalKey<FormState>(); // Key to track form state
  final TextEditingController loginTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final FancyPasswordController passwordValidation = FancyPasswordController();
  String mood = "";
  int intensity = 0;
  String selectedDate = "";

  @override
  void initState() {
    super.initState();
    loginTEController.text = "";
  }

  @override
  void dispose() {
    loginTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }

  void attemptLogin() {
    if (formKey.currentState!.validate()) {
      String login = encryptService.encrypt(loginTEController.text);
      String password = encryptService.encrypt(passwordTEController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password == $password')),
      );
      profileController.putAttribute(login: login, password: password);
      String correctLogin = profileController.getLogin();
      String correctPassword = profileController.getPassword();
      if (login == correctLogin && password == correctPassword) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Welcome back!')),
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
              child: Column(children: [
                TextFormField(
                  controller: loginTEController,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                    hintText: "Login",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your login';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                FancyPasswordField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    hintText: "Password",
                  ),
                  controller: passwordTEController,
                  passwordController: passwordValidation,
                  validationRules: {
                    DigitValidationRule(),
                    UppercaseValidationRule(),
                    LowercaseValidationRule(),
                    SpecialCharacterValidationRule(),
                    MinCharactersValidationRule(6),
                    MaxCharactersValidationRule(12),
                  },
                  validator: (value) {
                    return passwordValidation.areAllRulesValidated
                        ? null
                        : 'Not Validated';
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
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  'Back to Login',
                  style: TextStyle(color: MyColours.backgroundGreen),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
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
