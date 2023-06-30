import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key}) : super(key: key);
  static const String id = "categories-List-screen";

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  /// List of Tab Bar Item
  List<String> items = [
    "All",
    "Announce",
    "Updates",
    "Newsletter",
    "Feedback",
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        current = index;
                      },
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    margin: const EdgeInsets.all(5),
                    width: 80,
                    height: 45,
                    decoration: BoxDecoration(
                      color: current == index ? Colors.white70 : Colors.white54,
                      borderRadius: current == index
                          ? BorderRadius.circular(15)
                          : BorderRadius.circular(10),
                      border: current == index
                          ? Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        items[index],
                        style: GoogleFonts.laila(
                            fontWeight: FontWeight.w500,
                            color:
                                current == index ? Colors.black : Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
