// controllers/user_controller.dart


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Reddit_App/models.dart';
import 'package:ecommerce/Reddit_App/ui.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var user = Rxn<User>();
  var error = ''.obs;

  // Predefined users
  final users = {
    'user1': 'password1',
    'user2': 'password2',
  };

  void login(String username, String password) {
    if (users.containsKey(username) && users[username] == password) {
      user.value = User(id: username, username: username);
      error.value = '';
      Get.offAll(PostListScreen());
    } else {
      error.value = 'Invalid username or password';
    }
  }

  void logout() {
    user.value = null;
    Get.offAll(RedditLoginScreen());
  }
}

// controllers/post_controller.dart


class PostController extends GetxController {
  var posts = <Post>[].obs;
  final UserController userController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  void fetchPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      var postList = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
      posts.assignAll(postList);
    });
  }

  void upvotePost(Post post) {
    FirebaseFirestore.instance.collection('posts').doc(post.id).update({
      'upvotes': post.upvotes + 1,
    });
  }

  void downvotePost(Post post) {
    FirebaseFirestore.instance.collection('posts').doc(post.id).update({
      'downvotes': post.downvotes + 1,
    });
  }

  void addPost(String title, String content, String imageUrl) {
    final user = userController.user.value!;
    FirebaseFirestore.instance.collection('posts').add({
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'upvotes': 0,
      'downvotes': 0,
      'author': user.username,
    });
  }
}

// controllers/comment_controller.dart


class CommentController extends GetxController {
  var comments = <Comment>[].obs;
  final UserController userController = Get.find();

  void fetchComments(String postId) {
    FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      var commentList = snapshot.docs.map((doc) => Comment.fromDocument(doc)).toList();
      comments.assignAll(commentList);
    });
  }

  void addComment(String postId, String content) {
    final user = userController.user.value!;
    FirebaseFirestore.instance.collection('comments').add({
      'postId': postId,
      'content': content,
      'author': user.username,
    });
  }
}
