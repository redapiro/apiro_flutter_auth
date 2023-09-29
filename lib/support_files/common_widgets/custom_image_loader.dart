
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user_authentication/support_files/common_widgets/progress_indicator.dart';
import 'package:user_authentication/utils/app_colors.dart';

class CustomImageLoaderWidget extends StatelessWidget {
  final String imageUrl;
  CustomImageLoaderWidget({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    AppColors.disabledColor, BlendMode.colorBurn)),
          ),
        ),
        placeholder: (context, url) => CustomProgressIndicator(),
        errorWidget: (context, url, error) {
          return Icon(Icons.error);
        },
      ),
    );
  }
}
