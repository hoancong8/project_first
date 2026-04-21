import 'package:camera/camera.dart';

class PanoramaState {
  final bool isInitialized;
  final double pitch;
  final double yaw;
  final List<Map<String, double>> targets;
  final Set<int> capturedIndexes;
  final String? lastCapturedPath;
  final String? error;

  PanoramaState({
    this.isInitialized = false,
    this.pitch = 0,
    this.yaw = 0,
    this.targets = const [],
    this.capturedIndexes = const {},
    this.lastCapturedPath,
    this.error,
  });

  PanoramaState copyWith({
    bool? isInitialized,
    double? pitch,
    double? yaw,
    List<Map<String, double>>? targets,
    Set<int>? capturedIndexes,
    String? lastCapturedPath,
    String? error,
  }) {
    return PanoramaState(
      isInitialized: isInitialized ?? this.isInitialized,
      pitch: pitch ?? this.pitch,
      yaw: yaw ?? this.yaw,
      targets: targets ?? this.targets,
      capturedIndexes: capturedIndexes ?? this.capturedIndexes,
      lastCapturedPath: lastCapturedPath ?? this.lastCapturedPath,
      error: error ?? this.error,
    );
  }
}
