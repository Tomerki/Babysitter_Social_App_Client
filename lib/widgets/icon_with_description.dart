import 'package:flutter/material.dart';

class IconWithDescription extends StatefulWidget {
  final IconData icon;

  IconWithDescription({Key? key, required this.icon}) : super(key: key);

  @override
  _IconWithDescriptionState createState() => _IconWithDescriptionState();
}

class _IconWithDescriptionState extends State<IconWithDescription> {
  late OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = OverlayEntry(builder: (_) => _buildDescriptionDialog());
  }

  @override
  void dispose() {
    _overlayEntry.remove();
    super.dispose();
  }

  void _showDescriptionDialog() {
    Overlay.of(context).insert(_overlayEntry);
  }

  void _hideDescriptionDialog() {
    _overlayEntry.remove();
  }

  Widget _buildDescriptionDialog() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: _hideDescriptionDialog,
        child: Container(
          color: Colors.black54,
          alignment: Alignment.center,
          child: AlertDialog(
            title: Text('Button Description'),
            content: Text('This button performs a certain action.'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showDescriptionDialog();
      },
      onLongPressEnd: (_) {
        _hideDescriptionDialog();
      },
      child: Icon(
        widget.icon,
      ),
    );
  }
}