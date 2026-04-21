import 'dart:async';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'panorama_state.dart';

final panoramaViewModelProvider =
    StateNotifierProvider.autoDispose<PanoramaViewModel, PanoramaState>((ref) {
  return PanoramaViewModel();
});

class PanoramaViewModel extends StateNotifier<PanoramaState> {
  CameraController? _controller;
  CameraController? get controller => _controller;

  StreamSubscription? _accSub;
  StreamSubscription? _gyroSub;
  Timer? _captureTimer;
  DateTime? _lastGyroTime;

  PanoramaViewModel() : super(PanoramaState(targets: [
    {"yaw": 0, "pitch": 0},
    {"yaw": 45, "pitch": 0},
    {"yaw": 90, "pitch": 0},
    {"yaw": 135, "pitch": 0},
    {"yaw": 180, "pitch": 0},
    {"yaw": -135, "pitch": 0},
    {"yaw": -90, "pitch": 0},
    {"yaw": -45, "pitch": 0},
  ]));

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _controller = CameraController(cameras[0], ResolutionPreset.medium, enableAudio: false);
    await _controller!.initialize();
    state = state.copyWith(isInitialized: true);
    
    _startSensors();
    _startAutoCapture();
  }

  void _startSensors() {
    // 1. Dùng Accelerometer để tính Pitch (Lên/Xuống)
    _accSub = accelerometerEventStream().listen((event) {
      double ay = event.y;
      double az = event.z;
      // Tính pitch ổn định hơn khi cầm máy đứng (Portrait)
      double pitch = atan2(ay, az) * 180 / pi - 90;
      state = state.copyWith(pitch: pitch);
    });

    // 2. Dùng Gyroscope để tính Yaw (Trái/Phải) giúp chấm xanh đứng yên khi không xoay
    _gyroSub = gyroscopeEventStream().listen((event) {
      final now = DateTime.now();
      if (_lastGyroTime != null) {
        final dt = now.difference(_lastGyroTime!).inMicroseconds / 1000000.0;
        
        // event.y là tốc độ xoay quanh trục đứng (Yaw)
        double deltaYaw = (event.y * 180 / pi) * dt;
        double newYaw = state.yaw - deltaYaw;

        // Chuẩn hóa trong khoảng -180 đến 180
        if (newYaw > 180) newYaw -= 360;
        if (newYaw < -180) newYaw += 360;

        state = state.copyWith(yaw: newYaw);
      }
      _lastGyroTime = now;
    });
  }

  void _startAutoCapture() {
    _captureTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      _checkAndCapture();
    });
  }

  bool _isClose(double a, double b, double threshold) {
    double diff = (a - b).abs();
    if (diff > 180) diff = 360 - diff; // Xử lý điểm giáp ranh xoay vòng
    return diff < threshold;
  }

  void _checkAndCapture() async {
    if (_controller == null || !state.isInitialized) return;

    for (int i = 0; i < state.targets.length; i++) {
      final target = state.targets[i];
      if (!state.capturedIndexes.contains(i) &&
          _isClose(state.yaw, target["yaw"]!, 8) && 
          _isClose(state.pitch, target["pitch"]!, 8)) {
        
        final newCaptured = Set<int>.from(state.capturedIndexes)..add(i);
        state = state.copyWith(capturedIndexes: newCaptured);

        try {
          final XFile image = await _controller!.takePicture();
          state = state.copyWith(lastCapturedPath: image.path);
        } catch (e) {
          state = state.copyWith(error: e.toString());
        }
      }
    }
  }

  @override
  void dispose() {
    _accSub?.cancel();
    _gyroSub?.cancel();
    _captureTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }
}
