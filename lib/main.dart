import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

/// App entry point.
///
/// Initializes Firebase and Hive, then runs the app wrapped in
/// Riverpod's [ProviderScope].
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Uncomment when Firebase is configured
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // TODO: Uncomment when Hive is configured
  // await Hive.initFlutter();

  runApp(
    const ProviderScope(
      child: ThreadSenseApp(),
    ),
  );
}
