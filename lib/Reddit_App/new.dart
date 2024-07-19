import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Get.putAsync(() => SharedPreferences.getInstance());
runApp(MyApp());
}

class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return GetMaterialApp(
title: 'Reddit Clone',
theme: ThemeData.dark().copyWith(
scaffoldBackgroundColor: Color(0xFF1A1A1B),
),
home: LoginView(),
);
}
}

class User {
final String id;
String username;
String email;
String password;

User({
required this.id,
required this.username,
required this.email,
required this.password,
});

Map<String, dynamic> toJson() => {
'id': id,
'username': username,
'email': email,
'password': password,
};

factory User.fromJson(Map<String, dynamic> json) => User(
id: json['id'],
username: json['username'],
email: json['email'],
password: json['password'],
);
}

class Post {
final String id;
final String userId;
final String username;
final String timeAgo;
final String content;
int upvotes;
int commentCount;
bool isUpvoted;
bool isDownvoted;

Post({
required this.id,
required this.userId,
required this.username,
required this.timeAgo,
required this.content,
required this.upvotes,
required this.commentCount,
this.isUpvoted = false,
this.isDownvoted = false,
});

Map<String, dynamic> toJson() => {
'id': id,
'userId': userId,
'username': username,
'timeAgo': timeAgo,
'content': content,
'upvotes': upvotes,
'commentCount': commentCount,
'isUpvoted': isUpvoted,
'isDownvoted': isDownvoted,
};

factory Post.fromJson(Map<String, dynamic> json) => Post(
id: json['id'],
userId: json['userId'],
username: json['username'],
timeAgo: json['timeAgo'],
content: json['content'],
upvotes: json['upvotes'],
commentCount: json['commentCount'],
isUpvoted: json['isUpvoted'],
isDownvoted: json['isDownvoted'],
);
}

class Comment {
  final String id;
  final String postId;
  final String userId;
  final String username;
  final String timeAgo;
  String content;
  final bool isOP;
  int upvotes;
  bool isUpvoted;
  bool isDownvoted;
  final String? parentId;  // Add this line

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.timeAgo,
    required this.content,
    this.isOP = false,
    required this.upvotes,
    this.isUpvoted = false,
    this.isDownvoted = false,
    this.parentId,  // Add this line
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'userId': userId,
    'username': username,
    'timeAgo': timeAgo,
    'content': content,
    'isOP': isOP,
    'upvotes': upvotes,
    'isUpvoted': isUpvoted,
    'isDownvoted': isDownvoted,
    'parentId': parentId,  // Add this line
  };

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json['id'],
    postId: json['postId'],
    userId: json['userId'],
    username: json['username'],
    timeAgo: json['timeAgo'],
    content: json['content'],
    isOP: json['isOP'],
    upvotes: json['upvotes'],
    isUpvoted: json['isUpvoted'],
    isDownvoted: json['isDownvoted'],
    parentId: json['parentId'],  // Add this line
  );
}

