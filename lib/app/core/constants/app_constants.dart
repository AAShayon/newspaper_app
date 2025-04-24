final class AppRegExpText {
  AppRegExpText._();

// Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
          "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";

  static String validateName(String name, String error) {
    if (name.length < 3) {
      return 'Name must be at least 3 characters long.';
    }
    return error;
  }
}

// Keys
const String kKeyStatus = 'status';
const String kKeyJsonObject = 'json_object';
const String kKeyJsonArray = 'json_array';
const String kKeyStringData = 'string_data';
const String kKeyMessage = 'message';
const String kKeyData = 'data';
const String kKeyWishList = 'wishlist';
const String kKeyCurrencyCode = 'currency_code';
const String kKeyCurrencyCodeValue = 'currency_code_value';
const String kKeyCode = 'code';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kPhone = 'phone_number';
const String kKeySelectedLocation = 'selected_location';
const String kKeySelectedLat = 'selected_lot';
const String kKeySelectedLng = 'selected_lng';
const String kKeyAddress = 'address';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'language_code';
const String kKeyCountryName = 'country_name';
const String kKeyName = 'name';
const String kKeyToken = 'token';
const String kKeyUuid = 'uuid';
const String kKeyUuidForgetPassword = 'userUuid';
const String kKeyUserOtp = 'otp';
const String kKeyInitialToken = 'initial_token';
const String kKeySecretKey = 'secret_key';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';
const String kKeyUser = 'user';
const String kKeyEmailVerifiedAt = 'email_verified_at';
const String kKeyPhoneVerifiedAt = 'phone_verified_at';
const String kKeyFaqText = 'faq_text';
const String kKeyTermsAndConditionsText = 'toc_text';
const String kKeyAverageRating = 'average_rating';
const String kKeyViews = 'views';
const String kKeyProvider = 'provider';
const String kFacebook = 'facebook';
const String kApple = 'apple';
const String kGoogle = 'google';
const String kKeyEnglish = 'en';
const String kKeyPortuguese = 'pt';
const String kKeyFrench = 'fr';
const String kKeyGerman = 'de';
const String kKeySpanish = 'es';
const String kKeyRussian = 'ru';
const String kKeyFirstName = 'first_name';
const String kKeyLastName = 'lst_name';
const String kKeyFirstTime = 'first_time';
const String kKeyDeviceID = 'device_id';
const String kKeyUserID = 'user_id';
const String kKeyShopID = 'shop_id';
const String kKeycategoriesID = 'categoriesId';
const String kKeyproductID = 'productId';
const String kKeyShopSlug = 'shop_slug';
const String kKeyRestaurantID = 'productId';
const String kKeyIsExploring = 'exploring';
const String kKeyHotSale = '';
const String kKeyRecommendation = 'recommendation';
const String kKeyCotton = 'cotton';
const String kKeyCart = 'cart';

const List<String> kLanguagesKey = [
  kKeyEnglish,
  kKeyPortuguese,
  kKeyFrench,
  kKeyGerman,
  kKeySpanish,
  kKeyRussian,
];
const Map languages = <String, String>{
  kKeyEnglish: "English",
  kKeyPortuguese: "Portuguese",
  kKeyFrench: "French",
  kKeyGerman: "Dutch",
  kKeySpanish: "Spanish",
  kKeyRussian: "Russian",
};
const Map countriesCode = <String, String>{
  kKeyEnglish: "US",
  kKeyPortuguese: "PT",
  kKeyFrench: "FR",
  kKeyGerman: "DE",
  kKeySpanish: "ES",
  kKeyRussian: "RU",
};

String getHotSaleTitle(String languageCode) {
  switch (languageCode) {
    case 'bn': // Bangla
      return "আজকের হট প্রোডাক্ট";
    case 'hi': // Hindi
      return "आज क्या चर्चा है?";
    case 'ar': // Arabic
      return "ما هو الساخن اليوم?";
    default: // Default to English
      return "Hot Sale";
  }
}

