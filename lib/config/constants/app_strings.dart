/// All user-facing string literals.
///
/// Centralizing strings here makes future i18n straightforward and
/// ensures consistency across the app.
class AppStrings {
  AppStrings._();

  // ─── App ───────────────────────────────────────────────────────────
  static const String appName = 'ThreadSense';
  static const String appTagline =
      'Your body. Your style. Perfectly matched.';

  // ─── Onboarding ────────────────────────────────────────────────────
  static const String onboardingTitle1 = 'Scan Your Body in Seconds';
  static const String onboardingSubtitle1 =
      'Our AI creates a precise 3D map of your measurements using just your phone camera.';
  static const String onboardingTitle2 = 'AI That Knows Your Style';
  static const String onboardingSubtitle2 =
      'Get personalized outfit recommendations based on what\'s trending and what fits you perfectly.';
  static const String onboardingTitle3 = 'Shop With Confidence';
  static const String onboardingSubtitle3 =
      'Every recommendation comes with your exact size and a direct link to buy.';
  static const String onboardingSkip = 'Skip';
  static const String onboardingNext = 'Next';
  static const String onboardingGetStarted = 'GET STARTED';

  // ─── Permissions ───────────────────────────────────────────────────
  static const String permissionsTitle = 'Before We Begin';
  static const String permissionsSubtitle =
      'ThreadSense needs a few permissions to create your perfect body scan.';
  static const String permCamera = 'Camera';
  static const String permCameraDesc =
      'Required to scan your body and take measurements';
  static const String permMotion = 'Motion & Orientation';
  static const String permMotionDesc =
      'Helps create an accurate 3D model as you turn';
  static const String permMicrophone = 'Microphone';
  static const String permMicrophoneDesc =
      'Enables voice-guided scanning for a hands-free experience';
  static const String permContinue = 'CONTINUE';
  static const String permDeniedSnackbar =
      'Permission denied. Tap to open Settings.';
  static const String permOpenSettings = 'Open Settings';

  // ─── Auth ──────────────────────────────────────────────────────────
  static const String loginTitle = 'Welcome Back';
  static const String signupTitle = 'Create Account';
  static const String emailHint = 'Email address';
  static const String passwordHint = 'Password';
  static const String confirmPasswordHint = 'Confirm password';
  static const String forgotPassword = 'Forgot Password?';
  static const String loginButton = 'LOG IN';
  static const String signupButton = 'SIGN UP';
  static const String orContinueWith = 'Or continue with';
  static const String noAccount = 'Don\'t have an account? ';
  static const String hasAccount = 'Already have an account? ';
  static const String signUp = 'Sign Up';
  static const String logIn = 'Log In';

  // ─── Scan ──────────────────────────────────────────────────────────
  static const String scanPrepareTitle = 'Prepare for Your Scan';
  static const String scanInstruction1 =
      'Find a well-lit room with 6 feet of space around you';
  static const String scanInstruction2 =
      'Wear form-fitting clothing for best accuracy';
  static const String scanInstruction3 =
      'Place your phone on a stable surface at chest height, or have someone hold it';
  static const String scanInstruction4 =
      'You\'ll need to rotate 360° slowly during the scan';
  static const String scanStartButton = 'START SCAN';
  static const String scanResultsTitle = 'Your Measurements';
  static const String scanRescan = 'Re-scan';
  static const String scanViewRecommendations = 'VIEW STYLING RECOMMENDATIONS';
  static const String scanComplete = 'Scan Complete!';

  // ─── Scan Voice Prompts ────────────────────────────────────────────
  static const String voiceAligning =
      'Step into the outline and stand naturally.';
  static const String voiceFrontScan =
      'Hold still. Capturing front view.';
  static const String voiceTurnLeft = 'Now slowly turn to your left.';
  static const String voiceTurnBack =
      'Hold still. Capturing back view.';
  static const String voiceTurnRight =
      'Almost done! Turn to face the camera again.';
  static const String voiceProcessing = 'Processing your scan.';
  static const String voiceComplete =
      'Scan complete! Let\'s see your results.';

