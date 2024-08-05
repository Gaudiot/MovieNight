String formatDuration(int minutes) {
  final hours = minutes ~/ 60;
  final remainingMinutes = minutes % 60;

  return "${hours}h${remainingMinutes.toString().padLeft(2, '0')}min";
}