String getViewAllText(String languageCode) {
  switch (languageCode) {
    case 'bn': // Bangla
      return "সব দেখুন";
    case 'hi': // Hindi
      return "सभी देखें";
    case 'ar': // Arabic
      return "عرض الكل";
    default: // English
      return "View All";
  }
}

String getRecommendationTitle(String languageCode) {
  switch (languageCode) {
    case 'bn': // Bangla
      return "সুপারিশকৃত পণ্য";
    case 'hi': // Hindi
      return "सिफारिश किए गए उत्पाद";
    case 'ar': // Arabic
      return "المنتجات الموصى بها";
    default: // English
      return "Recommendation";
  }
}

/// **📝 Get Translated Category Title**
String getTranslatedCategoryTitle(dynamic category, String languageCode) {
  for (var lang in category.languageDetail) {
    if (lang.language.lngcode == languageCode) {
      return lang.title;
    }
  }
  return category.defaultLanguage.title; // Fallback to default
}

/// **🔍 Get Translated Search Text**
String getSearchText(String languageCode) {
  switch (languageCode) {
    case 'bn':
      return "অনুসন্ধান করুন  ";
    case 'hi':
      return "खोजें  ";
    case 'ar':
      return "بحث    ";
    default:
      return "Search   ";
  }
}

/// **📌 No Categories Found Message**
String getNoCategoriesText(String languageCode) {
  switch (languageCode) {
    case 'bn':
      return "কোনো বিভাগ পাওয়া যায়নি।";
    case 'hi':
      return "कोई श्रेणियां उपलब्ध नहीं हैं।";
    case 'ar':
      return "لا توجد فئات متاحة.";
    default:
      return "No categories available.";
  }
}

List<String> getSearchSuggestions(String languageCode) {
  Map<String, List<String>> searchSuggestions = {
    "en": ["Product...", "Category...", "Saree...", "Bag..."],
    "bn": ["পণ্য...", "শ্রেণী...", "শাড়ি...", "ব্যাগ..."],
    "hi": ["उत्पाद...", "श्रेणी...", "साड़ी...", "बैग..."],
    "ar": ["منتج...", "فئة...", "ساري...", "حقيبة..."],
  };

  return searchSuggestions[languageCode] ?? searchSuggestions["en"]!;
}

String getNoProductsText(String languageCode) {
  switch (languageCode) {
    case 'bn':
      return "পণ্য পাওয়া যাচ্ছে না";
    case 'hi':
      return "उत्पाद उपलब्ध नहीं हैं";
    case 'ar':
      return "المنتجات غير متوفرة.";
    default:
      return "Products are not available";
  }
}

