import 'package:flutter/material.dart';

/// Class InfoPanel is used to display information about a marker.
class InfoPanel extends StatelessWidget {
  final String markerId;
  final VoidCallback onClose;

  const InfoPanel({
    Key? key,
    required this.markerId,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // TODO set theme bg color
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onClose,
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Text('Marker id: $markerId'),
          // TODO add info contained in marker!
          // TODO ensure this container is scrollable
        ],
      ),
    );
  }
}
