import 'dart:io';

abstract class ARService {
  Future<void> initializeSession();
  Future<void> startTracking();
  Future<List<double>> getDepthMap();
  Future<List<List<double>>> getPointCloud();
  void dispose();

  factory ARService() {
    if (Platform.isIOS) {
      return ARKitServiceImpl();
    } else {
      return ARCoreServiceImpl();
    }
  }
}

class ARKitServiceImpl implements ARService {
  @override
  Future<void> initializeSession() async {}

  @override
  Future<void> startTracking() async {}

  @override
  Future<List<double>> getDepthMap() async => [];

  @override
  Future<List<List<double>>> getPointCloud() async => [];

  @override
  void dispose() {}
}

class ARCoreServiceImpl implements ARService {
  @override
  Future<void> initializeSession() async {}

  @override
  Future<void> startTracking() async {}

  @override
  Future<List<double>> getDepthMap() async => [];

  @override
  Future<List<List<double>>> getPointCloud() async => [];

  @override
  void dispose() {}
}
