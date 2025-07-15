import 'package:bayes/base/common_function.dart';

abstract class BaseIntercept {
  late BaseFunction baseFuntion;
  bool isDefaultFailure = true;
  bool isInit = false;

  void beforeRequest();

  void afterRequest();

  void loginExpiration();

  void requestFailure(String content) {
    //默认请求出错的处理，可以通过设置 isDefaultFailure 来控制
    if (isDefaultFailure) {
      if (content.isNotEmpty) {
        //        baseFuntion.showToast(content);
      }
    }
  }

  String getClassName() {
    return baseFuntion.getClassName();
  }
}
