import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final LocalAuthentication fingerPrint = LocalAuthentication();
@override
  void initState() {
    _checkBiometrics();
    super.initState();
  }
bool isAuthenticated = false;
bool? _canCheckBiometrics;
 bool _isAuthenticating = false;
 String text="";
 String _authorized = 'Not Authorized';
 Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await fingerPrint.canCheckBiometrics;
    }  catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
      if(canCheckBiometrics==false){
        text="No biometric authentication available on this device";
      }
      else{
        text="Login with fingerprint";
      }
    });

  }
 
  Future<void> authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await fingerPrint.authenticate(
         localizedReason:
                  'Scan your fingerprint (or face or whatever) to authenticate',
              // useErrorDialogs: false,
              // sensitiveTransaction: false,
              // stickyAuth: true,
              // biometricOnly:
              //     false
      );
     
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.toString}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
       Column(
         children: [
           Center(
            child: Text("$text",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      SizedBox(height: 35,),
      ElevatedButton(onPressed: () {
      authenticateWithBiometrics();
      }, child: Text("Login"))
         ],
       ),
    );
  }
}