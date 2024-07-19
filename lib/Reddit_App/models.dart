// models/user_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String username;

  User({required this.id, required this.username});
}

// models/post_model.dart

class Post {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final int upvotes;
  final int downvotes;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.upvotes,
    required this.downvotes,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      imageUrl: data['imageUrl'],
      upvotes: data['upvotes'],
      downvotes: data['downvotes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'upvotes': upvotes,
      'downvotes': downvotes,
    };
  }
}

// models/comment_model.dart

class Comment {
  final String id;
  final String postId;
  final String content;
  final String author;

  Comment({
    required this.id,
    required this.postId,
    required this.content,
    required this.author,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Comment(
      id: doc.id,
      postId: data['postId'],
      content: data['content'],
      author: data['author'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'content': content,
      'author': author,
    };
  }
}
