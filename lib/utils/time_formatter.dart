String timeFormatter(int timeInMinutes){
  int hours = (timeInMinutes/60).floor();
  String minutes = (timeInMinutes%60).toString().padLeft(2, '0');

  return '${hours}h${minutes}min';
}