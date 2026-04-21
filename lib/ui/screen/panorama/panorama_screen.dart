import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'panorama_vm.dart';

class PanoramaScreen extends ConsumerStatefulWidget {
  const PanoramaScreen({super.key});

  @override
  ConsumerState<PanoramaScreen> createState() => _PanoramaScreenState();
}

class _PanoramaScreenState extends ConsumerState<PanoramaScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(panoramaViewModelProvider.notifier).initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(panoramaViewModelProvider);
    final size = MediaQuery.of(context).size;

    // Tìm điểm mục tiêu tiếp theo chưa được chụp
    int? nextTargetIndex;
    for (int i = 0; i < state.targets.length; i++) {
      if (!state.capturedIndexes.contains(i)) {
        nextTargetIndex = i;
        break;
      }
    }

    Widget? targetDot;
    if (nextTargetIndex != null) {
      final target = state.targets[nextTargetIndex];
      
      // Tính toán độ lệch giữa hướng hiện tại và mục tiêu
      double diffYaw = target["yaw"]! - state.yaw;
      double diffPitch = target["pitch"]! - state.pitch;

      // Chuẩn hóa góc quay Yaw trong khoảng -180 đến 180 độ
      if (diffYaw > 180) diffYaw -= 360;
      if (diffYaw < -180) diffYaw += 360;

      // Chuyển đổi độ lệch sang tọa độ Pixel (Hệ số nhạy cảm: 15.0)
      double sensitivity = 15.0;
      double dx = diffYaw * sensitivity;
      double dy = -diffPitch * sensitivity; 

      // Giới hạn chấm trong phạm vi màn hình
      dx = dx.clamp(-size.width / 2 + 30, size.width / 2 - 30);
      dy = dy.clamp(-size.height / 2 + 30, size.height / 2 - 30);

      targetDot = Center(
        child: Transform.translate(
          offset: Offset(dx, dy),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.8),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.greenAccent.withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(Icons.camera_alt, color: Colors.black, size: 20),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Camera Preview
          if (state.isInitialized)
            Positioned.fill(
              child: CameraPreview(
                  ref.read(panoramaViewModelProvider.notifier).controller!),
            )
          else
            const Center(child: CircularProgressIndicator()),

          // 2. Chấm mục tiêu (Target Dot di chuyển)
          if (targetDot != null) targetDot,

          // 3. Vòng tròn cố định ở tâm (Người dùng cần đưa chấm xanh vào đây)
          Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.8), width: 3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),

          // 4. Chỉ dẫn người dùng
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  nextTargetIndex != null
                      ? "Đưa chấm xanh vào vòng tròn trắng để chụp"
                      : "🎉 Đã hoàn thành bộ ảnh Panorama!",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          // 5. Trạng thái các góc đã chụp (Progress Dots)
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(state.targets.length, (index) {
                final isCaptured = state.capturedIndexes.contains(index);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isCaptured ? Colors.greenAccent : Colors.white24,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white54, width: 1),
                  ),
                );
              }),
            ),
          ),

          // 6. Thông số Debug
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Yaw: ${state.yaw.toStringAsFixed(1)}°',
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  Text('Pitch: ${state.pitch.toStringAsFixed(1)}°',
                      style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
