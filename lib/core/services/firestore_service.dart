import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../models/body_measurements.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Future<void> saveMeasurements(BodyMeasurements measurements) async {
    await _firestore
        .collection('users')
        .doc(measurements.userId)
        .collection('measurements')
        .doc(measurements.id)
        .set(measurements.toJson());
  }

  Future<BodyMeasurements?> getLatestMeasurements(String userId) async {
    final query = await _firestore
        .collection('users')
        .doc(userId)
        .collection('measurements')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
        
    if (query.docs.isNotEmpty) {
      return BodyMeasurements.fromJson(query.docs.first.data());
    }
    return null;
  }
}
