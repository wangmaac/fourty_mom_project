import 'package:flutter/material.dart';

ImageIcon readingIcon(double size, bool selected){
  return ImageIcon(
    const AssetImage('images/icons/book_icon.png'),
    size: size,
    color: selected ? Colors.black : Colors.grey.withOpacity(0.5),
  );
}
ImageIcon videoIcon(double size, bool selected){
  return ImageIcon(
    const AssetImage('images/icons/video_icon.png'),
    size: size,
    color: selected ? Colors.black : Colors.grey.withOpacity(0.5),
  );
}
ImageIcon listeningIcon(double size, bool selected){
  return ImageIcon(
    const AssetImage('images/icons/music_icon.png'),
    size: size,
    color: selected ? Colors.black : Colors.grey.withOpacity(0.5),
  );
}