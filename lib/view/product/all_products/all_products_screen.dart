import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanohealth_task/provider/product/product_service_provider.dart';
import 'package:nanohealth_task/service/product/product_service.dart';
import 'package:nanohealth_task/utils/loading/loading_screen.dart';
import 'package:nanohealth_task/view/product/all_products/product_card.dart';

class AllProductsScreen extends ConsumerStatefulWidget {
  const AllProductsScreen({super.key});

  @override
  ConsumerState<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends ConsumerState<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    final productService = ref.read(productServiceProvider);
    productService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productService = ref.watch(productServiceProvider);
    return productService.isLoading
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: const Color.fromRGBO(247, 248, 250, 1),
            bottomNavigationBar: bottomNav(),
            appBar: customAppBar(),
            body: body(productService));
  }

  body(ProductService productService) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: productService.products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ProductCard(product: productService.products[index]),
          );
        },
      ),
    );
  }

  bottomNav() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/home.png"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/cart.png"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/like.png"),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/images/user.png"),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  customAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(70.0), // here the desired height
      child: AppBar(
        title: Text(
          'All Products',
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
    );
  }
}
