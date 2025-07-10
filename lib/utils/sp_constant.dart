import 'package:bayes/utils/sp_utils.dart';

class SpConstanst {
  static final String IS_LOGIN = "IS_LOGIN";
  static final String USER_TOKEN = "USER_TOKEN";
  static final String USER_PWD = "USER_PWD";
  static final String USER_ID = "USER_ID";
  static final String USER_PHONE = "USER_PHONE";
  static final String USER_NAME = "USER_NAME";
  static final String USER_HEADER_IMAGE = "USER_HEADER_IMAGE";
  static final String USER_SEX = "USER_SEX";
  static final String SEARCH_LIST = "SEARCH_LIST";
  static final String WX_ACCESS_TOKEN = "WX_ACCESS_TOKEN";
  static final String USER_SIGN = "USER_SIGN";

  //用户默认地址信息
  static final String USER_ADDRESS = "USER_ADDRESS";
  static final String USER_ADDRESS_ID = "USER_ADDRESS_ID";
  static final String USER_ADDRESS_NAME = "USER_ADDRESS_NAME";
  static final String USER_ADDRESS_PHONE = "USER_ADDRESS_PHONE";

  final String VideoSpeed = "VideoSpeed"; //视频播放倍数

  void setVideoSpeed(double value) {
    SpUtils().setDouble(VideoSpeed, value);
  }

  double? getVideoSpeed() {
    double? value = SpUtils().getDouble(VideoSpeed);
    if (value == 0) return 1.0;
    return value;
  }
}
