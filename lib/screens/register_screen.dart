import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

import '../widgets/custom_font.dart';
import '../widgets/custom_inkwell_button.dart';
import '../widgets/custom_textformfield.dart';
import '../widgets/custom_dialogs.dart';
import 'login_screen.dart';

import '../models/user_model.dart';
import '../session/session.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobilenumController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void register() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      final msg = _firstRegisterError() ?? 'Please fix the highlighted fields.';
      customDialog(context, title: 'Registration Failed', content: msg);
      return;
    }

    Session.currentUser = UserModel(
      firstName: firstnameController.text.trim(),
      lastName: lastnameController.text.trim(),
      username: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );

    customDialog(
      context,
      title: 'Registration Successful',
      content: 'Your account has been created successfully.',
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LogInScreen()),
      );
    });
  }

  String? _firstRegisterError() {
    final firstName = firstnameController.text.trim();
    final lastName = lastnameController.text.trim();
    final mobile = mobilenumController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;
    final confirm = confirmpasswordController.text;

    if (firstName.isEmpty) return 'First name is required';
    if (lastName.isEmpty) return 'Last name is required';

    if (mobile.length != 11) return 'Enter a valid 11-digit mobile number';

    if (username.isEmpty) return 'Username is required';
    if (username.length < 4) return 'Username must be at least 4 characters';

    final passErr = passwordValidator(password);
    if (passErr != null) return passErr;

    if (confirm.isEmpty) return 'Confirm password is required';
    if (confirm != password) return 'Passwords do not match';

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(25),
            ScreenUtil().setHeight(40),
            ScreenUtil().setWidth(25),
            ScreenUtil().setHeight(10),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: ScreenUtil().setHeight(25)),
                CustomFont(
                  text: 'Register here',
                  fontSize: ScreenUtil().setSp(32),
                  fontWeight: FontWeight.bold,
                  color: FB_DARK_PRIMARY,
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                CustomTextformfield(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'First name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'First name is required';
                    }
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: firstnameController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                CustomTextformfield(
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Last name',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Last name is required';
                    }
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: lastnameController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                CustomTextformfield(
                  maxLength: 11,
                  keyboardType: TextInputType.number,
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Mobile number',
                  validator: (value) {
                    if (value == null || value.length != 11) {
                      return 'Enter a valid 11-digit mobile number';
                    }
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: mobilenumController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                CustomTextformfield(
                  keyboardType: TextInputType.emailAddress,
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Username',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username is required';
                    }
                    if (value.length < 4) {
                      return 'Username must be at least 4 characters';
                    }
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: usernameController,
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                CustomTextformfield(
                  isObscure: _obscurePassword,
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  hintText: 'Password',
                  validator: passwordValidator,
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: passwordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: FB_DARK_PRIMARY,
                      size: ScreenUtil().setSp(22),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                Text(
                  '(Password should be 8 characters, a mixture of letter and numbers consisting of at least one special character with Uppercase and Lowercase letters.)',
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: ScreenUtil().setSp(10),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                CustomTextformfield(
                  isObscure: _obscureConfirmPassword,
                  hintText: 'Confirm Password',
                  height: ScreenUtil().setHeight(10),
                  width: ScreenUtil().setWidth(10),
                  onSaved: null,
                  fontColor: null,
                  validator: (value) {
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  hintTextSize: ScreenUtil().setSp(15),
                  fontSize: ScreenUtil().setSp(15),
                  controller: confirmpasswordController,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    child: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: FB_DARK_PRIMARY,
                      size: ScreenUtil().setSp(22),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You have an account? ',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: ScreenUtil().setSp(15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.popAndPushNamed(context, '/login'),
                      child: Text(
                        'Login here',
                        style: TextStyle(
                          color: FB_DARK_PRIMARY,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(10)),
                CustomInkwellButton(
                  onTap: () => register(),
                  height: ScreenUtil().setHeight(45),
                  width: ScreenUtil().screenWidth,
                  fontSize: ScreenUtil().setSp(15),
                  fontWeight: FontWeight.bold,
                  buttonName: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
