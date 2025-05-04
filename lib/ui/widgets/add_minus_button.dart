

import 'package:flutter/material.dart';

class AddAndMinusButtons extends StatelessWidget {

  final int value;
  final VoidCallback onClickAdd;
  final VoidCallback onClickMinus;

  const AddAndMinusButtons({
    super.key,
    required this.value,
    required this.onClickAdd,
    required this.onClickMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 122,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.deepPurple[300], // Equivalent to DarkBlue
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onClickMinus,
            iconSize: 24,
            icon: const Icon(Icons.remove, color: Colors.white),
          ),
          Expanded(
            child: Text(
              value.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              maxLines: 1,
            ),
          ),
          IconButton(
            onPressed: onClickAdd,
            iconSize: 24,
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