class RedditController extends GetxController {
final SharedPreferences prefs = Get.find<SharedPreferences>();
var users = <User>[].obs;
var posts = <Post>[].obs;
var comments = <Comment>[].obs;
var currentUser = Rxn<User>();

@override
void onInit() {
super.onInit();
loadData();
}

void loadData() {
loadUsers();
loadPosts();
loadComments();
}

void loadUsers() {
final usersJson = prefs.getString('users');
if (usersJson != null) {
final List<dynamic> decodedUsers = json.decode(usersJson);
users.assignAll(decodedUsers.map((user) => User.fromJson(user)).toList());
}
}

void loadPosts() {
final postsJson = prefs.getString('posts');
if (postsJson != null) {
final List<dynamic> decodedPosts = json.decode(postsJson);
posts.assignAll(decodedPosts.map((post) => Post.fromJson(post)).toList());
}
}

void loadComments() {
final commentsJson = prefs.getString('comments');
if (commentsJson != null) {
final List<dynamic> decodedComments = json.decode(commentsJson);
comments.assignAll(decodedComments.map((comment) => Comment.fromJson(comment)).toList());
}
}


// Add a map to track expanded posts
final expandedPosts = <String, bool>{}.obs;

// Modify upvote and downvote methods
void toggleVote(String postId, bool isUpvote) {
  final post = posts.firstWhere((p) => p.id == postId);
  if (isUpvote) {
    if (post.isUpvoted) {
      post.upvotes--;
      post.isUpvoted = false;
    } else {
      post.upvotes++;
      post.isUpvoted = true;
      if (post.isDownvoted) {
        post.upvotes++;
        post.isDownvoted = false;
      }
    }
  } else {
    if (post.isDownvoted) {
      post.upvotes++;
      post.isDownvoted = false;
    } else {
      post.upvotes--;
      post.isDownvoted = true;
      if (post.isUpvoted) {
        post.upvotes--;
        post.isUpvoted = false;
      }
    }
  }
  posts.refresh();
  savePosts();
}

void toggleCommentVote(String commentId, bool isUpvote) {
  final comment = comments.firstWhere((c) => c.id == commentId);
  if (isUpvote) {
    if (comment.isUpvoted) {
      comment.upvotes--;
      comment.isUpvoted = false;
    } else {
      comment.upvotes++;
      comment.isUpvoted = true;
      if (comment.isDownvoted) {
        comment.upvotes++;
        comment.isDownvoted = false;
      }
    }
  } else {
    if (comment.isDownvoted) {
      comment.upvotes++;
      comment.isDownvoted = false;
    } else {
      comment.upvotes--;
      comment.isDownvoted = true;
      if (comment.isUpvoted) {
        comment.upvotes--;
        comment.isUpvoted = false;
      }
    }
  }
  comments.refresh();
  saveComments();
}

void toggleExpandPost(String postId) {
  expandedPosts[postId] = !(expandedPosts[postId] ?? false);
}

  void saveUsers() {
prefs.setString('users', json.encode(users.map((user) => user.toJson()).toList()));
}

  void addReply(String postId, String? parentCommentId, String content) {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId,
      userId: currentUser.value!.id,
      username: currentUser.value!.username,
      timeAgo: 'now',
      content: content,
      upvotes: 0,
      parentId: parentCommentId,
    );
    comments.add(newComment);
    final post = posts.firstWhere((p) => p.id == postId);
    post.commentCount++;
    posts.refresh();
    comments.refresh();
    saveComments();
    savePosts();
  }

void savePosts() {
prefs.setString('posts', json.encode(posts.map((post) => post.toJson()).toList()));
}

void saveComments() {
prefs.setString('comments', json.encode(comments.map((comment) => comment.toJson()).toList()));
}

bool login(String username, String password) {
final user = users.firstWhereOrNull((u) => u.username == username && u.password == password);
if (user != null) {
currentUser.value = user;
return true;
}
return false;
}

void logout() {
currentUser.value = null;
}

void register(String username, String email, String password) {
final newUser = User(
id: DateTime.now().millisecondsSinceEpoch.toString(),
username: username,
email: email,
password: password,
);
users.add(newUser);
saveUsers();
}

void updateUser(String userId, {String? username, String? email, String? password}) {
final user = users.firstWhere((u) => u.id == userId);
if (username != null) user.username = username;
if (email != null) user.email = email;
if (password != null) user.password = password;
users.refresh();
saveUsers();
}

void deleteUser(String userId) {
users.removeWhere((u) => u.id == userId);
posts.removeWhere((p) => p.userId == userId);
comments.removeWhere((c) => c.userId == userId);
saveUsers();
savePosts();
saveComments();
}

void addPost(String content) {
final newPost = Post(
id: DateTime.now().millisecondsSinceEpoch.toString(),
userId: currentUser.value!.id,
username: currentUser.value!.username,
timeAgo: 'now',
content: content,
upvotes: 0,
commentCount: 0,
);
posts.add(newPost);
savePosts();
}

void deletePost(String postId) {
posts.removeWhere((post) => post.id == postId);
comments.removeWhere((comment) => comment.postId == postId);
savePosts();
saveComments();
}

