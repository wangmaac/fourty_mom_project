import 'package:flutter/material.dart';

ImageIcon readingIcon(double size, bool selected,
    {Color color = Colors.black}) {
  return ImageIcon(
    const AssetImage('images/icons/book_icon.png'),
    size: size,
    color: selected ? color : Colors.grey.withOpacity(0.5),
  );
}

ImageIcon videoIcon(double size, bool selected, {Color color = Colors.black}) {
  return ImageIcon(
    const AssetImage('images/icons/video_icon.png'),
    size: size,
    color: selected ? color : Colors.grey.withOpacity(0.5),
  );
}

ImageIcon listeningIcon(double size, bool selected,
    {Color color = Colors.black}) {
  return ImageIcon(
    const AssetImage('images/icons/music_icon.png'),
    size: size,
    color: selected ? color : Colors.grey.withOpacity(0.5),
  );
}
