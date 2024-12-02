import 'package:city_guide/screens/explore/widgets/dot_indicator.dart';
import 'package:flutter/material.dart';


class CityInfoMediumCard extends StatelessWidget {
  const CityInfoMediumCard({
    super.key,
    required this.image,
    required this.name,
    required this.location,
    required this.rating,
    required this.delivertTime,
    required this.press,
  });

  final String image, name, location;
  final double rating;
  final int delivertTime;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              location,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Rating(rating: rating),
                Text(
                  "$delivertTime min",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: const Color(0xFF010F07).withOpacity(0.74)),
                ),
                const SmallDot(),
                Text(
                  "Free delivery",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: const Color(0xFF010F07).withOpacity(0.74)),
                )
              ],
            )
          ],
        ),
      ),
      ),
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: const BoxDecoration(
        color: Color(0xFF22A45D),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        rating.toString(),
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white),
      ),
    );
  }
}