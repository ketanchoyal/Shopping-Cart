import 'package:e_cart_app/Core/repositories/ProductsRepository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ProductsRepository());
}