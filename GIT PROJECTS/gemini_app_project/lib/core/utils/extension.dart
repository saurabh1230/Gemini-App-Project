// Default padding
import 'package:flutter/material.dart';

extension DefaultPadding on Widget {
  Widget defaultPaddingAll() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: this,
    );
  }
}

extension OnPressed on Widget {
  Widget ripple(
    Function onPressed,
  ) =>
      InkWell(
        onTap: () {
          onPressed();
        },
        child: this,
      );
}
