extension DateTimeExtension on DateTime {
  String paraDDMMYYYY() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();

    return '$day/$month/$year';
  }
}
