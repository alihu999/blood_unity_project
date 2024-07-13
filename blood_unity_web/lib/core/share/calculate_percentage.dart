String calculatePercentage(int total, int orders) {
  if (total != 0) {
    return "${((orders / total) * 100).toStringAsFixed(2)} %";
  } else {
    return "0 %";
  }
}
