import 'package:city_guide/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:city_guide/components/textField_widget.dart';
import 'package:city_guide/components/custom_button.dart';
import 'package:city_guide/core/utils/toaster_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
  
}

class _LoginFormState extends ConsumerState<LoginForm> {
   final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscureText = true;

  _toggleObscureText(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

   @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login(BuildContext context)async{
     if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });
    final cityGuideservice = ref.read(firebaseServiceProvider);

    try{
        final errorMessage = await cityGuideservice.signIn(
      email: emailController.text.trim(), 
      password: passwordController.text.trim()
      );

      bool isAdmin = errorMessage?['isAdmin'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    setState(() {
      _isLoading = false;
    });
    if (errorMessage?['message'] == null) {
      if (isAdmin) {
        await prefs.setBool('isAdmin', true);
        Get.offNamed('/admin-main');
        // Navigator.pushReplacementNamed(context, '/admin-main');
      } else {
        Get.offNamed('/main');
        // Navigator.pushReplacementNamed(context, '/main');
      }
    } else {
      final error = errorMessage?['message'] ?? 'An unknown error occurred';
      // Show error message using a SnackBar
      ToasterUtils.showCustomSnackBar(context, error);
    }
    }catch(e){
      setState(() {
      _isLoading = false;
    });
    ToasterUtils.showCustomSnackBar(context, 'An error occurred');
    }
    
  
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
                  TextfieldWidget(
                placeholder: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                   if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
                },
                prefixIcon: const Icon(
                  Icons.alternate_email,
                  color: Colors.grey,
                  size: 21,
                )
              ),
            const SizedBox(height: 10),
            //  TextfieldWidget(
            //     placeholder: 'Password',
            //     controller: passwordController,
            //     isPassword: true,
            //     validator: (value) {
            //            if (value == null || value.isEmpty) {
            //     return 'Please enter your password';
            //   } else if (value.length < 6) {
            //     return 'Password must be at least 6 characters long';
            //   }
            //   return null;
            //     },
            //     prefixIcon: const Icon(
            //       Icons.lock_outline,
            //       color: Colors.grey,
            //       size: 21,
            //     )
            //   ),
              
              TextFormField(
            controller: passwordController,
            cursorColor: Colors.grey.shade800,
            onTapOutside: (e) {
              FocusScope.of(context).unfocus();
            },
            validator: (value) {
                       if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
                },
            obscureText: _obscureText,
            readOnly: false,
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon:  const Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                  size: 21,
                ),
              filled: true,
              fillColor: const Color(0xFFF5FCF9),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0 * 1.5, vertical: 16.0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              hintText: 'Password',
              hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
              suffixIcon: 
                   InkWell(
                      child: IconButton(
                        onPressed: _toggleObscureText,
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility, // Toggle icons correctly
                          color: Colors.grey,
                        ),
                      ),
                    )
            ),
          ),
          const SizedBox(height: 20),

               
          CustomButton(
            onPressed: () {
              _login(context);
            },
            buttonText: "Login",
            isLoading: _isLoading,
          ),
          ],
        ),
      ),
    );
  }
}