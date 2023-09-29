String timeFormatter(int timeInMinutes){
  int years = timeInMinutes ~/ (365*24*60);
  timeInMinutes = timeInMinutes%(365*24*60);

  int days = timeInMinutes ~/ (24*60);
  timeInMinutes = timeInMinutes%(24*60);

  int hours = timeInMinutes ~/ (60);
  timeInMinutes = timeInMinutes%(60);

  int minutes = timeInMinutes;

  String result = "";
  if(years > 0){
    result += "${years}y ";
  }
  if(years > 0 || days > 0){
    result += "${days}d ";
  }
  if(years > 0 || days > 0) {
    result += "${("$hours").padLeft(2, '0')}h ";
  } else {
    result += "${hours}h";
  }
  result += "${"$minutes".padLeft(2, '0')}min";

  return result;
}