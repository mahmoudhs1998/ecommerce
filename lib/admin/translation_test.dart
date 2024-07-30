//
//
// import 'dart:ui';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   Get.put(LocaleController()); // Initialize the LocaleController
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final LocaleController localeController = Get.find();
//     return Obx(() => GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Translation App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       locale: localeController.currentLocale.value, // Use the locale from the controller
//       translations: MyTranslations(), // Your custom translations class
//       home: AdminHomePage(),
//     ));
//   }
// }
//
// class Post {
//   final String id;
//   final RxMap<String, String> titleTranslations;
//   final RxMap<String, String> descriptionTranslations;
//
//   Post({
//     required this.id,
//     required Map<String, String> titleTranslations,
//     required Map<String, String> descriptionTranslations,
//   })  : titleTranslations = RxMap<String, String>.from(titleTranslations),
//         descriptionTranslations = RxMap<String, String>.from(descriptionTranslations);
//
//   factory Post.fromFirestore(DocumentSnapshot doc) {
//     var data = doc.data() as Map<String, dynamic>;
//     return Post(
//       id: doc.id,
//       titleTranslations: Map<String, String>.from(data['titleTranslations'] ?? {}),
//       descriptionTranslations: Map<String, String>.from(data['descriptionTranslations'] ?? {}),
//     );
//   }
//
//   Map<String, dynamic> toFirestore() {
//     return {
//       'titleTranslations': titleTranslations,
//       'descriptionTranslations': descriptionTranslations,
//     };
//   }
// }
// class AdminPostController extends GetxController {
//   var posts = <Post>[].obs;
//
//   Future<void> fetchPosts() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').get();
//     posts.value = snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
//   }
//
//   Future<void> createCollectionIfNotExists() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').limit(1).get();
//     if (snapshot.docs.isEmpty) {
//       DocumentReference newPostRef = FirebaseFirestore.instance.collection('posts').doc();
//       await newPostRef.set({
//         'titleTranslations': {},
//         'descriptionTranslations': {},
//       });
//     }
//   }
//
//   Future<void> addOrUpdateTranslation(String postId, String languageCode, String title, String description) async {
//     DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
//     await FirebaseFirestore.instance.runTransaction((transaction) async {
//       DocumentSnapshot snapshot = await transaction.get(postRef);
//       if (!snapshot.exists) {
//         throw Exception("Post does not exist!");
//       }
//       Post post = Post.fromFirestore(snapshot);
//       post.titleTranslations[languageCode] = title;
//       post.descriptionTranslations[languageCode] = description;
//       transaction.update(postRef, post.toFirestore());
//     });
//     await fetchPosts(); // Refresh the posts list
//   }
//
//   String getFirstPostId() {
//     if (posts.isNotEmpty) {
//       return posts.first.id;
//     }
//     return 'no_posts';
//   }
// }
// class UserPostController extends GetxController {
//   var currentLocale = 'en'.obs; // Default to English
//   var post = Rxn<Post>();
//
//   void fetchPost(String postId) async {
//     DocumentSnapshot doc = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
//     post.value = Post.fromFirestore(doc);
//   }
//
//   void changeLocale(String locale) {
//     currentLocale.value = locale;
//   }
//
//   String getTitle() {
//     return post.value?.titleTranslations[currentLocale.value] ?? post.value?.titleTranslations['en'] ?? 'No Title';
//   }
//
//   String getDescription() {
//     return post.value?.descriptionTranslations[currentLocale.value] ?? post.value?.descriptionTranslations['en'] ?? 'No Description';
//   }
// }
//
// class AdminHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AdminPostController controller = Get.put(AdminPostController());
//     final LocaleController localeController = Get.find();
//
//     controller.createCollectionIfNotExists();
//     controller.fetchPosts();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Home'),
//         actions: [
//           Obx(() {
//             return DropdownButton<Locale>(
//               value: localeController.currentLocale.value,
//               icon: Icon(Icons.language),
//               items: [
//                 DropdownMenuItem(value: Locale('en'), child: Text('English')),
//                 DropdownMenuItem(value: Locale('ar'), child: Text('Arabic')),
//               ],
//               onChanged: (Locale? value) {
//                 if (value != null) {
//                   localeController.changeLocale(value.languageCode);
//                 }
//               },
//             );
//           }),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 itemCount: controller.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = controller.posts[index];
//                   return ListTile(
//                     title: Text(post.titleTranslations['en'] ?? 'No Title'),
//                     subtitle: Text(post.descriptionTranslations['en'] ?? 'No Description'),
//                     onTap: () => Get.to(() => AddTranslationPage(postId: post.id)),
//                   );
//                 },
//               );
//             }),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Get.to(() => AddTranslationPage(postId: 'new_post_id')); // Example postId
//             },
//             child: Text('Add New Translation'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               String firstPostId = controller.getFirstPostId();
//               if (firstPostId != 'no_posts') {
//                 Get.to(() => UserPostPage(postId: firstPostId));
//               } else {
//                 Get.snackbar('No Posts', 'There are no posts available to view.');
//               }
//             },
//             child: Text('Go to User Post Page'),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class AddTranslationPage extends StatelessWidget {
//   final String postId;
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController languageCodeController = TextEditingController();
//
//   AddTranslationPage({required this.postId});
//
//   @override
//   Widget build(BuildContext context) {
//     final AdminPostController controller = Get.find();
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Add Translation')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: languageCodeController,
//               decoration: InputDecoration(labelText: 'Language Code (e.g., en, ar)'),
//             ),
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 controller.addOrUpdateTranslation(
//                   postId,
//                   languageCodeController.text,
//                   titleController.text,
//                   descriptionController.text,
//                 );
//                 Get.back(); // Navigate back
//               },
//               child: Text('Save Translation'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class UserPostPage extends StatelessWidget {
//   final String postId;
//
//   UserPostPage({required this.postId});
//
//   @override
//   Widget build(BuildContext context) {
//     final UserPostController controller = Get.put(UserPostController());
//     final LocaleController localeController = Get.find();
//
//     controller.fetchPost(postId);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Post'),
//       ),
//       body: Obx(() {
//         final post = controller.post.value;
//         if (post == null) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           final languageCode = localeController.currentLocale.value.languageCode;
//           return Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   post.titleTranslations[languageCode] ?? 'No Title',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   post.descriptionTranslations[languageCode] ?? 'No Description',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }
// }
// class TestDropdownButton extends StatefulWidget {
//   @override
//   _TestDropdownButtonState createState() => _TestDropdownButtonState();
// }
//
// class _TestDropdownButtonState extends State<TestDropdownButton> {
//   String _selectedLanguage = 'en';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Test Dropdown Button'),
//         actions: [
//           DropdownButton<String>(
//             value: _selectedLanguage,
//             icon: Icon(Icons.language),
//             items: [
//               DropdownMenuItem(value: 'en', child: Text('English')),
//               DropdownMenuItem(value: 'ar', child: Text('Arabic')),
//             ],
//             onChanged: (value) {
//               if (value != null) {
//                 setState(() {
//                   _selectedLanguage = value;
//                 });
//               }
//             },
//           ),
//         ],
//       ),
//       body: Center(child: Text('Selected Language: $_selectedLanguage')),
//     );
//   }
// }
//
// class LocaleController extends GetxController {
//   var currentLocale = Rx<Locale>(Get.deviceLocale ?? Locale('en'));
//
//   @override
//   void onInit() {
//     super.onInit();
//     Locale systemLocale = Locale(window.locale.languageCode);
//     currentLocale.value = systemLocale;
//     Get.updateLocale(systemLocale);
//   }
//
//   void changeLocale(String languageCode) {
//     Locale locale = Locale(languageCode);
//     currentLocale.value = locale;
//     Get.updateLocale(locale);
//   }
// }
//
// class MyTranslations extends Translations {
//   @override
//   Map<String, Map<String, String>> get keys => {
//     'en': {
//       'title': 'Title',
//       'description': 'Description',
//       'add_translation': 'Add Translation',
//       'go_to_user_post': 'Go to User Post Page',
//     },
//     'ar': {
//       'title': 'عنوان',
//       'description': 'وصف',
//       'add_translation': 'أضف ترجمة',
//       'go_to_user_post': 'الذهاب إلى صفحة المستخدم',
//     },
//   };
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_options.dart';

// Global Keys for Languages
const String language = 'lang';
const String arabic = 'ar';
const String english = 'en';

SharedPreferences? sharedprefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  sharedprefs = await SharedPreferences.getInstance();

  Get.put(LocaleController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocaleController langController = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      locale: langController.initialLanguage,
      fallbackLocale: const Locale(english),
      translations: MyTranslations(),
      home: AdminHomePage(),
    );
  }
}

