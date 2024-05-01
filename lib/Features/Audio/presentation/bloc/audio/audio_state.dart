part of 'audio_cubit.dart';

class AudioState {
  bool isPlaying;
  Duration duration;
  Duration position;
  IconData icon;
  AudioState(
      {required this.icon,
      required this.duration,
      required this.isPlaying,
      required this.position});

  AudioState copyWith(
      {Duration? dur, Duration? pos, bool? isplay, IconData? icon}) {
    return AudioState(
        icon: icon ?? this.icon,
        duration: dur ?? duration,
        isPlaying: isplay ?? isPlaying,
        position: pos ?? position);
  }
}
