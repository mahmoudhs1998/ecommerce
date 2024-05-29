class Global {

  static final Global _instance = Global._();
  static Global get instance => _instance;





  Global._();
// -- GLOBAL Strings --------------------------------

  // -- GLOBAL Form Validation Strings --------------------------------
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String userName = "User Name";
  static const String done = "Done";
  static String searchBarHint = "Search In Store";
  
  // -- GLOBAL Firebase  Strings --------------------------------
  static const String usersCollection = "Users";

  static const String uploadProfileImage = 'Users/Images/Profile';
  static const String profilePictureKey = 'ProfilePicture';


}