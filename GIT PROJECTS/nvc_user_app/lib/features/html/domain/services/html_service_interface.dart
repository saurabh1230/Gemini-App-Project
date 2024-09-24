import 'package:nvc_user/features/html/enums/html_type.dart';

abstract class HtmlServiceInterface{
  Future<String?> getHtmlText(HtmlType htmlType, String languageCode);
}