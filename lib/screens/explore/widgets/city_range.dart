import 'package:city_guide/screens/explore/widgets/dot_indicator.dart';
import 'package:flutter/material.dart';


class CityRange extends StatelessWidget {
  const CityRange({
    super.key,
    this.priceRange = "\$\$",
    required this.foodType,
  });

  final String priceRange;
  final List<String> foodType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(priceRange, style: Theme.of(context).textTheme.bodyMedium),
        ...List.generate(
          foodType.length,
          (index) => Row(
            children: [
              buildSmallDot(),
              Text(foodType[index],
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildSmallDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SmallDot(),
    );
  }
}