// void addComment(String postId, String content) {
// final newComment = Comment(
// id: DateTime.now().millisecondsSinceEpoch.toString(),
// postId: postId,
// userId: currentUser.value!.id,
// username: currentUser.value!.username,
// timeAgo: 'now',
// content: content,
// upvotes: 0,
// );
// comments.add(newComment);
// final post = posts.firstWhere((p) => p.id == postId);
// post.commentCount++;
// posts.refresh();
// saveComments();
// savePosts();
// }

  void addComment(String postId, String content) {
    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      postId: postId,
      userId: currentUser.value!.id,
      username: currentUser.value!.username,
      timeAgo: 'now',
      content: content,
      upvotes: 0,
    );
    comments.add(newComment);
    final post = posts.firstWhere((p) => p.id == postId);
    post.commentCount++;
    saveComments();
    savePosts();
  }

  void deleteComment(String commentId) {
    final comment = comments.firstWhere((c) => c.id == commentId);
    comments.remove(comment);
    final post = posts.firstWhere((p) => p.id == comment.postId);
    post.commentCount--;
    saveComments();
    savePosts();
  }

  void updateComment(String commentId, String newContent) {
    final comment = comments.firstWhere((c) => c.id == commentId);
    comment.content = newContent;
    saveComments();
  }

//   void deleteComment(String commentId) {
// final comment = comments.firstWhere((c) => c.id == commentId);
// comments.remove(comment);
// final post = posts.firstWhere((p) => p.id == comment.postId);
// post.commentCount--;
// posts.refresh();
// saveComments();
// savePosts();
// }

void upvotePost(String postId) {
final post = posts.firstWhere((p) => p.id == postId);
post.isUpvoted = !post.isUpvoted;
post.isDownvoted = false;
post.upvotes += post.isUpvoted ? 1 : -1;
posts.refresh();
savePosts();
}

void downvotePost(String postId) {
final post = posts.firstWhere((p) => p.id == postId);
post.isDownvoted = !post.isDownvoted;
post.isUpvoted = false;
post.upvotes -= post.isDownvoted ? 1 : -1;
posts.refresh();
savePosts();
}

void upvoteComment(String commentId) {
final comment = comments.firstWhere((c) => c.id == commentId);
comment.isUpvoted = !comment.isUpvoted;
comment.isDownvoted = false;
comment.upvotes += comment.isUpvoted ? 1 : -1;
comments.refresh();
saveComments();
}

void downvoteComment(String commentId) {
final comment = comments.firstWhere((c) => c.id == commentId);
comment.isDownvoted = !comment.isDownvoted;
comment.isUpvoted = false;
comment.upvotes -= comment.isDownvoted ? 1 : -1;
comments.refresh();
saveComments();
}
}

class LoginView extends StatelessWidget {
final RedditController controller = Get.put(RedditController());
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Login')),
body: Padding(
padding: EdgeInsets.all(16.0),
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
SizedBox(height: 16),
ElevatedButton(
child: Text('Login'),
onPressed: () {
if (controller.login(usernameController.text, passwordController.text)) {
Get.off(() => RedditPostView());
} else {
Get.snackbar('Error', 'Invalid username or password');
}
},
),
TextButton(
child: Text('Register'),
onPressed: () => Get.to(() => RegisterView()),
),
],
),
),
);
}
}

class RegisterView extends StatelessWidget {
final RedditController controller = Get.find();
final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: Text('Register')),
body: Padding(
padding: EdgeInsets.all(16.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
TextField(
controller: usernameController,
decoration: InputDecoration(labelText: 'Username'),
),
TextField(
controller: emailController,
decoration: InputDecoration(labelText: 'Email'),
),
TextField(
controller: passwordController,
decoration: InputDecoration(labelText: 'Password'),
obscureText: true,
),
SizedBox(height: 16),
ElevatedButton(
child: Text('Register'),
onPressed: () {
controller.register(
usernameController.text,
emailController.text,
passwordController.text,
);
Get.back();
},
),
],
),
),
);
}
}

class RedditPostView extends StatelessWidget {
final RedditController controller = Get.find();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
backgroundColor: Color(0xFF1A1A1B),
title: Text('Reddit Clone'),
actions: [
IconButton(
icon: Icon(Icons.add),
onPressed: () => _showAddPostDialog(context),
),
IconButton(
icon: Icon(Icons.person),
onPressed: () => Get.to(() => ProfileView()),
),
],
),
body: Obx(() => ListView(
children: [
...controller.posts.map((post) => PostCard(post: post)),
],
)),
);
}

