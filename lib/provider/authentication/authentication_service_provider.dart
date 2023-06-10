import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanohealth_task/service/authentication/authentication_service.dart';

final authenticationServiceProvider =
    ChangeNotifierProvider<AuthenticationService>(
        (ref) => AuthenticationService());
