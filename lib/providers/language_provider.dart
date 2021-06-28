import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool isEn = true;

  Map<String, Object> textsAr ={
    "start": "ابدأ الان",
    "Maak": "معك",
    "call_us": "اتصل بنا",
    "tasks": "مهام",
    "appoint": "قرارت هامة ",
    "ehr": "سجل طبي",
    "initial_eva": "تقييم مبدئي",
    "home_nursing": "التمريض المنزلي",
    "lab_tests": "فحوصات مخبرية",
    "settings": "الاعدادات",
    "permission": "الإذن",
    "push_nof": "ارسال الاشعارارت",
    "loc_ser": "خدمات الموقع",
    "help": "مساعدة",
    "about": "حول تطبيق",
    "send_feed": "ارسل رئيك",
    "support": "دعم",
    "faq": "أسئلة مكررة",
    "privacy_pol": "سياسة خاصة",
    "sign_out": "تسجيل خروج",
    "doctor_evaluation": "تقييم الطبيب:",
    "nursing_assessment": "تقييم التمريض:",
    "vital_Signs_measurement": "قياس العلامات الحيوية:",
    "create_treatment_plan": "ضع خطة علاج:",
    "medicines_management": "إدارة الأدوية:",
    "nursing_services": "خدمات التمريض:",
    "contact_details": "بيانات المتصل",
    "phone": "رقم الهاتف",
    "email": "الايميل",
    "map": "الخريطة",
    "Book_now": "احجز الآن",
    "price": "السعر",
    "choose_your_language":"اختر لغتك",
     "home_medical_services" : ": خدمات طبية منزلية",
    "detail_services" : "إن خدمة خدمات طبية منزلية يتم تقديمها لمختلف الأنواع والأشكال من الرعاية سواء كانت للأطفال أو المسنين أو للعلاج الطبيعي أو الرعاية فيما بعد العمليات الجراحية وغيرها من الخدمات"
    ,"description" : "الوصف"
    ,"on_boarding3_1" :"الخدمات الطبية المنزلية منها الخدمات الطبية التي تقدم لرعاية الأم والطفل والرعاية هنا تعني رعاية الأم فيما قبل الولادة، والمشورة الصحية والتعليم."
    ,"on_boarding3_2" :"ورعاية المولود الجديد كما يقوموا بمتابعة صحة الطفل من حيث نموه عن طريق رسم النمو ووزنه والرضاعة الطبيعية التي يتلقاها الطفل من الأم والتطعيم وكل هذا في المنزل."
    ,"on_boarding3_3" : "كما يقوموا برعاية المسنين في المنزل، ورعاية ما يقوموا بعمليات جراحية كبيرة، والعلاج الوريدي في المنزل، وإدارة الأمراض المزمنة، وخدمات العلاج الطبيعي في المنزل."
    ,"lan_ar" : "عربي"
     , "lan_en" : "انكليزي"
    ,    "service" : "الخدمات"
     , "ads" : "الاعلانات"
    ,"next" : "التالي"
    , "login_otp" : "تسجيل Otp"
     ,"send_code" : "ارسال كود"
    , "phone" : "الهاتف"
    ,"plz_insert" : "من فضلك ادخل الرقم"
    ,"required" : "مطلوب"
    , "code_exp" : "ستنتهي صلاحية هذا الرمز في"
    , "otp_code" : "كود Otp"
    , "otp_ver" : "ادحل رمز OTP"
    ,"we_sent" : "أدخل رمز OTP المكون من 6 أرقام لهاتفك"
    ,"wrong_number" : "الرقم خاطئ"
    ,"re_send" : "اعادة ارسال الكود"
    , "log_det" : "تفاصيل تسجيل دخول"
    , "id_card" : "رقم الهاوية"
    , "name" : "الاسم"
    ,"Thx_reg" : "شكرا للتسجيل"
    ,"plz_again" : "من فضلك حاول مرة اخرى"
    ,"login" : "تسجيل دخول"
    ,"login_det" : '''تسجيل الدخول باستخدام الرقم وكلمة المرور اللذين قمت بإنشائهما
                       أثناء التسجيل في التطبيق'''
    ,"number" : "الرقم"
    ,"dont_acc" : "ليس لديك حساب ؟"
    ,"create_account" : "انشاء حساب"
    ,"create_det" : "قم بإنشاء حساب معنا باستخدام هاتفك"
    , "full_name" : "الاسم كامل"
    ,"enter_gov" : "أدخل رقم الهوية الصادر عن الحكومة."
    ,"agree" : "أنا أتفق مع"
    ,"terms" : "مصطلحات"
    ,"conditions" : "الشروط"
    , "already_acc" : "هل لديك حساب ؟"
    ,"dont_otp" : "لم تستلم OTP ؟"
    ,"add_payment_det" : "أضف تفاصيل الدفع"
    ,"credit_card"  : "بطاقة إئتمان"
    ,"apple_pay" : "دفع ابل"
    , "card_number" : "رقم البطاقة"
    , "cardholder_name" : "إسم صاحب البطاقة"
    , "expiry_date" : "تاريخ الانتهاء"
    , "number_behind" : "الرقم خلف البطاقة"
  };
  Map<String, Object> textsEn = {
    "start": "GET STARTED",
    "Maak": "MA'K",
    "call_us": "Call Us",
    "tasks": "Tasks",
    "appoint": "Appointments",
    "ehr": "EHR",
    "initial_eva": "Initial Evaluation",
    "home_nursing": "Home Nursing",
    "lab_tests": "Lab Tests",
    "settings": "Settings",
    "permission": "Permission",
    "push_nof": "Push Notifications",
    "loc_ser": "Location Services",
    "help": "Help",
    "about": "About Application",
    "send_feed": "Send Feedback",
    "support": "Support",
    "faq": "Frequently Asked Questions",
    "privacy_pol": "privacy Policy",
    "sign_out": "Sign Out",
    "doctor_evaluation": "Doctor Evaluation:",
    "nursing_assessment": "Nursing assessment:",
    "vital_Signs_measurement": "Vital Signs Measurement:",
    "create_treatment_plan": "Create a treatment plan:",
    "medicines_management": "Medicines management:",
    "nursing_services": "Nursing services: ",
    "contact_details": "Contact Details",
    "phone": "Phone",
    "email": "Email",
    "map": "Map",
    "Book_now": "Book Now",
    "price": "Price",
    "choose_your_language":"Choose your language",
  "home_medical_services" : "Home medical services:",
    "detail_services" : " a home medical services service that is provided to various types and forms of care, whether for children, the elderly, physiotherapy, post-operative care and other services.",
    "on_boarding3_1" : "Home medical services including medical services for mother and child care and care here means antenatal care, health advice and education.",
  "on_boarding3_2" :   "They take care of the newborn, and they follow up on the child's health in terms of its growth by charting the growth, weight, breastfeeding the child receives from the mother, vaccination, and all this at home. ",
  "on_boarding3_3" :    "They also provide home care for the elderly, care for major surgeries, intravenous therapy at home, chronic disease management, and home physiotherapy services.",
    "description" : "Description:"
  ,"lan_ar" : "Arabic"
  , "lan_en" : "English"
   , "service" : "Service"
    , "ads" : "Ads"
    ,"next" : "Next"
    ,"login_otp" : "Login Otp"
    ,"send_code" : "Send Code"
    , "phone" : "Phone"
    ,"plz_insert" : "Please Insert Number"
    , "required" : "Required"
    , "code_exp" : "This code will expired in"
    ,  "otp_code" : "Otp Code"
    , "otp_ver" : "Enter OTP code"
    ,"we_sent" : "Enter the 6 digit OTP Code to your phone"
    ,"wrong_number" : "Wrong Number"
    ,"re_send" : "Resend the code"
    , "log_det" : "Login Details"
    , "id_card" : "ID Card"
    , "name" : "Name"
    ,"Thx_reg" : "Thanks for login"
    ,"plz_again" : "Please try again"
    ,"login" : "Login"
    ,"login_det" : '''Login with the number and password you created 
                      while registering  in the app'''
    ,"number" : "Number"
        ,"dont_acc": "Don't have an account ? "
    ,"create_account" : "Create account"
    , "create_det" : "Create an account with us using your phone"
    , "full_name" : "Full Name"
    ,"enter_gov" : "Enter Gov Issued ID No."
    ,"agree" : "I agree with our"
    ,"terms" : "Terms"
    ,"conditions" : "Conditions"
    , "already_acc" : "Already have an account ? "
    , "dont_otp" : "Didn't receive OTP ?"
    ,"add_payment_det" : "Add Payment Details"
    , "credit_card" : "Credit Card"
    , "apple_pay" : "Apple Pay"
    , "card_number" : "Card number"
    , "cardholder_name" : "Cardholder name"
    , "expiry_date" : "Expiry Date"
    ,"number_behind" : "Number behind the card"
  };

  changeLan(bool lan) async {
    isEn = lan;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEn", isEn);
  }

  getLan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEn = prefs.getBool("isEn") ?? true;
    notifyListeners();
  }

  Object? getTexts(String txt) {
    if (isEn == true) return textsEn[txt];
    return textsAr[txt];
  }




}