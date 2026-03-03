import 'package:cocosmartapp/color_resources/color_resources.dart';
import 'package:cocosmartapp/provider/auth_provider/auth_provider.dart';
import 'package:cocosmartapp/screens/authentication_screen/estate_registration/estate_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool? isObscureTextPassword = true;
  bool? isObscureTextConfirmPassword = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  void change_password_visibility(){
    setState(() {
      isObscureTextPassword = !isObscureTextPassword!;
    });
  }

  void change_confirm_password_visibility(){
    setState(() {
      isObscureTextConfirmPassword = !isObscureTextConfirmPassword!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        return GestureDetector(
          onTap: (){
            emailFocusNode.unfocus();
            phoneFocusNode.unfocus();
            userNameFocusNode.unfocus();
            passwordFocusNode.unfocus();
            confirmPasswordFocusNode.unfocus();
          },
          child: Scaffold(
            backgroundColor:ColorResources.MAIN_BACKGROUND_COLOR,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded,color: ColorResources.MAIN_TEXT_COLOR,)
              ),
              backgroundColor: ColorResources.MAIN_BACKGROUND_COLOR,
              surfaceTintColor: ColorResources.MAIN_BACKGROUND_COLOR,
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                        width: 75,
                        height: 75,
                      ),
                    ),
                    Center(child: Text("Signup", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: ColorResources.BUTTON_BACKGROUND_COLOR))),
                    Center(
                      child: Text(
                        "Let's Create Your Account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("Email",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      focusNode: emailFocusNode,
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
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Phone Number",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      focusNode: phoneFocusNode,
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
                        hintText: 'Phone Number (Ex: 077xxxxxxx)',
                        hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("User Name",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: userNameController,
                      focusNode: userNameFocusNode,
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
                        hintText: 'User Name',
                        hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Password",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                    TextField(
                      textInputAction: TextInputAction.next,
                       keyboardType: TextInputType.text,
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscureText: isObscureTextPassword??false,
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
                              icon: Icon(isObscureTextPassword??false?Icons.visibility_rounded:Icons.visibility_off_rounded)
                          )
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Confirm Password",style: TextStyle(fontWeight: FontWeight.w700,color: ColorResources.MAIN_TEXT_COLOR),),
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocusNode,
                      obscureText: isObscureTextConfirmPassword??false,
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
                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                          prefixIcon: Icon(Icons.password_rounded),
                          suffixIcon: IconButton(
                              onPressed: (){
                                change_confirm_password_visibility();
                              },
                              icon: Icon(isObscureTextConfirmPassword??false?Icons.visibility_rounded:Icons.visibility_off_rounded)
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
                        onPressed: () async {
                          if(emailController.text.isEmpty||
                              phoneController.text.isEmpty||
                              userNameController.text.isEmpty||
                              passwordController.text.isEmpty||
                              confirmPasswordController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please fill all the fields"),
                              ),
                            );
                            return;
                          }
                          if(RegExp([r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+"].join('')).hasMatch(emailController.text)==false){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Please enter a valid email address"),
                              ),
                            );
                            return;
                          }
                          if(passwordController.text!=confirmPasswordController.text){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Password and Confirm Password do not match"),
                              ),
                            );
                            return;
                          }
                          String? email = emailController.text.trim();
                          String? name = userNameController.text.trim();
                          String? phone = phoneController.text.trim();
                          String? password = passwordController.text.trim();

                          await Provider.of<AuthProvider>(context,listen: false).signUpWithEmailAndPassword(email, name, phone, password).then((onValue){
                            Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft,child: EstateLocationScreen()));
                          }).catchError((onError){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(onError.toString().replaceAll(RegExp(r'Exception:'), ''))
                                ));
                          });

                        },
                          child: authProvider.isLoading?LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: 35):Text("Create Account",style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),)
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ",style: TextStyle(color: Colors.grey),),
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Login",style: TextStyle(
                            color: ColorResources.MAIN_TEXT_COLOR,
                            fontWeight: FontWeight.w700,
                          ),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