class LocaleController extends GetxController {
  static LocaleController get instance => Get.find();

  Locale initialLanguage = sharedprefs!.getString(language) == null
      ? Get.deviceLocale!
      : Locale(sharedprefs!.getString(language)!);

  void changeLanguage(String languageCode) {
    Locale currentLocale = Locale(languageCode);
    sharedprefs!.setString(language, languageCode);
    Get.updateLocale(currentLocale);
  }
}

class Post {
  final String id;
  final RxMap<String, String> titleTranslations;
  final RxMap<String, String> descriptionTranslations;

  Post({
    required this.id,
    required Map<String, String> titleTranslations,
    required Map<String, String> descriptionTranslations,
  })  : titleTranslations = RxMap<String, String>.from(titleTranslations),
        descriptionTranslations = RxMap<String, String>.from(descriptionTranslations);

  factory Post.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Post(
      id: doc.id,
      titleTranslations: Map<String, String>.from(data['titleTranslations'] ?? {}),
      descriptionTranslations: Map<String, String>.from(data['descriptionTranslations'] ?? {}),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'titleTranslations': titleTranslations,
      'descriptionTranslations': descriptionTranslations,
    };
  }
}

class AdminPostController extends GetxController {
  var posts = <Post>[].obs;

  Future<void> fetchPosts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').get();
    posts.value = snapshot.docs.map((doc) => Post.fromFirestore(doc)).toList();
  }

  Future<void> createCollectionIfNotExists() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('posts').limit(1).get();
    if (snapshot.docs.isEmpty) {
      DocumentReference newPostRef = FirebaseFirestore.instance.collection('posts').doc();
      await newPostRef.set({
        'titleTranslations': {},
        'descriptionTranslations': {},
      });
    }
  }

  Future<void> addOrUpdateTranslation(String postId, String languageCode, String title, String description) async {
    DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(postRef);
      if (!snapshot.exists) {
        throw Exception("Post does not exist!");
      }
      Post post = Post.fromFirestore(snapshot);
      post.titleTranslations[languageCode] = title;
      post.descriptionTranslations[languageCode] = description;
      transaction.update(postRef, post.toFirestore());
    });
    await fetchPosts(); // Refresh the posts list
  }

  String getFirstPostId() {
    if (posts.isNotEmpty) {
      return posts.first.id;
    }
    return 'no_posts';
  }
}

