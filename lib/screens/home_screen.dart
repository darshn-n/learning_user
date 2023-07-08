// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsss_learning/models/article_model.dart';
import 'package:gsss_learning/widgets/custom_tag.dart';
import 'package:gsss_learning/widgets/image_container.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home-screen";

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _NewsOfTheDay(
            article: Article(
              id: '2',
              title: 'Geetha Shishu Shikshana Sangha(R)',
              subtitle:
                  'Aliquam laoreet ante non diam suscipit accumsan. Sed vel consequat leo, non suscipit odio. Aliquam turpis',
              body:
                  'Nullam sed augue a turpis bibendum cursus. Suspendisse potenti. Praesent mi ligula, mollis quis elit ac, eleifend vestibulum ex. Nullam quis sodales tellus. Integer feugiat dolor et nisi semper luctus. Nulla egestas nec augue facilisis pharetra. Sed ultricies nibh a odio aliquam, eu imperdiet purus aliquam. Donec id ante nec',
              author: 'Anna G. Wright',
              authorImageUrl: "assets/college.png",
              category: 'Politics',
              views: 1204,
              imageUrl: "assets/college.png",
              createdAt: DateTime.now().subtract(
                const Duration(
                  hours: 6,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Geetha Shishu Shikshana Sangha(R), Mysore It was the vision of Smt. Rukmini Bai Pandit in the 1940s to inculcate the essence of the Bhagavadgita in children to give them a basic start to education. GSSS is a nonprofit organization and managed by the WHO'S WHO of Mysore. The dedication and loyalty of its members to the cause of education has helped the institution grow by leaps and bounds within a short period of time.",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Geetha Shishu Shikshana Sangha (R) was founded by Prof. B.S.Pandit who retired as Professor, from SJCE, Mysore & a true visionary. As an academician, who worked for more than 4 decades in the line of technical education, started this first women's engineering college in Karnataka. With his leadership qualities, determination & dedication to serve for the cause of education, this institute is constantly upgrading its quality, infrastructure and other various developments according to present day needs.",
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewsOfTheDay extends StatelessWidget {
  const _NewsOfTheDay({
    Key? key,
    required this.article,
  }) : super(key: key);

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      imageUrl: article.imageUrl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150),
            children: [
              Text(
                'About GSSS',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            article.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                  color: Colors.black54,
                ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}
