import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/config/assets/app_images.dart';
import '../containers/app_container.dart';

class CachedImageContainer extends StatelessWidget {
  const CachedImageContainer({
    super.key,
    required this.url,
    this.isImageExist = false,
    this.width = 50.0,          // 50×50 like your Image.network example
    this.height = 50.0,
    this.borderRadius = 0,
    this.defaultImageUrl = AppImages.defaultAvatar
  });

  final double height;
  final double width;
  final String url;
  final bool isImageExist;
  final String defaultImageUrl;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      clip: Clip.hardEdge,
        borderRadius: borderRadius,
        // color: Colors.grey[300],
      height: height,
      width: width,
      child: !isImageExist
          ?
      Image.asset(
        defaultImageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
      )
          : CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: BoxFit.cover,

        // -- THIS is all you need while the file is downloading --
        placeholder: (_, _) => Shimmer.fromColors(
          baseColor: Colors.grey.withAlpha(70),
          highlightColor: Colors.white.withAlpha(50),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: Colors.grey[300]
            ),
            width: double.infinity,
            height: double.infinity,
          ),
        ),

        // -- If the fetch fails --
        errorWidget: (_, _, _) => Image.asset(
          defaultImageUrl,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
