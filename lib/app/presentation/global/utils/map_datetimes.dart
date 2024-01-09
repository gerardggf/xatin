String mapDay(DateTime date) {
  final today = DateTime.now();
  if (date.day == today.day &&
      date.month == today.month &&
      date.year == today.year) {
    return '';
  } else if (date.day == today.day - 1 &&
      date.month == today.month &&
      date.year == today.year) {
    return 'Yesterday';
  }
  return '${date.day}/${date.month}/${date.year}';
}