  // ─── Scan Error Prompts ────────────────────────────────────────────
  static const String errorTooDark =
      'It\'s too dark. Try turning on more lights.';
  static const String errorTooFar =
      'You\'re too far away. Please step closer.';
  static const String errorTooClose =
      'You\'re too close. Please step back.';
  static const String errorBodyCutOff =
      'Your full body isn\'t visible. Adjust your position.';
  static const String errorMovingTooFast = 'Please move more slowly.';
  static const String errorTrackingLost =
      'Tracking lost. Please stay still for a moment.';

  // ─── Feed ──────────────────────────────────────────────────────────
  static const String feedTitle = 'For You';
  static const String feedShopThisLook = 'SHOP THIS LOOK';
  static const String feedWhyThisWorks = 'Why this works for you';

  // ─── Filter ────────────────────────────────────────────────────────
  static const String filterTitle = 'Filters';
  static const String filterBudget = 'Budget';
  static const String filterOccasion = 'Occasion';
  static const String filterCategory = 'Category';
  static const String filterSortBy = 'Sort By';
  static const String filterBrands = 'Brands';
  static const String filterApply = 'APPLY FILTERS';
  static const String filterReset = 'Reset';

  // ─── Filter Chip Labels ────────────────────────────────────────────
  static const String occasionCasual = 'Casual';
  static const String occasionFormal = 'Formal';
  static const String occasionActivewear = 'Activewear';
  static const String occasionStreetwear = 'Streetwear';
  static const String occasionDateNight = 'Date Night';
  static const String categoryTops = 'Tops';
  static const String categoryBottoms = 'Bottoms';
  static const String categoryOuterwear = 'Outerwear';
  static const String categoryFootwear = 'Footwear';
  static const String categoryFullOutfits = 'Full Outfits';
  static const String sortTrending = 'Trending';
  static const String sortPriceLow = 'Price: Low → High';
  static const String sortPriceHigh = 'Price: High → Low';
  static const String sortBestFit = 'Best Fit';

  // ─── Product ───────────────────────────────────────────────────────
  static const String productYourSize = 'Your size:';
  static const String productBuyNow = 'BUY NOW';
  static const String productSimilarItems = 'Similar Items';

  // ─── Profile ───────────────────────────────────────────────────────
  static const String profileTitle = 'Profile';
  static const String profileBodyProfile = 'Body Profile';
  static const String profileStylePreferences = 'Style Preferences';
  static const String profileSavedOutfits = 'Saved Outfits';
  static const String profilePurchaseHistory = 'Purchase History';
  static const String profileSettings = 'Settings';
  static const String profileSignOut = 'Sign Out';
  static const String profileSignOutConfirm =
      'Are you sure you want to sign out?';

  // ─── Body Type Labels ──────────────────────────────────────────────
  static const String bodyTypeRectangle = 'Rectangle';
  static const String bodyTypeTriangle = 'Triangle';
  static const String bodyTypeInvertedTriangle = 'Inverted Triangle';
  static const String bodyTypeHourglass = 'Hourglass';
  static const String bodyTypeOval = 'Oval';

  // ─── Measurement Labels ────────────────────────────────────────────
  static const String measChest = 'Chest';
  static const String measWaist = 'Waist';
  static const String measHips = 'Hips';
  static const String measInseam = 'Inseam';
  static const String measShoulders = 'Shoulders';
  static const String measArmLength = 'Arm Length';
  static const String measNeck = 'Neck';
  static const String measTorso = 'Torso';
  static const String measHeight = 'Height';

  // ─── General ───────────────────────────────────────────────────────
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String noConnection = 'No internet connection';
  static const String somethingWentWrong = 'Something went wrong';
}
