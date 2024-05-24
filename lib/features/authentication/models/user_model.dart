import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/utils/formatters/formatters.dart';

/// Model class representing User Data
class UserModel {
  // Keep those values final which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

// Helper Method to get the full Name
  String get fullName => '$firstName $lastName';

// Helper Method to format the phone number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

// static method to split the full name into first and last name
  static List<String> splitFullName(fullName) => fullName.split(' ');

// static method to generate a userName from fullName
  static String generateUserName(fullName) {
    List<String> splitFullName = fullName.split(' ');
    String firstName = splitFullName[0].toLowerCase();
    String lastName = splitFullName.length > 1
        ? splitFullName[1].toLowerCase()
        : splitFullName[1].toLowerCase();
    String camelCaseUsername =
        "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(
        id: '',
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );

  /// Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture
    };
  }

  /// Factory method to create a UserModel from a Firebase document snopshot.
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    }
    return UserModel.fromSnapshot(document);
  }
}
