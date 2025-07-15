import 'package:bayes/base/common_function.dart';
import 'package:bayes/network/intercept/base_intercept.dart';

class ShowLoadingIntercept extends BaseIntercept {
  ShowLoadingIntercept(
    BaseFunction baseFuntion, {
    bool isDefaultFailure = true,
    bool isInit = false,
  }) {
    this.baseFuntion = baseFuntion;
    this.isDefaultFailure = isDefaultFailure;
    this.isInit = isInit;
  }

  @override
  void afterRequest() {
    baseFuntion.showDiaolog(false, isInit);
  }

  @override
  void beforeRequest() {
    baseFuntion.showDiaolog(true, isInit);
  }

  @override
  void loginExpiration() {
    baseFuntion.toLoginPage();
  }
}
