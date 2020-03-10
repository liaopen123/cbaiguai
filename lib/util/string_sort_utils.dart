import 'package:lpinyin/lpinyin.dart';

class PinYinUtils{
  /**
   * 获取汉字的首字母
   */
  static String getFirstPinyin(String value){
    String pinyin = PinyinHelper.getShortPinyin(value); // tfgc
    return pinyin.substring(0,1);
  }


}