void _showAddPostDialog(BuildContext context) {
final TextEditingController contentController = TextEditingController();
showDialog(
context: context,
builder: (context) => AlertDialog(
title: Text('Add New Post'),
content: TextField(
controller: contentController,
decoration: InputDecoration(hintText: 'Enter your post content'),
),
actions: [
TextButton(
child: Text('Cancel'),
onPressed: () => Navigator.of(context).pop(),
),
TextButton(
child: Text('Post'),
onPressed: () {
if (contentController.text.isNotEmpty) {
controller.addPost(contentController.text);
Navigator.of(context).pop();
}
},
),
],
),
);
}
}
class PostCard extends StatelessWidget {
  final Post post;
  final RedditController controller = Get.find();

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Card(
      color: Color(0xFF2D2D2E),
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(child: Text(post.username[0])),
            title: Text(post.username, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(post.timeAgo, style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.more_vert),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(post.content),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward, color: post.isUpvoted ? Colors.orange : Colors.grey),
                onPressed: () => controller.toggleVote(post.id, true),
              ),
              Text(post.upvotes.toString()),
              IconButton(
                icon: Icon(Icons.arrow_downward, color: post.isDownvoted ? Colors.blue : Colors.grey),
                onPressed: () => controller.toggleVote(post.id, false),
              ),
              Spacer(),
              TextButton.icon(
                icon: Icon(Icons.comment),
                label: Text('${post.commentCount} comments'),
                onPressed: () => controller.toggleExpandPost(post.id),
              ),
            ],
          ),
          // if (controller.expandedPosts[post.id] ?? false)
          //   // Column(
          //   //   children: [
          //   //     ...controller.comments
          //   //         .where((comment) => comment.postId == post.id && comment.parentId == null)
          //   //         .map((comment) => CommentCard(comment: comment, postId: post.id)),
          //   //     AddCommentField(postId: post.id),
          //   //   ],
          //   // ),
          //   Column(
          //     children: [
          //       ...controller.comments
          //           .where((comment) => comment.postId == post.id && comment.parentId == null)
          //           .map((comment) => CommentCard(comment: comment, postId: post.id)),
          //       AddCommentField(postId: post.id),
          //     ],
          //   ),
          if (controller.expandedPosts[post.id] ?? false)
            Column(
              children: [
                ...controller.comments
                    .where((comment) => comment.postId == post.id && comment.parentId == null)
                    .map((comment) => CommentCard(comment: comment, postId: post.id)),
                AddCommentField(postId: post.id),
              ],
            ),

        ],
      ),
    ));
  }
}
class CommentCard extends StatelessWidget {
  final Comment comment;
  final String postId;
  final int depth;
  final RedditController controller = Get.find();

