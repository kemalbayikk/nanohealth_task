import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanohealth_task/model/product/product_model.dart';
import 'package:nanohealth_task/provider/product/product_service_provider.dart';
import 'package:nanohealth_task/utils/constants/constants.dart';
import 'package:nanohealth_task/view/product/product_detail/product_detail_screen.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel? product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productService = ref.watch(productServiceProvider);
    return GestureDetector(
      onTap: () {
        productService.setSelectedProduct(product!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductDetailScreen()),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 247,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Stack(
                children: [
                  Center(child: Image.network(product!.image!)),
                  priceRatingRow(context),
                ],
              ),
            ),
            Constants.fixedBoxxSmall,
            Text(
              product!.title!,
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Constants.productTextColor)),
            ),
            Constants.fixedBoxxSmall,
            Text(
              product!.description!,
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      fontSize: 10, color: Constants.productTextColor)),
            )
          ],
        ),
      ),
    );
  }

  priceRatingRow(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width - 48,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "${product!.price} AED",
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                      color: Constants.secondColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ),
            RatingBar.builder(
              initialRating: product!.rating.rate.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            )
          ],
        ),
      ),
    );
  }
}
