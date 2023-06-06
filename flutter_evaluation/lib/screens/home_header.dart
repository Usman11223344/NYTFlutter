import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeHeader extends StatelessWidget {
  String title;

  // ignore: use_key_in_widget_constructors
  HomeHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 60, bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
