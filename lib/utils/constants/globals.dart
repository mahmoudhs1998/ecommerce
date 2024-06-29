import 'package:get/get.dart';

class Global {

  static final Global _instance = Global._();
  static Global get instance => _instance;





  Global._();
// -- GLOBAL Strings --------------------------------

  static const String favoritesKey = "Favorites";

  // -- GLOBAL Form Validation Strings --------------------------------
  static  String firstName = "First Name".tr;
  static  String lastName = "Last Name".tr;
  static  String userName = "User Name".tr;
  static const String done = "Done";
  static String searchBarHint = "Search In Store";
  
  // -- GLOBAL Firebase  Strings --------------------------------
  static const String usersCollection = "Users";

  static const String uploadProfileImage = 'Users/Images/Profile';
  static const String profilePictureKey = 'ProfilePicture';


}