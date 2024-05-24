
class TFirebaseException implements Exception {
  final String message;

  TFirebaseException(this.message);

  @override
  String toString() => 'TFirebaseException: $message';
}
class TFirebaseAuthException implements Exception {


  final String message;



  TFirebaseAuthException(this.message);

  @override
  String toString() => 'FirebaseAuthException: $message';
}


class TFormatException implements Exception {
  @override
  String toString() => 'TFormatException: Invalid data format encountered.';  // Replace with a real message
}

class TPlatformException implements Exception {
  final String message;

  TPlatformException(this.message);

  @override
  String toString() => 'TPlatformException: An error occurred on the platform. : $message';
}
