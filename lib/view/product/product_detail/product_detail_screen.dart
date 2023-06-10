import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanohealth_task/provider/product/product_screen_provider.dart';
import 'package:nanohealth_task/provider/product/product_service_provider.dart';
import 'package:nanohealth_task/service/product/product_service.dart';
import 'package:nanohealth_task/utils/constants/constants.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key});

  void updateBottomSheetState(WidgetRef ref, bool expanded) {
    ref.read(bottomSheetExpanded.notifier).state = expanded;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productService = ref.watch(productServiceProvider);
    final bottomSheetProvider = ref.watch(bottomSheetExpanded);
    return Scaffold(
        backgroundColor: Colors.white,
        body: ExpandableBottomSheet(
          background: Stack(children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 48.0, right: 16.0, left: 16.0),
              child: Image.network(productService.selectedProduct!.image!),
            ),
            topBackButton(ref, context),
            topMenuButton(ref, context)
          ]),
          persistentHeader: persistentHeaderContainer(
              context, productService, bottomSheetProvider),
          onIsExtendedCallback: () {
            updateBottomSheetState(ref, true);
          },
          onIsContractedCallback: () {
            updateBottomSheetState(ref, false);
          },
          expandableContent: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                height: 110,
                color: Colors.white,
                child: Center(child: reviewSection(context, productService))),
          ),
        ));
  }

  persistentHeaderContainer(BuildContext context, ProductService productService,
      bool bottomSheetState) {
    return Container(
      height:
          20 * (productService.selectedProduct!.description!.length / 77) + 202,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.white.withOpacity(0.6),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                      "${productService.selectedProduct!.price.toString()} AED",
                      style: GoogleFonts.openSans(
                          textStyle: const TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Constants.fixedBoxxSmall,
                  bottomSheetState
                      ? Image.asset("assets/images/down_arrow.png")
                      : Image.asset("assets/images/up_arrow.png"),
                  Constants.fixedBoxxSmall,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 0.0), //(x,y)
                                blurRadius: 20.0,
                              ),
                            ],
                          ),
                          width: 55,
                          height: 55,
                          child: Image.asset("assets/images/share.png"),
                        ),
                      ),
                      orderButton(context),
                    ],
                  ),
                  Constants.fixedBoxxSmall,
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Description",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Constants.productTextColor))),
                    ),
                  ),
                  Constants.fixedBoxxSmall,
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      height: 20 *
                          (productService.selectedProduct!.description!.length /
                              77),
                      child: Text(
                        productService.selectedProduct!.description!,
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 10,
                                color: Constants.productTextColor)),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  orderButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(
              MediaQuery.of(context).size.width * 0.69, 55)), // Same with Figma
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(62.0),
          )),
          backgroundColor:
              MaterialStateProperty.all<Color>(Constants.firstColor),
        ),
        child: Text(
          "Order Now",
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(color: Colors.white, fontSize: 12)),
        ));
  }

  reviewSection(BuildContext context, ProductService productService) {
    return Container(
      height: 98,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Constants.productRewievBoxColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Reviews (${productService.selectedProduct!.rating.count})",
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "${productService.selectedProduct!.rating.rate}",
                  style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                ),
                RatingBar.builder(
                  initialRating:
                      productService.selectedProduct!.rating.rate.toDouble(),
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
            )
          ],
        ),
      ),
    );
  }

  topBackButton(WidgetRef ref, BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: GestureDetector(
        onTap: () {
          updateBottomSheetState(ref, false);
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Constants.firstColor, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 40,
          height: 40,
          child: Image.asset("assets/images/back_icon.png"),
        ),
      ),
    );
  }

  topMenuButton(WidgetRef ref, BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Constants.firstColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 40,
        height: 40,
        child: Image.asset("assets/images/menu.png"),
      ),
    );
  }
}
