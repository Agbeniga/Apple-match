import 'package:flutter/material.dart';

extension AlignWidget on Widget {
  Align left() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Align right() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align bottom() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }

  Align top() {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }

  Align center() {
    return Align(
      alignment: Alignment.center,
      child: this,
    );
  }

  Align topRight() {
    return Align(
      alignment: Alignment.topRight,
      child: this,
    );
  }

  Align topLeft() {
    return Align(
      alignment: Alignment.topLeft,
      child: this,
    );
  }

  Align bottomRight() {
    return Align(
      alignment: Alignment.bottomRight,
      child: this,
    );
  }

  Align bottomLeft() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: this,
    );
  }
}
