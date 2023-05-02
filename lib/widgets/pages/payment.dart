import 'package:flutter/material.dart';

class PagePayment extends StatefulWidget {
  const PagePayment({super.key});

  @override
  State<PagePayment> createState() => _PagePaymentState();
}

class _PagePaymentState extends State<PagePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(alignment: Alignment.center,
      child: Text('Helo Payment'),),
    );
  }
}
