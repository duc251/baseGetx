import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Use for Network Image
class CachedImageWidget extends StatelessWidget {
  final String url;
  final Alignment alignment;
  final double? borderRadius;
  final BoxShape? shape;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final BoxBorder? border;
  const CachedImageWidget({
    Key? key,
    required this.url,
    this.borderRadius,
    this.alignment = Alignment.topLeft,
    this.fit,
    this.shape,
    this.width,
    this.height,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius:
              shape == null ? BorderRadius.circular(borderRadius ?? 0) : null,
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      fit: BoxFit.cover,
      alignment: alignment,
      memCacheHeight: 150,
      memCacheWidth: 150,
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: const CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: const Icon(Icons.error),
      ),
    );
  }
}

CachedNetworkImageProvider cachedNetworkImageProvider(url) =>
    CachedNetworkImageProvider(
      url,
    );
