import 'package:flutter/material.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/encrypt_service.dart';
import '../components/my_button.dart';
import '../controllers/controller_manager.dart';
import '../controllers/profile_controller.dart';
import '../models/profile.dart';
import '../pages/home_page.dart';
import '../pages/register_form.dart';
import '../components/my_colours.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  AgreementPageState createState() => AgreementPageState();
}

class AgreementPageState extends State<AgreementPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColours.backgroundGreen,
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Image.asset("assets/images/logo_clear.png", width: 40, height: 40),
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
                  Center(child: Text("Terms and conditions", style: TextStyle(fontSize: 20),)),
                  SizedBox(height: 20),
                  Text('1. Not a Substitute for Professional Care', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('This app is not yet accredited by any psychological body and should not be used as a substitute for professional mental health or medical care. If you need support, please consult a licensed professional.\n', style: TextStyle(fontSize: 16)),
                  Text('2. Data Collection and Privacy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('The app currently stores data solely on your device. You are the sole controller of your data. Developers do not have access to or manage your data.', style: TextStyle(fontSize: 16)),
                  Text('3. Psychological Accreditation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('The app is not yet accredited or verified by any psychological body and does not provide professional mental health advice or treatment.\n', style: TextStyle(fontSize: 16)),
                  Text('4. Your Rights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('You can access, update, or delete your data at any time and control the information you choose to share.\n', style: TextStyle(fontSize: 16)),
                  Text('By continuing to use the app, you confirm that you understand and accept these terms.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ]
              ),
            ),
            MyButton(
              name: "I agree to Terms & Conditions",
              icon: Icons.check_circle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