class UserPostController extends GetxController {
  var post = Rxn<Post>();

  void fetchPost(String postId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('posts').doc(postId).get();
    post.value = Post.fromFirestore(doc);
  }

  String getTitle() {
    String currentLang = Get.locale?.languageCode ?? english.tr;
    return post.value?.titleTranslations[currentLang] ?? post.value?.titleTranslations[english]?.tr ?? 'No Title';
  }

  String getDescription() {
    String currentLang = Get.locale?.languageCode ?? english.tr;
    return post.value?.descriptionTranslations[currentLang] ?? post.value?.descriptionTranslations[english]?.tr ?? 'No Description';
  }
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AdminPostController controller = Get.put(AdminPostController());
    final LocaleController localeController = Get.find();

    controller.createCollectionIfNotExists();
    controller.fetchPosts();

    return Scaffold(
      appBar: AppBar(
        title: Text('admin_home'.tr),
        actions: [
          DropdownButton<String>(
            value: Get.locale?.languageCode,
            icon: Icon(Icons.language),
            items: [
              DropdownMenuItem(value: english, child: Text('English')),
              DropdownMenuItem(value: arabic, child: Text('العربية')),
            ],
            onChanged: (String? value) {
              if (value != null) {
                localeController.changeLanguage(value);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.posts.length,
                itemBuilder: (context, index) {
                  final post = controller.posts[index];
                  return ListTile(
                    title: Text(post.titleTranslations[Get.locale?.languageCode ?? english] ?? 'No Title'),
                    subtitle: Text(post.descriptionTranslations[Get.locale?.languageCode ?? english] ?? 'No Description'),
                    onTap: () => Get.to(() => AddTranslationPage(postId: post.id)),
                  );
                },
              );
            }),
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => AddTranslationPage(postId: 'new_post_id'));
            },
            child: Text('add_new_translation'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              String firstPostId = controller.getFirstPostId();
              if (firstPostId != 'no_posts') {
                Get.to(() => UserPostPage(postId: firstPostId));
              } else {
                Get.snackbar('no_posts'.tr, 'no_posts_available'.tr);
              }
            },
            child: Text('go_to_user_post'.tr),
          ),
        ],
      ),
    );
  }
}

