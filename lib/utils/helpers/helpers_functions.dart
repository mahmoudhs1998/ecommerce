import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  // static Color? getColor(String value) {
  //   switch (value) {
  //     case "Green":
  //       return Colors.green;
  //     case "Red":
  //       return Colors.red;
  //     case "Blue":
  //       return Colors.blue;
  //     case "Pink":
  //       return Colors.pink;
  //     case "Grey":
  //       return Colors.grey;
  //     case "Purple":
  //       return Colors.purple;
  //     case "Black":
  //       return Colors.black;
  //     case "White":
  //       return Colors.white;
  //     default:
  //       return null;
  //   }
  // }
  //
  // // Comprehensive map of color names to hex values with capitalized keys
  // static final Map<String, String> _colorNameToHex = {
  //   "AliceBlue": "#F0F8FF",
  //   "AntiqueWhite": "#FAEBD7",
  //   "Aqua": "#00FFFF",
  //   "Aquamarine": "#7FFFD4",
  //   "Azure": "#F0FFFF",
  //   "Beige": "#F5F5DC",
  //   "Bisque": "#FFE4C4",
  //   "Black": "#000000",
  //   "BlanchedAlmond": "#FFEBCD",
  //   "Blue": "#0000FF",
  //   "BlueViolet": "#8A2BE2",
  //   "Brown": "#A52A2A",
  //   "Burlywood": "#DEB887",
  //   "CadetBlue": "#5F9EA0",
  //   "Chartreuse": "#7FFF00",
  //   "Chocolate": "#D2691E",
  //   "Coral": "#FF7F50",
  //   "CornflowerBlue": "#6495ED",
  //   "Cornsilk": "#FFF8DC",
  //   "Crimson": "#DC143C",
  //   "Cyan": "#00FFFF",
  //   "DarkBlue": "#00008B",
  //   "DarkCyan": "#008B8B",
  //   "DarkGoldenrod": "#B8860B",
  //   "DarkGray": "#A9A9A9",
  //   "DarkGreen": "#006400",
  //   "DarkKhaki": "#BDB76B",
  //   "DarkMagenta": "#8B008B",
  //   "DarkOliveGreen": "#556B2F",
  //   "DarkOrange": "#FF8C00",
  //   "DarkOrchid": "#9932CC",
  //   "DarkRed": "#8B0000",
  //   "DarkSalmon": "#E9967A",
  //   "DarkSeaGreen": "#8FBC8F",
  //   "DarkSlateBlue": "#483D8B",
  //   "DarkSlateGray": "#2F4F4F",
  //   "DarkTurquoise": "#00CED1",
  //   "DarkViolet": "#9400D3",
  //   "DeepPink": "#FF1493",
  //   "DeepSkyBlue": "#00BFFF",
  //   "DimGray": "#696969",
  //   "DodgerBlue": "#1E90FF",
  //   "Firebrick": "#B22222",
  //   "FloralWhite": "#FFFAF0",
  //   "ForestGreen": "#228B22",
  //   "Fuchsia": "#FF00FF",
  //   "Gainsboro": "#DCDCDC",
  //   "GhostWhite": "#F8F8FF",
  //   "Gold": "#FFD700",
  //   "Goldenrod": "#DAA520",
  //   "Gray": "#808080",
  //   "Green": "#008000",
  //   "GreenYellow": "#ADFF2F",
  //   "Honeydew": "#F0FFF0",
  //   "HotPink": "#FF69B4",
  //   "IndianRed": "#CD5C5C",
  //   "Indigo": "#4B0082",
  //   "Ivory": "#FFFFF0",
  //   "Khaki": "#F0E68C",
  //   "Lavender": "#E6E6FA",
  //   "LavenderBlush": "#FFF0F5",
  //   "LawnGreen": "#7CFC00",
  //   "LemonChiffon": "#FFFACD",
  //   "LightBlue": "#ADD8E6",
  //   "LightCoral": "#F08080",
  //   "LightCyan": "#E0FFFF",
  //   "LightGoldenrodYellow": "#FAFAD2",
  //   "LightGray": "#D3D3D3",
  //   "LightGreen": "#90EE90",
  //   "LightPink": "#FFB6C1",
  //   "LightSalmon": "#FFA07A",
  //   "LightSeaGreen": "#20B2AA",
  //   "LightSkyBlue": "#87CEFA",
  //   "LightSlateGray": "#778899",
  //   "LightSteelBlue": "#B0C4DE",
  //   "LightYellow": "#FFFFE0",
  //   "Lime": "#00FF00",
  //   "LimeGreen": "#32CD32",
  //   "Linen": "#FAF0E6",
  //   "Magenta": "#FF00FF",
  //   "Maroon": "#800000",
  //   "MediumAquamarine": "#66CDAA",
  //   "MediumBlue": "#0000CD",
  //   "MediumOrchid": "#BA55D3",
  //   "MediumPurple": "#9370DB",
  //   "MediumSeaGreen": "#3CB371",
  //   "MediumSlateBlue": "#7B68EE",
  //   "MediumSpringGreen": "#00FA9A",
  //   "MediumTurquoise": "#48D1CC",
  //   "MediumVioletRed": "#C71585",
  //   "MidnightBlue": "#191970",
  //   "MintCream": "#F5FFFA",
  //   "MistyRose": "#FFE4E1",
  //   "Moccasin": "#FFE4B5",
  //   "NavajoWhite": "#FFDEAD",
  //   "Navy": "#000080",
  //   "OldLace": "#FDF5E6",
  //   "Olive": "#808000",
  //   "OliveDrab": "#6B8E23",
  //   "Orange": "#FFA500",
  //   "OrangeRed": "#FF4500",
  //   "Orchid": "#DA70D6",
  //   "PaleGoldenrod": "#EEE8AA",
  //   "PaleGreen": "#98FB98",
  //   "PaleTurquoise": "#AFEEEE",
  //   "PaleVioletRed": "#D87093",
  //   "PapayaWhip": "#FFEFD5",
  //   "PeachPuff": "#FFDAB9",
  //   "Peru": "#CD853F",
  //   "Pink": "#FFC0CB",
  //   "Plum": "#DDA0DD",
  //   "PowderBlue": "#B0E0E6",
  //   "Purple": "#800080",
  //   "RebeccaPurple": "#663399",
  //   "Red": "#FF0000",
  //   "RosyBrown": "#BC8F8F",
  //   "RoyalBlue": "#4169E1",
  //   "SaddleBrown": "#8B4513",
  //   "Salmon": "#FA8072",
  //   "SandyBrown": "#F4A460",
  //   "SeaGreen": "#2E8B57",
  //   "Seashell": "#FFF5EE",
  //   "Sienna": "#A0522D",
  //   "Silver": "#C0C0C0",
  //   "SkyBlue": "#87CEEB",
  //   "SlateBlue": "#6A5ACD",
  //   "SlateGray": "#708090",
  //   "Snow": "#FFFAFA",
  //   "SpringGreen": "#00FF7F",
  //   "SteelBlue": "#4682B4",
  //   "Tan": "#D2B48C",
  //   "Teal": "#008080",
  //   "Thistle": "#D8BFD8",
  //   "Tomato": "#FF6347",
  //   "Turquoise": "#40E0D0",
  //   "Violet": "#EE82EE",
  //   "Wheat": "#F5DEB3",
  //   "White": "#FFFFFF",
  //   "WhiteSmoke": "#F5F5F5",
  //   "Yellow": "#FFFF00",
  //   "YellowGreen": "#9ACD32",
  //   // Add more named colors as needed
  // };
  //
  // static Color? getColor(String value) {
  //   value = value.trim(); // Normalize input
  //
  //   // Check if the value is a valid hex color code
  //   if (_isHexColor(value)) {
  //     return _hexToColor(value);
  //   }
  //
  //   // Attempt to get color from the local map
  //   final hex = _colorNameToHex[value];
  //   if (hex != null) {
  //     return _hexToColor(hex);
  //   }
  //
  //   // If no match, return null
  //   return null;
  // }
  //
  // // Method to check if a string is a valid hex color code
  // static bool _isHexColor(String value) {
  //   final hexColorRegex = RegExp(r'^#(?:[0-9a-fA-F]{3}){1,2}$');
  //   return hexColorRegex.hasMatch(value);
  // }
  //
  // // Method to convert hex color code to Color object
  // static Color _hexToColor(String hex) {
  //   hex = hex.replaceFirst('#', '');
  //
  //   // Handle short hex color (e.g., #abc)
  //   if (hex.length == 3) {
  //     hex = hex.split('').map((char) => char * 2).join('');
  //   }
  //
  //   // Convert hex to int and create Color object
  //   final colorInt = int.parse(hex, radix: 16);
  //   return Color(colorInt).withOpacity(1.0);
  // }


  // Comprehensive map of color names to hex values with capitalized keys
  static final Map<String, String> _colorNameToHex = {
    "AliceBlue": "#F0F8FF",
    "AntiqueWhite": "#FAEBD7",
    "Aqua": "#00FFFF",
    "Aquamarine": "#7FFFD4",
    "Azure": "#F0FFFF",
    "Beige": "#F5F5DC",
    "Bisque": "#FFE4C4",
    "Black": "#000000",
    "BlanchedAlmond": "#FFEBCD",
    "Blue": "#0000FF",
    "BlueViolet": "#8A2BE2",
    "Brown": "#A52A2A",
    "Burlywood": "#DEB887",
    "CadetBlue": "#5F9EA0",
    "Chartreuse": "#7FFF00",
    "Chocolate": "#D2691E",
    "Coral": "#FF7F50",
    "CornflowerBlue": "#6495ED",
    "Cornsilk": "#FFF8DC",
    "Crimson": "#DC143C",
    "Cyan": "#00FFFF",
    "DarkBlue": "#00008B",
    "DarkCyan": "#008B8B",
    "DarkGoldenrod": "#B8860B",
    "DarkGray": "#A9A9A9",
    "DarkGreen": "#006400",
    "DarkKhaki": "#BDB76B",
    "DarkMagenta": "#8B008B",
    "DarkOliveGreen": "#556B2F",
    "DarkOrange": "#FF8C00",
    "DarkOrchid": "#9932CC",
    "DarkRed": "#8B0000",
    "DarkSalmon": "#E9967A",
    "DarkSeaGreen": "#8FBC8F",
    "DarkSlateBlue": "#483D8B",
    "DarkSlateGray": "#2F4F4F",
    "DarkTurquoise": "#00CED1",
    "DarkViolet": "#9400D3",
    "DeepPink": "#FF1493",
    "DeepSkyBlue": "#00BFFF",
    "DimGray": "#696969",
    "DodgerBlue": "#1E90FF",
    "Firebrick": "#B22222",
    "FloralWhite": "#FFFAF0",
    "ForestGreen": "#228B22",
    "Fuchsia": "#FF00FF",
    "Gainsboro": "#DCDCDC",
    "GhostWhite": "#F8F8FF",
    "Gold": "#FFD700",
    "Goldenrod": "#DAA520",
    "Gray": "#808080",
    "Green": "#008000",
    "GreenYellow": "#ADFF2F",
    "Honeydew": "#F0FFF0",
    "HotPink": "#FF69B4",
    "IndianRed": "#CD5C5C",
    "Indigo": "#4B0082",
    "Ivory": "#FFFFF0",
    "Khaki": "#F0E68C",
    "Lavender": "#E6E6FA",
    "LavenderBlush": "#FFF0F5",
    "LawnGreen": "#7CFC00",
    "LemonChiffon": "#FFFACD",
    "LightBlue": "#ADD8E6",
    "LightCoral": "#F08080",
    "LightCyan": "#E0FFFF",
    "LightGoldenrodYellow": "#FAFAD2",
    "LightGray": "#D3D3D3",
    "LightGreen": "#90EE90",
    "LightPink": "#FFB6C1",
    "LightSalmon": "#FFA07A",
    "LightSeaGreen": "#20B2AA",
    "LightSkyBlue": "#87CEFA",
    "LightSlateGray": "#778899",
    "LightSteelBlue": "#B0C4DE",
    "LightYellow": "#FFFFE0",
    "Lime": "#00FF00",
    "LimeGreen": "#32CD32",
    "Linen": "#FAF0E6",
    "Magenta": "#FF00FF",
    "Maroon": "#800000",
    "MediumAquamarine": "#66CDAA",
    "MediumBlue": "#0000CD",
    "MediumOrchid": "#BA55D3",
    "MediumPurple": "#9370DB",
    "MediumSeaGreen": "#3CB371",
    "MediumSlateBlue": "#7B68EE",
    "MediumSpringGreen": "#00FA9A",
    "MediumTurquoise": "#48D1CC",
    "MediumVioletRed": "#C71585",
    "MidnightBlue": "#191970",
    "MintCream": "#F5FFFA",
    "MistyRose": "#FFE4E1",
    "Moccasin": "#FFE4B5",
    "NavajoWhite": "#FFDEAD",
    "Navy": "#000080",
    "OldLace": "#FDF5E6",
    "Olive": "#808000",
    "OliveDrab": "#6B8E23",
    "Orange": "#FFA500",
    "OrangeRed": "#FF4500",
    "Orchid": "#DA70D6",
    "PaleGoldenrod": "#EEE8AA",
    "PaleGreen": "#98FB98",
    "PaleTurquoise": "#AFEEEE",
    "PaleVioletRed": "#D87093",
    "PapayaWhip": "#FFEFD5",
    "PeachPuff": "#FFDAB9",
    "Peru": "#CD853F",
    "Pink": "#FFC0CB",
    "Plum": "#DDA0DD",
    "PowderBlue": "#B0E0E6",
    "Purple": "#800080",
    "RebeccaPurple": "#663399",
    "Red": "#FF0000",
    "RosyBrown": "#BC8F8F",
    "RoyalBlue": "#4169E1",
    "SaddleBrown": "#8B4513",
    "Salmon": "#FA8072",
    "SandyBrown": "#F4A460",
    "SeaGreen": "#2E8B57",
    "Seashell": "#FFF5EE",
    "Sienna": "#A0522D",
    "Silver": "#C0C0C0",
    "SkyBlue": "#87CEEB",
    "SlateBlue": "#6A5ACD",
    "SlateGray": "#708090",
    "Snow": "#FFFAFA",
    "SpringGreen": "#00FF7F",
    "SteelBlue": "#4682B4",
    "Tan": "#D2B48C",
    "Teal": "#008080",
    "Thistle": "#D8BFD8",
    "Tomato": "#FF6347",
    "Turquoise": "#40E0D0",
    "Violet": "#EE82EE",
    "Wheat": "#F5DEB3",
    "White": "#FFFFFF",
    "WhiteSmoke": "#F5F5F5",
    "Yellow": "#FFFF00",
    "YellowGreen": "#9ACD32",
    // Add more named colors as needed
    "Cerulean": "#007BA7",
    "ChartreuseGreen": "#7FFF00",
    "DeepSkyBlue": "#00BFFF",
    "LightSlateBlue": "#8470FF",
    "MediumPurple": "#9370DB",
    "PapayaWhip": "#FFEFD5",
    "RoyalBlue": "#4169E1",
    "SlateGray": "#708090",
  };

  static Color? getColor(String value) {
    value = value.trim(); // Normalize input

    // Check if the value is a valid hex color code
    if (_isHexColor(value)) {
      return _hexToColor(value);
    }

    // Attempt to get color from the local map
    final hex = _colorNameToHex[value];
    if (hex != null) {
      return _hexToColor(hex);
    }

    // If no match, return null
    return null;
  }

  // Method to check if a string is a valid hex color code
  static bool _isHexColor(String value) {
    final hexColorRegex = RegExp(r'^#(?:[0-9a-fA-F]{3}){1,2}$');
    return hexColorRegex.hasMatch(value);
  }

  // Method to convert hex color code to Color object
  static Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');

    // Handle short hex color (e.g., #abc)
    if (hex.length == 3) {
      hex = hex.split('').map((char) => char * 2).join('');
    }

    // Convert hex to int and create Color object
    final colorInt = int.parse(hex, radix: 16);
    return Color(colorInt).withOpacity(1.0);
  }

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  static void showAlert(String title, String message) {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                )
              ]);
        });
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd-MMM-yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(
        children: rowChildren,
      ));
    }
    return wrappedList;
  }
}
