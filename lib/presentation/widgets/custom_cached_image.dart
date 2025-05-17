import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double borderRadius;

  const CustomCachedImage._({
    required this.imageUrl,
    required this.size,
    required this.borderRadius,
    Key? key,
  }) : super(key: key);

  /// Small - 40x40, circular
  factory CustomCachedImage.avatarSmall(String imageUrl, {Key? key}) {
    return CustomCachedImage._(
      imageUrl: imageUrl,
      size: 40,
      borderRadius: 20, // Half of size for full circle
      key: key,
    );
  }

  /// Medium - 60x60, circular
  factory CustomCachedImage.avatarLarge(String imageUrl, {Key? key}) {
    return CustomCachedImage._(
      imageUrl: imageUrl,
      size: 60,
      borderRadius: 30,
      key: key,
    );
  }

  /// Big - 163x163, rounded with 16.3px radius
  factory CustomCachedImage.thumbnailRounded(String imageUrl, {Key? key}) {
    return CustomCachedImage._(
      imageUrl: imageUrl,
      size: 163,
      borderRadius: 16.3,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          color: Colors.grey.shade300,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 1.5)),
        ),
        errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          color: Colors.grey.shade300,
          child: const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}
