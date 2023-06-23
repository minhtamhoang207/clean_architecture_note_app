import 'package:intl/intl.dart';

enum Pattern {
  hhmm,
  hhmmss,
  ddmmm,
  md,
  ddMMyyyy,
  ddMMyyyyHHmmss,
  ddMMMMyyyyHHmm,
  yyyyMMddHHmm,
  yyyyMMddHHmm_JP,
  yyyyMMdd,
  yyyyMMddHHmmss,
  yyyyMMddHHmmss_JP,
  yyyyMM_JP,
  yyyyMM,
  hhmmssddMMyyyy,
  yyyyMMdd_HHmmss,
  hhmmssampm,
}

extension PatternExtension on Pattern {
  String get pattern {
    switch (this) {
      case Pattern.hhmm:
        return 'HH:mm';
      case Pattern.hhmmss:
        return 'HH:mm:ss';
      case Pattern.ddmmm:
        return 'dd MMM';
      case Pattern.md:
        return 'M/d';
      case Pattern.ddMMyyyy:
        return 'dd/MM/yyyy';
      case Pattern.ddMMyyyyHHmmss:
        return 'dd/MM/yyyy HH:mm:ss';
      case Pattern.ddMMMMyyyyHHmm:
        return 'dd MMMM yyyy, HH:mm';
      case Pattern.yyyyMMddHHmm:
        return 'yyyy/MM/dd HH:mm';
      case Pattern.yyyyMMddHHmm_JP:
        return 'yyyy年 MM月 dd日 HH時 mm分';
      case Pattern.yyyyMMdd:
        return 'yyyyMMdd';
    // return 'yyyy年　MM月　dd日';
      case Pattern.yyyyMMddHHmmss:
        return 'yyyy-MM-dd HH:mm:ss';
      case Pattern.yyyyMMddHHmmss_JP:
        return 'yyyy-MM-dd HH:mm:ss';
      case Pattern.yyyyMM_JP:
        return 'yyyy年 MM月';
      case Pattern.yyyyMM:
        return 'yyyy-MM';
      case Pattern.hhmmssddMMyyyy:
        return 'HH:mm:ss - dd/MM/yyyy';
      case Pattern.yyyyMMdd_HHmmss:
        return 'yyyyMMdd_HHmmss';
      case Pattern.hhmmssampm:
        return 'hh:mm:ss a';
      default:
        return '';
    }
  }
}

class DateTimeUtils {
  static const secondMillis = 1000;
  static const minuteMillis = 60 * secondMillis;
  static const hourMillis = 60 * minuteMillis;
  static const dayMillis = 24 * hourMillis;
  static const weekMillis = 7 * dayMillis;
  static const minuteSecond = 60;
  static const hourSecond = 60 * minuteSecond;
  static const monthMillis = 31 * dayMillis;
  static const quarterMillis = 3 * monthMillis;

