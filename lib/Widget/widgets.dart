import 'package:flutter/material.dart';

class ConverButton extends StatelessWidget {
  const ConverButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          'Convert Coordinate',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
