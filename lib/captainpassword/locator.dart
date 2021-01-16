import 'package:rehana/locator.dart';
import 'package:captainpassword/captainpassword/services/key.dart';
import 'package:captainpassword/captainpassword/services/auth.dart';

void setupLocator() {
  setupRehanaLocators();
  ServiceManager.registerLazySingleton(() => KeyService());
  ServiceManager.registerLazySingleton(() => AuthService());
}
