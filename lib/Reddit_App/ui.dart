// screens/login_screen.dart
import 'package:ecommerce/Reddit_App/controllers.dart';
import 'package:ecommerce/Reddit_App/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RedditLoginScreen extends StatelessWidget {
  final UserController userController = Get.put(UserController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userController.login(usernameController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            Obx(() {
              if (userController.user.value != null) {
                return Text('Logged in as ${userController.user.value!.username}');
              } else if (userController.error.value.isNotEmpty) {
                return Text(userController.error.value, style: TextStyle(color: Colors.red));
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}

// screens/post_list_screen.dart


class PostListScreen extends StatelessWidget {
  final PostController postController = Get.put(PostController());
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit Clone'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              userController.logout();
            },
          ),
        ],
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: postController.posts.length,
          itemBuilder: (context, index) {
            final post = postController.posts[index];
            return Card(
              child: ListTile(
                title: Text(post.title),
                subtitle: Text(post.content),
                leading: Image.network(post.imageUrl),
                trailing: Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_upward),
                      onPressed: () {
                        postController.upvotePost(post);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_downward),
                      onPressed: () {
                        postController.downvotePost(post);
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Get.to(PostDetailsScreen(post: post));
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add post functionality can be implemented here
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// screens/post_details_screen.dart


class PostDetailsScreen extends StatelessWidget {
  final Post post;
  final CommentController commentController = Get.put(CommentController());

  PostDetailsScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    commentController.fetchComments(post.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Column(
        children: [
          Image.network(post.imageUrl),
          Text(post.content),
          Obx(
                () => ListView.builder(
              shrinkWrap: true,
              itemCount: commentController.comments.length,
              itemBuilder: (context, index) {
                final comment = commentController.comments[index];
                return ListTile(
                  title: Text(comment.content),
                  subtitle: Text(comment.author),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                commentController.addComment(post.id, value);
              },
              decoration: InputDecoration(
                labelText: 'Add a comment',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
