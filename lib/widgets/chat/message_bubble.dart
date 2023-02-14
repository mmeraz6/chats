import 'package:flutter/material.dart';

class MessageBuddle extends StatelessWidget {
  final String message;
  final bool isMe;

  const MessageBuddle({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(message,style: TextStyle(color: Theme.of(context).secondaryHeaderColor),),
        ),
      ],
    );
  }
}
