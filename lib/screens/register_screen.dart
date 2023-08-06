import 'package:flutter/material.dart';
import 'package:productos_app/Themes/themes.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/UI/input_decoration.dart';
import "package:productos_app/services/services.dart";

class RegisterScreen extends StatelessWidget {

  static const String name = "Register";

  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox( height: 250,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),

                    Text("Crear nueva cuenta", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2!.copyWith(fontSize:30 ),),

                    const SizedBox(height: 30,),

                    ChangeNotifierProvider(
                      create:(_) => LoginFormProvider(), 
                      child: const _LoginForm(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50,),

              TextButton(
                onPressed: (() => Navigator.pushReplacementNamed(context, LoginScreen.name)), 
                child:
                 const Text("¿Ya tienes una cuenta?", textAlign: TextAlign.center, style: CustomTheme.buttonTextStyle,),
                ),

              const SizedBox(height: 50,),
            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  const _LoginForm();

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,

            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: FormInputDecorator.getInputDecoration(icon: Icons.alternate_email_outlined, labelText: "Email", hintText: "test-emai@gmail.com"),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? "") ? null : "Email no valido";
            },
          ),

          const SizedBox(height: 30,),
          
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: FormInputDecorator.getInputDecoration(icon: Icons.lock_outline ,labelText: "Password", hintText: "********"),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value != null && value.length >= 8) {
                return null;
              } else {
                return "La contraseña debe tener al menos 8 caracteres";
              }
            }
          ),

          const SizedBox(height: 30,),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            // ignore: sort_child_properties_last
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              child: Text( 
                loginForm.isLoading ? "Espere" : "Ingresar" , 
                style: const TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 19),
                )
              ),
            onPressed: loginForm.isLoading ? null : () async {
              FocusScope.of(context).unfocus();

              if(!loginForm.isValidForm()) return;  

              final AuthService service = Provider.of<AuthService>(context, listen: false);
              loginForm.isLoading = true;

              //Todo cambiar por el sign in
              final String? err = await service.createUser(email: loginForm.email, password: loginForm.password);

              if (err == null)              
              {
                Navigator.pushReplacementNamed(context, HomeScreen.name);
              }else {
                print("Error"); // TODO Mostrar error
                loginForm.isLoading = true;
              }
            }
          )
        ],
      )
    );
  }
}