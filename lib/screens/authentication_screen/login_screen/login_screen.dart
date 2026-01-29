import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:cocosmartapp/provider/auth_provider/auth_provider.dart';
import 'package:cocosmartapp/screens/authentication_screen/signup_screen/signup_screen.dart';
import 'package:cocosmartapp/screens/dashboard_screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool? isObscureText = true;

  void change_password_visibility(){
    setState(() {
      isObscureText = !isObscureText!;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        return GestureDetector(
          onTap: (){
            emailFocusNode.unfocus();
            passwordFocusNode.unfocus();
          },
          child: Scaffold(
            backgroundColor: ColorResources.MAIN_BACKGROUND_COLOR,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white, Colors.transparent],
                        stops: [0.7, 1],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      'assets/images/estate.png',
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/2.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Image(image: AssetImage('assets/images/logo.png'), width: 75, height: 75)),
                        Center(
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: ColorResources.BUTTON_BACKGROUND_COLOR,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Please Login To Your Account",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text("Email",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          focusNode: emailFocusNode,
                          controller: emailController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorResources.BUTTON_BACKGROUND_COLOR,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: ColorResources.MAIN_TEXT_COLOR,
                                  width: 2
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Email',
                            hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                            prefixIcon: Icon(Icons.email_rounded),
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text("Password",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          focusNode: passwordFocusNode,
                          controller: passwordController,
                          obscureText: isObscureText??false,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: ColorResources.BUTTON_BACKGROUND_COLOR,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorResources.MAIN_TEXT_COLOR,
                                    width: 2
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                              prefixIcon: Icon(Icons.password_rounded),
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    change_password_visibility();
                                  },
                                  icon: Icon(isObscureText??false?Icons.visibility_rounded:Icons.visibility_off_rounded)
                              )
                          ),
                        ),
                        SizedBox(height: 45,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorResources.BUTTON_BACKGROUND_COLOR,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: (){
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              if(email.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Please enter your email"))
                                );
                                return;
                              }
                              if(password.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Please enter your password"))
                                );
                                return;
                              }

                              Provider.of<AuthProvider>(context,listen: false).signInWithEmailAndPassword(email, password).then((onValue){
                                Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.rightToLeft, child: DashboardScreen()), (route) => false);
                              }).catchError((onError){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(onError.toString()))
                                );
                              });
                            },
                            child: authProvider.isLoading?LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 35):Text("Login",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: SignupScreen()));
                                },
                                child: Text("Sign Up",style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: ColorResources.MAIN_TEXT_COLOR,
                                ),)
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
