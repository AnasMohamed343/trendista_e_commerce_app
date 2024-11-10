import 'package:flutter/material.dart';
import 'package:trendista_e_commerce/core/helper_functions/get_device_type.dart';
import 'package:trendista_e_commerce/core/models/device_info.dart';

class InfoWidget extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceInfo deviceInfo) builder;

  const InfoWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var mediaQueryData = MediaQuery.of(context);
        var deviceInfo = DeviceInfo(
          orientation: mediaQueryData.orientation,
          deviceType: getDeviceType(mediaQueryData),
          screenWidth: mediaQueryData.size.width,
          screenHeight: mediaQueryData.size.height,
          localWidth: constraints.maxWidth,
          localHeight: constraints.maxHeight,
        );
        return builder(context, deviceInfo);
      },
    );
  }
}
