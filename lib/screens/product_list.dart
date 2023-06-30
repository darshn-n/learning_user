// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:gsss_learning/providers/category_provider.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsss_learning/widgets/product_display_card.dart';
import 'package:provider/provider.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Matrix4 getScaleDownMatrix(TransformableListItem item) {
    /// final scale of child when the animation is completed
    const endScaleBound = 0.3;

    /// 0 when animation completed and [scale] == [endScaleBound]
    /// 1 when animation starts and [scale] == 1
    final animationProgress = item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

      paintTransform
        ..translate(item.size.width / 2)
        ..scale(scale)
        ..translate(-item.size.width / 2);
    }

    return paintTransform;
  }

  Matrix4 getRotateMatrix(TransformableListItem item) {
    /// rotate item to 90 degrees
    const maxRotationTurnsInRadians = pi / 2.0;

    /// 0 when animation starts and [rotateAngle] == 0 degrees
    /// 1 when animation completed and [rotateAngle] == 90 degrees
    final animationProgress = 1 - item.visibleExtent / item.size.height;

    /// result matrix
    final paintTransform = Matrix4.identity();

    /// animate only if item is on edge
    if (item.position != TransformableListItemPosition.middle) {
      /// rotate to the left if even
      /// rotate to the right if odd
      final isEven = item.index?.isEven ?? false;

      /// To select corner of the rotation
      final FractionalOffset fractionalOffset;
      final int rotateDirection;

      switch (item.position) {
        case TransformableListItemPosition.topEdge:
          fractionalOffset = isEven
              ? FractionalOffset.bottomLeft
              : FractionalOffset.bottomRight;
          rotateDirection = isEven ? -1 : 1;
          break;
        case TransformableListItemPosition.middle:
          return paintTransform;
        case TransformableListItemPosition.bottomEdge:
          fractionalOffset =
              isEven ? FractionalOffset.topLeft : FractionalOffset.topRight;
          rotateDirection = isEven ? 1 : -1;
          break;
      }

      final rotateAngle = animationProgress * maxRotationTurnsInRadians;
      final translation = fractionalOffset.alongSize(item.size);

      paintTransform
        ..translate(translation.dx, translation.dy)
        ..rotateZ(rotateDirection * rotateAngle)
        ..translate(-translation.dx, -translation.dy);
    }

    return paintTransform;
  }

  Matrix4 getWheelMatrix(TransformableListItem item) {
    /// rotate item to 36 degrees
    const maxRotationTurnsInRadians = pi / 5.0;
    const minScale = 0.6;
    const maxScale = 1.0;

    /// perception of depth when the item rotates
    const depthFactor = 0.01;

    /// offset when [animationProgress] == 0
    final medianOffset = item.constraints.viewportMainAxisExtent / 2;
    final animationProgress =
        1 - item.offset.dy.clamp(0, double.infinity) / medianOffset;
    final scale = minScale + (maxScale - minScale) * animationProgress.abs();

    /// alignment of item
    final translationOffset = FractionalOffset.center.alongSize(item.size);
    final rotationMatrix = Matrix4.identity()
      ..setEntry(3, 2, depthFactor)
      ..rotateX(maxRotationTurnsInRadians * animationProgress)
      ..scale(scale);

    final result = Matrix4.identity()
      ..translate(translationOffset.dx, translationOffset.dy)
      ..multiply(rotationMatrix)
      ..translate(-translationOffset.dx, -translationOffset.dy);

    return result;
  }

  late final transformMatrices = {
    'Scale': getScaleDownMatrix,
    'Rotate': getRotateMatrix,
    'Wheel': getWheelMatrix,
  };

  late String currentMatrix = transformMatrices.entries.first.key;

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var catProvider = Provider.of<CategoryProvider>(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          12,
          8,
          12,
          8,
        ),
        child: FutureBuilder<QuerySnapshot>(
          future: service.products
              .where(
                "category",
                isEqualTo: catProvider.selectedCategory,
              )
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(
                  left: 140.0,
                  right: 140.0,
                ),
                child: Center(
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                    color: Colors.grey.shade100,
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.size,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.docs[index];
                    String formattedPrice = "format.format(price)";

                    // Display Card:
                    return ProductDisplayCard(
                        data: data, formattedPrice: formattedPrice);
                  },
                ),

                // Expanded(
                //   child: IndexedStack(
                //     index:
                //         transformMatrices.keys.toList().indexOf(currentMatrix),
                //     children: [
                //       for (final matrix in transformMatrices.values)
                //         TransformableListView.builder(
                //           controller: ScrollController(),
                //           padding: EdgeInsets.zero,
                //           getTransformMatrix: matrix,
                //           itemBuilder: (context, index) {
                //             return Container(
                //               height: 100,
                //               margin: const EdgeInsets.symmetric(
                //                 horizontal: 16,
                //                 vertical: 4,
                //               ),
                //               decoration: BoxDecoration(
                //                 color: index.isEven
                //                     ? Colors.grey
                //                     : Colors.blueAccent,
                //                 borderRadius: BorderRadius.circular(20),
                //               ),
                //               alignment: Alignment.center,
                //               child: Text(index.toString()),
                //             );
                //           },
                //           itemCount: 30,
                //         ),
                //     ],
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