  static String formatDateFromInt(int date, Pattern pattern) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);
    return DateFormat(pattern.pattern).format(dateTime);
  }

  static DateTime? getDateTime(dynamic dateToConvert, {Pattern? pattern}) {
    assert(dateToConvert is int || pattern != null);
    if (dateToConvert is int) {
      return DateTime.fromMillisecondsSinceEpoch(dateToConvert);
    } else if (dateToConvert is String) {
      return DateFormat(pattern!.pattern).parse(dateToConvert);
    }
    return null;
  }

  static String getStringDate(dynamic dateToConvert,
      {Pattern? pattern, String? languageCode}) {
    assert(dateToConvert is DateTime || pattern != null);
    if (dateToConvert == null) {
      return '';
    }
    final dateFormat = DateFormat(pattern!.pattern, languageCode);
    if (dateToConvert is int) {
      final datetime = getDateTime(dateToConvert);
      return dateFormat.format(datetime!);
    } else if (dateToConvert is DateTime) {
      return dateFormat.format(dateToConvert);
    }
    return '';
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays ==
        0;
  }

  static bool isWarning(dynamic time, {Pattern? patternConvert}) {
    final datetime = getTimestamp(time, pattern: patternConvert);
    final diff = DateTime.now().millisecondsSinceEpoch - datetime;
    final week = diff ~/ weekMillis;
    return week > 1;
  }

  static bool isTooLong(dynamic time, {Pattern? patternConvert}) {
    final datetime = getTimestamp(time, pattern: patternConvert);
    final diff = DateTime.now().millisecondsSinceEpoch - datetime;
    final month = diff ~/ monthMillis;
    return month > 3;
  }

  static String getStringTimeAgo(dynamic time,
      {Pattern? pattern, String? languageCode}) {
    assert(time is DateTime || pattern != null);

    final datetime = getTimestamp(time, pattern: pattern);
    final diff = DateTime.now().millisecondsSinceEpoch - datetime;
    if (diff < minuteMillis) {
      return '1 phút';
    } else if (diff < 60 * minuteMillis) {
      final minute = diff ~/ minuteMillis;
      return '$minute ${Intl.plural(minute, one: 'phút', other: 'phút')}';
    } else if (diff < 24 * hourMillis) {
      final hour = diff ~/ hourMillis;
      return '$hour ${Intl.plural(hour, one: 'giờ', other: 'giờ')}';
    } else if (diff < weekMillis) {
      final day = (diff / dayMillis).round();
      return '$day ${Intl.plural(day, one: 'ngày', other: 'ngày')}';
    } else if (diff < monthMillis) {
      final week = diff ~/ weekMillis;
      return '$week ${Intl.plural(week, one: 'tuần', other: 'tuần')}';
    } else if (diff < quarterMillis) {
      final month = diff ~/ monthMillis;
      return '$month ${Intl.plural(month, one: 'tháng', other: 'tháng')}';
    }
    return getStringDate(datetime,
        pattern: pattern, languageCode: languageCode);
  }

  static String getStringNotificationTimeAgo(DateTime time,
      {Pattern? pattern, String? languageCode}) {
    final datetime = getTimestamp(time, pattern: pattern);

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final diff = now.millisecondsSinceEpoch - datetime;

    if (diff < minuteMillis) {
      return 'now';
    } else if (diff < 60 * minuteMillis) {
      final minute = diff ~/ minuteMillis;
      return '$minute ${Intl.plural(minute, one: 'minute', other: 'minutes')}';
      // return '$minute minutes';
    } else if (time.day == today.day) {
      return DateFormat('hh:mm a').format(time);
    } else if (diff < 48 * hourMillis) {
      return 'Yesterday at ${DateFormat('hh:mm a').format(time)}';
    } else if (diff < weekMillis) {
      return '${DateFormat('EEEE').format(time)} at ${DateFormat('hh:mm a').format(time)}';
    }
    return '${DateFormat('d MMM').format(time)} at ${DateFormat('hh:mm a').format(time)}';
  }

  static int getTimestamp(dynamic dateToConvert, {Pattern? pattern}) {
    assert(dateToConvert is DateTime || pattern != null);
    if (dateToConvert is DateTime) {
      return dateToConvert.millisecondsSinceEpoch;
    } else if (dateToConvert is String) {
      final dateFormat = DateFormat(pattern?.pattern);
      return dateFormat.parse(dateToConvert).millisecondsSinceEpoch;
    }
    return 0;
  }

  static String getStringNotificationTime(DateTime time) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final lastWeek = DateTime.fromMillisecondsSinceEpoch(
        today.millisecondsSinceEpoch - weekMillis);
    final thisYear = DateTime(now.year);

    if (time.isAfter(today)) {
      return DateFormat('h:mm a').format(time);
    } else if (time.isAfter(lastWeek)) {
      return '${DateFormat('EEEE').format(time)} at ${DateFormat('hh:mm a').format(time)}';
    } else if (time.isAfter(thisYear) || time.isAtSameMomentAs(thisYear)) {
      return '${DateFormat('d MMM').format(time)} at ${DateFormat('hh:mm a').format(time)}';
    }
    return DateFormat(Pattern.ddMMyyyy.pattern).format(time);
  }

  static String getRecordTime(int time) {
    int hour = (time / hourSecond).floor();
    int remainSecond = time % hourSecond;
    int minute = (remainSecond / minuteSecond).floor();
    remainSecond = remainSecond % minuteSecond;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${remainSecond.toString().padLeft(2, '0')}';
  }

  static String durationToMinute(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
