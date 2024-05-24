import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy')
        .format(date); // Customize the date format as needed
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$')
        .format(amount); // Customize the currency locale and symbol as need
  }

  static String formatPhoneNumber(String phoneNumber) {
// Assuming a 10-digit US phone number format: (123) 456-7890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
// Add more custom phone number formatting logic for different formats if needed.
    return phoneNumber;
  }

  static String formatEgyptPhoneNumber(String phoneNumber) {
    // Remove any non-numeric characters
    phoneNumber = phoneNumber.replaceAll("[^\\d+]", "");

    if (phoneNumber.startsWith("+20")) {
      return phoneNumber; // Already in +20 11 digits format
    } else if (phoneNumber.length == 10) {
      // Add country code and format (assuming mobile number)
      return "+20${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5)}";
    } else if (phoneNumber.length == 9) {
      // Prepend leading zero and format (assuming landline number)
      return "0${phoneNumber.substring(0, 1)} ${phoneNumber.substring(1, 4)} ${phoneNumber.substring(4)}";
    } else {
      // Invalid Egyptian phone number format
      return "Invalid Egyptian phone number";
    }
  }


  // Not fully tested.
  static String internationalFormatPhoneNumber(String phoneNumber) {
// Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
// Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';

// Add the remaining digits with proper formatting
    final formattedPhoneNumber = StringBuffer();
    formattedPhoneNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }
      int end = i + groupLength;
      formattedPhoneNumber.write(digitsOnly.substring(i, end));
      if (end < digitsOnly.length) {
        formattedPhoneNumber.write(' ');
      }
      i = end;
    }
    return formattedPhoneNumber.toString();
  }
}