  CommentCard({required this.comment, required this.postId , this.depth = 0});

  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 16.0, right: 8.0, top: 8.0, bottom: 8.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             CircleAvatar(child: Text(comment.username[0]), radius: 12),
  //             SizedBox(width: 8),
  //             Text(comment.username, style: TextStyle(fontWeight: FontWeight.bold)),
  //             SizedBox(width: 8),
  //             Text(comment.timeAgo, style: TextStyle(color: Colors.grey)),
  //             if (comment.isOP)
  //               Container(
  //                 margin: EdgeInsets.only(left: 8),
  //                 padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
  //                 decoration: BoxDecoration(
  //                   color: Colors.blue,
  //                   borderRadius: BorderRadius.circular(4),
  //                 ),
  //                 child: Text('OP', style: TextStyle(fontSize: 10)),
  //               ),
  //           ],
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(left: 32.0, top: 4.0),
  //           child: Text(comment.content),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.only(left: 24.0),
  //           child: Row(
  //             children: [
  //               IconButton(
  //                 icon: Icon(Icons.arrow_upward, size: 16, color: comment.isUpvoted ? Colors.orange : Colors.grey),
  //                 onPressed: () => controller.toggleCommentVote(comment.id, true),
  //               ),
  //               Text(comment.upvotes.toString(), style: TextStyle(fontSize: 12)),
  //               IconButton(
  //                 icon: Icon(Icons.arrow_downward, size: 16, color: comment.isDownvoted ? Colors.blue : Colors.grey),
  //                 onPressed: () => controller.toggleCommentVote(comment.id, false),
  //               ),
  //               TextButton(
  //                 child: Text('Reply', style: TextStyle(fontSize: 12)),
  //                 onPressed: () => _showReplyDialog(context),
  //               ),
  //
  //               // Display replies
  //               ...controller.comments
  //                   .where((reply) => reply.parentId == comment.id)
  //                   .map((reply) => CommentCard(comment: reply, postId: postId, depth: depth + 1)),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (depth > 0)
            Container(
              width: 24.0 * depth,
              child: VerticalDivider(
                color: Colors.grey,
                thickness: 1,
                indent: 12,
                endIndent: 12,
              ),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(child: Text(comment.username[0]), radius: 12),
                      SizedBox(width: 8),
                      Text(comment.username, style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Text(comment.timeAgo, style: TextStyle(color: Colors.grey)),
                      if (comment.isOP)
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text('OP', style: TextStyle(fontSize: 10)),
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(comment.content),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_upward, size: 16, color: comment.isUpvoted ? Colors.orange : Colors.grey),
                        onPressed: () => controller.toggleCommentVote(comment.id, true),
                      ),
                      Text(comment.upvotes.toString(), style: TextStyle(fontSize: 12)),
                      IconButton(
                        icon: Icon(Icons.arrow_downward, size: 16, color: comment.isDownvoted ? Colors.blue : Colors.grey),
                        onPressed: () => controller.toggleCommentVote(comment.id, false),
                      ),
                      TextButton(
                        child: Text('Reply', style: TextStyle(fontSize: 12)),
                        onPressed: () => _showReplyDialog(context),
                      ),
                    ],
                  ),
                  ...controller.comments
                      .where((reply) => reply.parentId == comment.id)
                      .map((reply) => CommentCard(comment: reply, postId: postId, depth: depth + 1)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReplyDialog(BuildContext context) {
    final TextEditingController replyController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reply to comment'),
        content: TextField(
          controller: replyController,
          decoration: InputDecoration(hintText: 'Enter your reply'),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text('Reply'),
            onPressed: () {
              if (replyController.text.isNotEmpty) {
                controller.addReply(postId, comment.id, replyController.text);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}

class AddCommentField extends StatelessWidget {
  final String postId;
  final RedditController controller = Get.find();
  final TextEditingController commentController = TextEditingController();

  AddCommentField({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: commentController,
        decoration: InputDecoration(
          hintText: 'Add a comment',
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (commentController.text.isNotEmpty) {
                controller.addReply(postId, null, commentController.text);
                commentController.clear();
              }
            },
          ),
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
final RedditController controller = Get.find();

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Profile'),
actions: [
IconButton(
icon: Icon(Icons.logout),
onPressed: () {
controller.logout();
Get.offAll(() => LoginView());
},
),
],
),
body: Padding(
padding: EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text('Username: ${controller.currentUser.value!.username}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 8),
Text('Email: ${controller.currentUser.value!.email}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
SizedBox(height: 16),
ElevatedButton(
child: Text('Edit Profile'),
onPressed: () => _showEditProfileDialog(context),
),
ElevatedButton(
child: Text('Delete Account'),
onPressed: () => _showDeleteAccountDialog(context),
),
],
),
),
);
}

void _showEditProfileDialog(BuildContext context) {
final TextEditingController usernameController = TextEditingController(text: controller.currentUser.value!.username);
final TextEditingController emailController = TextEditingController(text: controller.currentUser.value!.email);
final TextEditingController passwordController = TextEditingController();

showDialog(
context: context,
builder: (context) => AlertDialog(
title: Text('Edit Profile'),
content: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: usernameController,
decoration: InputDecoration(labelText: 'Username'),
),
TextField(
controller: emailController,
decoration: InputDecoration(labelText: 'Email'),
),
TextField(
controller: passwordController,
decoration: InputDecoration(labelText: 'New Password'),
obscureText: true,
),
],
),
actions: [
TextButton(
child: Text('Cancel'),
onPressed: () => Navigator.of(context).pop(),
),
TextButton(
child: Text('Save'),
onPressed: () {
controller.updateUser(
controller.currentUser.value!.id,
username: usernameController.text,
email: emailController.text,
password: passwordController.text.isNotEmpty ? passwordController.text : null,
);
Navigator.of(context).pop();
},
),
],
),
);
}

void _showDeleteAccountDialog(BuildContext context) {
showDialog(
context: context,
builder: (context) => AlertDialog(
title: Text('Delete Account'),
content: Text('Are you sure you want to delete your account?'),
actions: [
TextButton(
child: Text('Cancel'),
onPressed: () => Navigator.of(context).pop(),
),
TextButton(
child: Text('Delete'),
onPressed: () {
controller.deleteUser(controller.currentUser.value!.id);
controller.logout();
Get.offAll(() => LoginView());
},
),
],
),
);
}
}


