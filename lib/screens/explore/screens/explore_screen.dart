import 'package:city_guide/screens/explore/widgets/city_info_card.dart';
import 'package:city_guide/screens/explore/widgets/dot_indicator.dart';
import 'package:city_guide/screens/explore/widgets/medium_card_list.dart';
import 'package:city_guide/screens/home/common_widgets/search_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/big_card_image_slide.dart';
import '../data/explore_data_list.dart';

class NewExplore extends StatelessWidget {
  const NewExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: const SizedBox(),
        title: const Column(
          children: [
             SizedBox(height: 20),
              SearchComponent(),
             SizedBox(height: 20),
          ],
        ),
        actions: [
          
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Most visited cities', 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
              ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BigCardImageSlide(
                  images: demoBigImages,
                  cityNames: cityNames,
                  visits: visits,
                ),
              ),
              const SizedBox(height: 32),
              SectionTitle(
                title: "Featured Partners",
                press: () {},
              ),
              const SizedBox(height: 16),
              const MediumCardList(),
              const SizedBox(height: 20),
              // Banner
              const PromotionBanner(),
              const SizedBox(height: 20),
              SectionTitle(
                title: "Best Pick",
                press: () {},
              ),
              const SizedBox(height: 16),
              const MediumCardList(),
              const SizedBox(height: 20),
              SectionTitle(title: "All Restaurants", press: () {}),
              const SizedBox(height: 16),

              // Demo list of Big Cards
              ...List.generate(
                // For demo we use 4 items
                3,
                (index) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: CityInfoCard(
                    // Images are List<String>
                    images: demoBigImages..shuffle(),
                    name: "McDonald's",
                    rating: 4.3,
                    numOfRating: 200,
                    deliveryTime: 25,
                    foodType: const ["Chinese", "American", "Deshi food"],
                    press: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PromotionBanner extends StatefulWidget {
  const PromotionBanner({super.key});

  @override
  State<PromotionBanner> createState() => _PromotionBannerState();
}

class _PromotionBannerState extends State<PromotionBanner> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 1), () {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: isLoading
          ? const AspectRatio(
              aspectRatio: 1.97,
              child: ScaltonRoundedContainer(radious: 12),
            )
          : ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network("https://i.postimg.cc/PxZ4fxjc/Banner.png"),
            ),
    );
  }
}


class ScaltonLine extends StatelessWidget {
  const ScaltonLine({
    super.key,
    this.height = 15,
    this.width = double.infinity,
  });

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.black.withOpacity(0.08),
    );
  }
}

class MediumCardScalton extends StatelessWidget {
  const MediumCardScalton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.25,
            child: ScaltonRoundedContainer(),
          ),
          SizedBox(height: 16),
          ScaltonLine(width: 150),
          SizedBox(height: 16),
          ScaltonLine(),
          SizedBox(height: 16),
          ScaltonLine(),
        ],
      ),
    );
  }
}

class ScaltonRoundedContainer extends StatelessWidget {
  const ScaltonRoundedContainer({
    super.key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.radious = 10,
  });

  final double height, width, radious;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.08),
        borderRadius: BorderRadius.all(Radius.circular(radious)),
      ),
    );
  }
}







class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          GestureDetector(
            onTap: press,
            child: Text(
              "Clear all".toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF010F07).withOpacity(0.64),
              ),
            ),
          ),
        ],
      ),
    );
  }
}







class RatingWithCounter extends StatelessWidget {
  const RatingWithCounter({
    super.key,
    required this.rating,
    required this.numOfRating,
  });

  final double rating;
  final int numOfRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: Theme.of(context)
              .textTheme
              .labelSmall!
              .copyWith(color: const Color(0xFF010F07).withOpacity(0.74)),
        ),
        const SizedBox(width: 8),
        SvgPicture.string(
          ratingIconSvg,
          height: 20,
          width: 20,
          colorFilter: const ColorFilter.mode(
            Color(0xFF22A45D),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 8),
        Text("$numOfRating+ Ratings",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: const Color(0xFF010F07).withOpacity(0.74))),
      ],
    );
  }
}

