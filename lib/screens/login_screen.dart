import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/UI/input_decoration.dart';

class LoginScreen extends StatelessWidget {

  static const String name = "Login";

  const LoginScreen({Key? key}) : super(key: key);
  
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
                    Text("Login", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2!.copyWith(fontSize:30 ),),
                    const SizedBox(height: 30,),
                    const _LoginForm(),
                  ],
                ),
              ),
              const SizedBox(height: 50,),

              const Text("Crear una nueva cuenta", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),),

              const SizedBox(height: 50,),
            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      //TODO mantener la referencia del Key
      child: Column(
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,

            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: FormInputDecorator.getInputDecoration(icon: Icons.alternate_email_outlined, labelText: "Email", hintText: "test-emai@gmail.com"),
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
          ),

          const SizedBox(height: 30,),

          MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
              child: const Text("Ingresar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),)
              ),
            onPressed: (){
              //TODO Login submit
            }
          )
        ],
      )
    );
  }
}