import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctx, chatSnapShot) {
            if (chatSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDocs = chatSnapShot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBuddle(
                message: chatDocs[index]['text'],
                isMe: chatDocs[index]['userId'] == futureSnapshot.data?.uid,
              ),
            );
          },
        );
      },
    );
  }
}
