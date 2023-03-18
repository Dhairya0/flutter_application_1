import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/user.dart';
import 'package:flutter_application_1/widget.dart';

import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  Future<void> secureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void initState() {
    secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final passlField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        hintText: "Password",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        onPressed: () {
          signIn(emailController.text, passController.text);
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    final loginGoogle = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.transparent,
      elevation: 0,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 0),
        onPressed: () async {
          await signInWithGoogle();
          setState(() {
            Fluttertoast.showToast(msg: 'Login Successful');
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          });
        },
        child: Text(
          "Login with Google",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
    final loginFb = Material(
      borderRadius: BorderRadius.circular(30),
      color: Colors.transparent,
      elevation: 0,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 10),
        onPressed: () {},
        child: Text(
          "Login with Facebook",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                      width: 300,
                      child: Image.asset(
                        "asset/login.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 10),
                    emailField,
                    SizedBox(height: 20),
                    passlField,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(msg: 'Under Development');
                          },
                          child: Text(
                            "Forgot pass?",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Dont Have an Account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0),
                    CustomWidgets.socialButtonRect(
                      'Login with Google',
                      Color(0xffDF4A32),
                      FontAwesomeIcons.google,
                      onTap: () async {
                        await signInWithGoogle();
                        setState(() {
                          Fluttertoast.showToast(msg: 'Login Successful');
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        });
                      },
                    ),
                    CustomWidgets.socialButtonRect('Login with Facebook',
                        Colors.blue, FontAwesomeIcons.facebookF, onTap: () {
                      Fluttertoast.showToast(msg: 'I am facebook');
                    }),
                    // loginFb,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User? user;
        user = userCredential.user;
        Fluttertoast.showToast(msg: 'Login Successful');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        if (e.code == "user-not-found") {
          Fluttertoast.showToast(msg: 'No user Exists Please Register First');
          print("No User Found for this email");
        } else {
          Fluttertoast.showToast(msg: 'Invalid Password');
        }
      }
    }
  }

  // Future<FirebaseUser>_signIn(BuildContext context) async {
  //   Scaffold.of(context).showSnackBar(new SnackBar(
  //     content: new Text('Sign in button clicked'),
  //   ));

  //   final FacebookLoginResult result =
  //       await facebookSignIn.logInWithReadPermissions(['email']);

  //   FirebaseUser user =
  //       await _fAuth.signInWithFacebook(accessToken: result.accessToken.token);
  //   //Token: ${accessToken.token}

  //   ProviderDetails userInfo = new ProviderDetails(
  //       user.providerId, user.uid, user.displayName, user.photoUrl, user.email);

  //   List<ProviderDetails> providerData = new List<ProviderDetails>();
  //   providerData.add(userInfo);

  //   UserInfoDetails userInfoDetails = new UserInfoDetails(
  //       user.providerId,
  //       user.uid,
  //       user.displayName,
  //       user.photoUrl,
  //       user.email,
  //       user.isAnonymous,
  //       user.isEmailVerified,
  //       providerData);

  //   Navigator.push(
  //     context,
  //     new MaterialPageRoute(
  //       builder: (context) => new DetailedScreen(detailsUser: userInfoDetails),
  //     ),
  //   );

  //   return user;
  // }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    try {
      await _auth
          .signInWithCredential(credential)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } catch (error) {}
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    userModel.role = "resident";
    //userModel.pass = passController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
