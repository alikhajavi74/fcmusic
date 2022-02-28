import 'package:flutter/material.dart';

// --------------------------------------------------------------------------------------------------------------------

// My fadeInImage widget:

class MFadeInImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final String placeHolderAddress;

  const MFadeInImage({Key? key, this.image = "noImage", this.fit = BoxFit.fill, this.placeHolderAddress = "images/default_profile.jpg"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      key: UniqueKey(),
      image: image,
      fit: fit,
      placeholder: placeHolderAddress,
      imageErrorBuilder: (context, error, stacktrace) => Image.asset(placeHolderAddress, fit: fit),
    );
  }
}

// --------------------------------------------------------------------------------------------------------------------
