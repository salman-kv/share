class TimeFunction{
    toDateOnly({required DateTime dateTime}) {
    return '${dateTime.day} , ${dateTime.month} , ${dateTime.year}';
  }

  toTimeOnly({required DateTime dateTime}) {
    return '${dateTime.hour == 0 ? 1 : dateTime.hour <= 12 ? dateTime.hour : dateTime.hour - 12} : ${dateTime.minute}  ${dateTime.hour < 12 ? 'AM' : 'PM'} ';
  }
}