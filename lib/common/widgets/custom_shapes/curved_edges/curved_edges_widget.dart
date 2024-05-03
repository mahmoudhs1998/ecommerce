import 'package:ecommerce/common/widgets/custom_shapes/curved_edges/curved_edges.dart';
import 'package:flutter/material.dart';

class TCustomCurvedEdgesWidget extends StatelessWidget {
  final Widget? child;
  const TCustomCurvedEdgesWidget({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TCustomCurvedEdges(),
      child: child,
      
    );
  }
}
