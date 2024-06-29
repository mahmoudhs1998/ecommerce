import 'package:get/get.dart';

import '../features/shop/models/product_model.dart';

class LocaleLang implements Translations {
  List<ProductModel> product = [];
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'home': 'الصفحة الرئيسية',
          'about': 'عنا',
          "Account": "الحساب",
          "Account Settings": "اعدادات الحساب",
          "App Settings": "اعدادات البرنامج",
          'My Address': 'عنواني',
          'My Cart': 'السلة',
          'My Orders': 'طلباتي',
          'Bank Account': 'الحساب البنكي',
          'My Coupons': 'الكوبونات',
          'Notifications': 'الاشعارات',
          'Account Privacy': 'حماية و خصوصية الحساب',
          'Profile': 'الملف الشخصي',
          'Change Profile Picture': 'تغيير صورة الملف الشخصي',
          'Profile Information': 'المعلومات الشخصية',
          'Name': 'الاسم',
          'Username': 'اسم المستخدم',
          'Personal Information': 'معلوماتي',
          'User ID': 'رقم الحساب',
          'E-mail': 'البريد الالكتروني',
          'Phone Number': 'رقم الهاتف',
          'Close Account': 'غلق الحساب',
          "View all": "عرض الكل",
          'contact': 'تواصل معنا',
          'language': 'اللغة',
          'arabic': 'عربي',
          'english': 'انكليزي',
          'search In Store': 'بحث في المتجر',
          'search': 'بحث',
          "Popular Categories": "الفئات الشائعة",
          "Popular Products": "المنتجات الشائعة",
          'Logout': 'تسجيل الخروج',
          // On Boarding
          "Choose your product": "اختر منتجك",
          "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!":
              "مرحبًا بك في عالم من الخيارات اللامحدودة - منتجك المثالي في انتظارك!",
          "Select Payment Method": "حدد طريقة الدفع",
          "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!":
              "لتجربة معاملات سلسة، اختر طريقة الدفع التي تناسبك - راحتك هي أولويتنا!",
          "Deliver at your door step": "توصيل إلى عتبة بابك",
          "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!":
              "من عتبتنا إلى عتبتك - توصيل سريع وآمن وبدون تلامس!",
          "Skip": "تخطي",
          // Login
          "Welcome Back,": "مرحبًا مجددًا،",
          "E-Mail": "البريد الإلكتروني",
          "Enter Your E-Email": "ادخل البريد الإلكتروني",
          "Password": "كلمة المرور",
          "Enter Your Password": "أدخل كلمة المرور",
          "Remember Me": "تذكرني",
          "Forget PassWord": "نسيت كلمة المرور",
          "Sign In": "تسجيل الدخول",
          "Sign Up": "انشاء حساب",
          "Create an Account": "إنشاء حساب",
          "Or Sign In With": "أو قم بالتسجيل باستخدام",
          'is Required': "مطلوب",
          'Please enter your email': 'الرجاء ادخال البريد الالكتروني',
          'Please enter a valid email': 'الرجاء ادخال بريد الكتروني صالح',
          'Please enter your password': 'الرجاء ادخال كلمة المرور',
          'Please enter a valid password': 'الرجاء ادخال كلمة مرور صالحة',
          'Password must be at least 6 characters':
              'كلمة المرور يجب الا تقل عن 6 حروف',
          'Password must contain at least one uppercase letter.':
              'كلمة المرور يجب ان تحتوي على حرف واحد كبير علي الاقل',
          'Password must contain at least one number.':
              'كلمة المرور يجب ان تحتوي على رقم واحد علي الاقل',
          'Password must contain at least one special character.':
              'كلمة المرور يجب ان تحتوي على رمز خاص واحد علي الاقل',
          'Phone number is required.': 'رقم الهاتف مطلوب',
          'Invalid phone number format (10 digits required).':
              'صيغة رقم الهاتف غير صالحة (10 ارقام مطلوبة)',
          "First Name": "الاسم الاول",
          "Last Name": "الاسم الاخير",
          "User Name": "اسم المستخدم",
          "UserName": "اسم المستخدم",
          "Or Sign Up With": "أو قم بالتسجيل باستخدام",
          "Forget password": "نسيت كلمة المرور",
          "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.":
              "لا تقلق، أحيانًا يمكن للأشخاص أن ينسوا أيضًا. قم بإدخال بريدك الإلكتروني وسنرسل لك رابط إعادة تعيين كلمة المرور.",
          "Submit": "موافقة",
          // Terms of Use & Privacy
          "I agree to the ": "انا اوافق علي ",
          "Privacy Policy ": "سياسة الخصوصية ",
          "Terms of Use ": "شروط الاستخدام ",
          "and": "و",

