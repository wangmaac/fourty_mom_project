import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

AutoScrollController autoScrollController = AutoScrollController(
    viewportBoundaryGetter: () =>
        //Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        const Rect.fromLTRB(0, 0, 0, 0),
    axis: Axis.horizontal);
