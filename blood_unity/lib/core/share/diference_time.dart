String diferenceTime(DateTime dateTime) {
  Duration difTime = DateTime.now().difference(dateTime);

  if (difTime.inDays > 0) {
    return "${difTime.inDays} d";
  } else if (difTime.inHours > 0) {
    return "${difTime.inHours} h";
  } else if (difTime.inMinutes > 0) {
    return "${difTime.inMinutes} min";
  } else {
    return "${difTime.inSeconds} sec";
  }
}
