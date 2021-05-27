import 'package:flutter/material.dart';

class ControlsWidget extends StatelessWidget {
  final VoidCallback onClickedPickImage;
  final VoidCallback onClickedScanText;
  final VoidCallback onClickedClear;
  final VoidCallback onClickedClickImage;

  const ControlsWidget({
    @required this.onClickedPickImage,
    @required this.onClickedScanText,
    @required this.onClickedClear,
    @required this.onClickedClickImage,
  });

  @override
  Widget build(BuildContext context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: onClickedPickImage,
              label: Text('Pick Image'),
              icon: Icon(Icons.image_rounded),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: onClickedClickImage,
              icon: Icon(Icons.camera_alt_outlined),
              label: Text('Camera'),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: onClickedScanText,
              label: Text('Scan For Text'),
              icon: Icon(Icons.image_search),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.clear),
              onPressed: onClickedClear,
              label: Text('Clear'),
            )
          ],
        ),
      );
}
