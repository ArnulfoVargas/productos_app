import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;
  
  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
      children: [
        const _PurpleBox(),

         const _Icon(),

         child,
      ],
    ),
    );
  }
}

class _Icon extends StatelessWidget {
  const _Icon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100,)
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      decoration:_buildBoxDecoration(),
      child: Stack(children: const [
          Positioned(top: -30, left: 50, child: _Bubble(),),
          Positioned(bottom: -10, left: -10, child: _Bubble(),),
          Positioned(top: 150, left: 80, child: _Bubble(),),
          Positioned(top: 45, right: 30, child: _Bubble(),),
          Positioned(bottom: 50, right: -50, child: _Bubble(),),
        ]
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1)
    ]),
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}