          'Terms of Use': 'شروط الاستخدام',
          'Here are the terms of use for our application...':
              'إليك شروط الاستخدام لتطبيقنا...',
          'Accept': 'قبول',
          'Decline': 'رفض',
          'Show Terms of Use': 'عرض شروط الاستخدام',
          'Terms of Use Example': 'مثال على شروط الاستخدام',
          'Privacy Policy': 'سياسة الخصوصية',
          'Here is the privacy policy for our application...':
              'إليك سياسة الخصوصية لتطبيقنا...',
          'Show Privacy Policy': 'عرض سياسة الخصوصية',
          'Privacy Policy Example': 'مثال على سياسة الخصوصية',
          'Warning': 'تحذير',
          'You must accept the terms of use and privacy policy to continue.':
              'يجب أن توافق على شروط الاستخدام وسياسة الخصوصية للاستمرار.',
          'OK': 'حسنًا',

          "Featured Brands": "العلامات التجارية المميزة",
          "You Might Also Like": "قد يعجبك أيضًا",
          "Brand": "براند",
          "Brands": "البراندات",
          "Good day for shopping": "يوم رائع للتسوق",

          // Navigation Menu
          'Home': 'الرئيسية',
          'Store': 'المتجر',
          'Wishlist': 'المفضلة',
          // filter  :
          'Higher Price': 'السعر الأعلى',
          'Lower Price': 'السعر الأدنى',
          'Sale': 'التخفيضات',
          'Newest': 'الأحدث',
          'Popularity': 'الشهرة',
          //----------------------------
          'Order Review': 'مراجعة الطلب',
          'Cart': 'السلة',
          'Whoops! Cart is EMPTY.': 'اوه لا! السلة فارغة',
          'Let\'s fill it': 'دعنا نملأها',

          // -----------
          'WishList': 'المفضلة',
          'Whoops! Wishlist is Empty.': 'اوه لا! المفضلة فارغة',
          'Let\'s add some': 'دعنا نضيف البعض',

          //-----------
          "Checkout": "الدفع",
          'Add to Cart': 'أضف الي السلة',
          
          //--------------
          'Change UserName':'تغيير اسم المستخدم',
          'Change Name':'تغيير الاسم',
          'Save':'حفظ',