/// **🔠 Get Localized Text Based on Language Code**
String getLocalizedText(String key, String languageCode) {
  Map<String, Map<String, String>> translations = {
    "Logout": {
      "en": "Logout",
      "bn": "লগআউট",
      "hi": "लॉग आउट",
      "ar": "تسجيل الخروج"
    },
    "Log In": {
      "en": "Log In",
      "bn": "লগইন করুন",
      "hi": "लॉग इन करें",
      "ar": "تسجيل الدخول"
    },
    "Edit Profile": {
      "en": "Edit Profile",
      "bn": "প্রোফাইল সম্পাদনা করুন",
      "hi": "प्रोफ़ाइल संपादित करें",
      "ar": "تعديل الملف الشخصي"
    },
    "My Orders": {
      "en": "My Orders",
      "bn": "আমার অর্ডার",
      "hi": "मेरे आदेश",
      "ar": "طلباتي"
    },
    "My Address": {
      "en": "My Address",
      "bn": "আমার ঠিকানা",
      "hi": "मेरा पता",
      "ar": "عنواني"
    },
    "Set Shopping Delivery Address": {
      "en": "Set Shopping Delivery Address",
      "bn": "শপিং ডেলিভারি ঠিকানা সেট করুন",
      "hi": "शॉपिंग डिलीवरी पता सेट करें",
      "ar": "تعيين عنوان توصيل التسوق"
    },
    "My Pre Order": {
      "en": "My Pre Order",
      "bn": "আমার পূর্ব অর্ডার",
      "hi": "मेरा पूर्व आदेश",
      "ar": "طلبي المسبق"
    },
    "Get Shopping Pre Order Lists": {
      "en": "Get Shopping Pre Order Lists",
      "bn": "শপিং পূর্ব অর্ডার তালিকা পান",
      "hi": "शॉपिंग पूर्व आदेश सूची प्राप्त करें",
      "ar": "احصل على قوائم الطلبات المسبقة للتسوق"
    },
    "In progress and Completed Orders": {
      "en": "In progress and Completed Orders",
      "bn": "চলমান এবং সম্পন্ন অর্ডার",
      "hi": "प्रगति में और पूर्ण आदेश",
      "ar": "الطلبات قيد التنفيذ والمكتملة"
    },
    "My Wishlist": {
      "en": "My Wishlist",
      "bn": "আমার উইশলিস্ট",
      "hi": "मेरी पसंदीदा सूची",
      "ar": "قائمة الأمنيات الخاصة بي"
    },
    "Account Information": {
      "en": "Account Information",
      "bn": "অ্যাকাউন্ট তথ্য",
      "hi": "खाता जानकारी",
      "ar": "معلومات الحساب"
    },
    "Get Shopping Wish Lists": {
      "en": "Get Shopping Wish Lists",
      "bn": "শপিং উইশ লিস্ট পান",
      "hi": "खरीदारी पसंदीदा सूची प्राप्त करें",
      "ar": "احصل على قوائم الأمنيات للتسوق"
    },
    "Localization": {
      "en": "Localization",
      "bn": "স্থানীয়করণ",
      "hi": "स्थानीयकरण",
      "ar": "التعريب"
    },
    "Select your preferred language": {
      "en": "Select your preferred language",
      "bn": "আপনার পছন্দের ভাষা নির্বাচন করুন",
      "hi": "अपनी पसंदीदा भाषा चुनें",
      "ar": "اختر لغتك المفضلة"
    },
    "Rate Our App": {
      "en": "Rate Our App",
      "bn": "আমাদের অ্যাপ রেট করুন",
      "hi": "हमारे ऐप को रेट करें",
      "ar": "قيم تطبيقنا"
    },
    "Share your feedback and rate us": {
      "en": "Share your feedback and rate us",
      "bn": "আপনার মতামত শেয়ার করুন এবং আমাদের রেট দিন",
      "hi": "अपनी प्रतिक्रिया साझा करें और हमें रेट करें",
      "ar": "شارك بتعليقاتك وقيمنا"
    },
    "Change Password": {
      "en": "Change Password",
      "bn": "পাসওয়ার্ড পরিবর্তন করুন",
      "hi": "पासवर्ड बदलें",
      "ar": "تغيير كلمة المرور"
    },
    "Change Your Password": {
      "en": "Change Your Password",
      "bn": "আপনার পাসওয়ার্ড পরিবর্তন করুন",
      "hi": "अपना पासवर्ड बदलें",
      "ar": "قم بتغيير كلمة المرور الخاصة بك"
    },
    "Guest": {"en": "Guest", "bn": "অতিথি", "hi": "अतिथि", "ar": "زائر"},
    "Tap to Login": {
      "en": "Tap to Login",
      "bn": "লগইন করতে ট্যাপ করুন",
      "hi": "लॉगिन करने के लिए टैप करें",
      "ar": "اضغط لتسجيل الدخول"
    },
    "Product": {
      "en": "Product",
      "bn": "পণ্য",
      "hi": "उत्पाद",
      "ar": "منتج",
    },
    "All Category": {
      "en": "All Category",
      "bn": "সব ক্যাটাগরি",
      "hi": "सभी श्रेणियाँ",
      "ar": "جميع الفئات"
    },
    "Profile": {
      "en": "Profile",
      "bn": "প্রোফাইল",
      "hi": "प्रोफ़ाइल",
      "ar": "الملف الشخصي"
    }
  };

  return translations[key]?[languageCode] ?? translations[key]?["en"] ?? key;
}

class DefaultValue {
  static const bool kDefaultBoolean = false;
  static const int kDefaultInt = 0;
  static const double kDefaultDouble = 0.0;
  static const String kDefaultString = '';
}