class AddTranslationPage extends StatelessWidget {
  final String postId;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController languageCodeController = TextEditingController();

  AddTranslationPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    final AdminPostController controller = Get.find();

    return Scaffold(
      appBar: AppBar(title: Text('add_translation'.tr)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: languageCodeController,
              decoration: InputDecoration(labelText: 'language_code'.tr),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'title'.tr),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'description'.tr),
            ),
            ElevatedButton(
              onPressed: () {
                controller.addOrUpdateTranslation(
                  postId,
                  languageCodeController.text,
                  titleController.text,
                  descriptionController.text,
                );
                Get.back();
              },
              child: Text('save_translation'.tr),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPostPage extends StatelessWidget {
  final String postId;

  UserPostPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    final UserPostController controller = Get.put(UserPostController());

    controller.fetchPost(postId);

    return Scaffold(
      appBar: AppBar(
        title: Text('user_post'.tr),
      ),
      body: Obx(() {
        final post = controller.post.value;
        if (post == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.getTitle().tr,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  controller.getDescription().tr,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    english: {
      'admin_home': 'Admin Home',
      'title': 'Title',
      'description': 'Description',
      'add_translation': 'Add Translation',
      'go_to_user_post': 'Go to User Post Page',
      'user_post': 'User Post',
      'add_new_translation': 'Add New Translation',
      'no_posts': 'No Posts',
      'no_posts_available': 'There are no posts available to view.',
      'language_code': 'Language Code (e.g., en, ar)',
      'save_translation': 'Save Translation',
    },
    arabic: {
      'admin_home': 'الصفحة الرئيسية للمشرف',
      'title': 'عنوان',
      'description': 'وصف',
      'add_translation': 'أضف ترجمة',
      'go_to_user_post': 'الذهاب إلى صفحة المستخدم',
      'user_post': 'منشور المستخدم',
      'add_new_translation': 'إضافة ترجمة جديدة',
      'no_posts': 'لا توجد منشورات',
      'no_posts_available': 'لا توجد منشورات متاحة للعرض.',
      'language_code': 'رمز اللغة (مثل: en, ar)',
      'save_translation': 'حفظ الترجمة',
    },
  };
}