          //----------
          'Reviews & Ratings':'المراجعة و التقييم',
        },
        'en': {
          'home': 'Home',
          'about': 'About',
          "Account": "Account",
          "Account Settings": "Account Settings",
          "App Settings": "App Settings",
          'My Address': 'My Address',
          'My Cart': 'My Cart',
          'My Orders': 'My Orders',
          'Bank Account': 'Bank Account',
          'My Coupons': 'My Coupons',
          'Notifications': 'Notifications',
          'Account Privacy': 'Account Privacy',
          'Profile': 'Profile',
          'Change Profile Picture': 'Change Profile Picture',
          'Profile Information': 'Profile Information',
          'Name': 'Name',
          'Username': 'Username',
          'Personal Information': 'Personal Information',
          'User ID': 'User ID',
          'E-mail': 'E-mail',
          'Phone Number': 'Phone Number',
          'Close Account': 'Close Account',
          "View all": "View all",
          'contact': 'Contact',
          'language': 'Language',
          'arabic': 'arabic',
          'english': 'english',
          'search In Store': 'Search In Store',
          'search': 'Search',
          "Popular Categories": "Popular Categories",
          "Popular Products": "Popular Products",
          'Logout': 'Logout',
          // On Boarding
          "Choose your product": "Choose your product",
          "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!":
              "Welcome to a World of Limitless Choices - Your Perfect Product Awaits!",
          "Select Payment Method": "Select Payment Method",
          "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!":
              "For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!",
          "Deliver at your door step": "Deliver at your door step",
          "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!":
              "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!",
          "Skip": "Skip",

          // Login
          "Welcome Back,": "Welcome Back,",
          "E-Mail": "E-Mail",
          "Enter Your E-Email": "Enter Your E-Email",
          "Password": "Password",
          "Enter Your Password": "Enter Your Password",
          "Remember Me": "Remember Me",
          "Forget PassWord": "Forget PassWord",
          "Sign In": "Sign In",
          "Sign Up": "Sign Up",
          "Create an Account": "Create an Account",
          "Or Sign In With": "Or Sign In With",
          'is Required': "is Required",
          'Please enter your email': 'Please enter your email',
          'Please enter a valid email': 'Please enter a valid email',
          'Please enter your password': 'Please enter your password',
          'Please enter a valid password': 'Please enter a valid password',
          'Password must be at least 6 characters':
              'Password must be at least 6 characters',
          'Password must contain at least one uppercase letter.':
              'Password must contain at least one uppercase letter.',
          'Password must contain at least one number.':
              'Password must contain at least one number.',
          'Password must contain at least one special character.':
              'Password must contain at least one special character.',
          'Phone number is required.': 'Phone number is required.',
          'Invalid phone number format (10 digits required).':
              'Invalid phone number format (10 digits required).',
          "First Name": "First Name",
          "Last Name": "Last Name",
          "User Name": "User Name",
          "UserName": "UserName",
          "Or Sign Up With": "Or Sign Up With",
          "Forget password": "Forget password",
          "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.":
              "Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.",
          "Submit": "Submit",
          // Terms of Use & Privacy
          "I agree to the ": "I agree to the ",
          "Privacy Policy ": "Privacy Policy ",
          "Terms of Use ": "Terms of Use ",
          "and": "and",

          'Terms of Use': 'Terms of Use',
          'Here are the terms of use for our application...':
              'Here are the terms of use for our application...',
          'Accept': 'Accept',
          'Decline': 'Decline',
          'Show Terms of Use': 'Show Terms of Use',
          'Terms of Use Example': 'Terms of Use Example',
          'Privacy Policy': 'Privacy Policy',
          'Here is the privacy policy for our application...':
              'Here is the privacy policy for our application...',
          'Show Privacy Policy': 'Show Privacy Policy',
          'Privacy Policy Example': 'Privacy Policy Example',
          'Warning': 'Warning',
          'You must accept the terms of use and privacy policy to continue.':
              'You must accept the terms of use and privacy policy to continue.',
          'OK': 'OK',
          "Featured Brands": "Featured Brands",
          "You Might Also Like": "You Might Also Like",
          "Brand": "Brand",
          "Brands": "Brands",
          "Good day for shopping": "Good day for shopping",

          // Navigation Menu
          'Home': 'Home',
          'Store': 'Store',
          'Wishlist': 'Wishlist',
          // filter  :
          'Higher Price': 'Higher Price',
          'Lower Price': 'Lower Price',
          'Sale': 'Sale',
          'Newest': 'Newest',
          'Popularity': 'Popularity',
          //----------------------------
          'Order Review': 'Order Review',
          'Cart': 'Cart',
          'Whoops! Cart is EMPTY.': 'Whoops! Cart is EMPTY.',
          'Let\'s fill it': 'Let\'s fill it',

          // -----------
          'WishList': 'WishList',
          'Whoops! Wishlist is Empty.': 'Whoops! Wishlist is Empty.',
          'Let\'s add some': 'Let\'s add some',

          //-----------
          "Checkout": "Checkout",
          'Add to Cart': 'Add to Cart',

          //--------------
          'Change UserName':'Change UserName',
          'Change Name':'Change Name',
          'Save':'Save',

          //---------
          'Reviews & Ratings':'Reviews & Ratings',

        }
      };
}
