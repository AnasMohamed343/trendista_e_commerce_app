import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/core/enums/device_type.dart';

DeviceType getDeviceType(MediaQueryData mediaQueryData) {
  Orientation orientation = mediaQueryData.orientation;
  double width = 0;
  double height = 0;
  if (orientation == Orientation.landscape) {
    width = mediaQueryData.size.height;
    height = mediaQueryData.size.width;
  } else {
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
  }
  if (width >= 1200) {
    return DeviceType.HugeDesktop;
  }
  if (width >= 950) {
    //950
    return DeviceType.Desktop;
  }
  if (width >= 810) {
    return DeviceType.IPad;
  }
  if (width >= 600) {
    return DeviceType.Tablet;
  }
  if (height >= 855) {
    return DeviceType.TallMobile;
  }
  return DeviceType.Mobile;
}
