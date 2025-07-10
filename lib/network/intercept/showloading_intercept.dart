import 'package:erp_music/base/common_function.dart';

import 'base_intercept.dart';

class ShowLoadingIntercept extends BaseIntercept {
  ShowLoadingIntercept(BaseFuntion baseFuntion,
      {bool isDefaultFailure = true, bool isInit = false}) {
    this.baseFuntion = baseFuntion;
    this.isDefaultFailure = isDefaultFailure;
    this.isInit = isInit;
  }

  @override
  void afterRequest() {
    if (baseFuntion != null) {
      baseFuntion.showDiaolog(false, isInit);
      print(isInit);
    }
  }

  @override
  void beforeRequest() {
    if (baseFuntion != null) {
      baseFuntion.showDiaolog(true, isInit);
    }
  }

  @override
  void loginExpiration() {
    if (baseFuntion != null) {
      baseFuntion.toLoginPage();
    }
  }
}
