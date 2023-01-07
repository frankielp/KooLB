import 'package:intl/intl.dart';
import 'package:koolb/accommodation/category.dart';

String dateTimeToString(DateTime date, {String format = 'dd/MM/yyyy'}) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

List<Category> intArrayToListCategory(List a) {
  List<Category> ret = [];
  a.forEach((element) {
    ret.add(Category.values[element]);
  });
  return ret;
}
