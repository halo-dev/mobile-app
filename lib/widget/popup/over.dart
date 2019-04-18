import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowOverlayPop {
  BuildContext context;
  EdgeInsets margin;

  ShowOverlayPop(this.context, this.margin);

  OverlayState overlayState;
  OverlayEntry overlayEntry;

  void createView(Widget child) {
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
        builder: (BuildContext context) => GestureDetector(
              onTap: dismiss,
              child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: margin,
                    child: child,
                  )),
            ));
    overlayState.insert(overlayEntry);
  }

  void dismiss() {
    overlayEntry?.remove();
  }
}
