import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constant/app_icons.dart';

class ImageLoaderWidget extends StatelessWidget {
  final String imageUrl;
  const ImageLoaderWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => SvgPicture.asset(AppIcons.personIcon), // Path to your placeholder image
      errorWidget: (context, url, error) => SvgPicture.asset(AppIcons.personIcon), // Display an error icon if the image fails to load
      fit: BoxFit.cover,
    );
  }
}