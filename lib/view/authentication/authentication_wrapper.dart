import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanohealth_task/provider/authentication/authentication_service_provider.dart';
import 'package:nanohealth_task/utils/loading/loading_screen.dart';
import 'package:nanohealth_task/view/authentication/login_screen.dart';
import 'package:nanohealth_task/view/product/all_products/all_products_screen.dart';

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticationService = ref.watch(authenticationServiceProvider);
    if (authenticationService.authToken == null &&
        !authenticationService.isLoading) {
      return LoginScreen();
    } else if (authenticationService.authToken == null &&
        authenticationService.isLoading) {
      return const LoadingScreen();
    } else {
      return const AllProductsScreen();
    }
  }
}
