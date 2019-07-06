import 'package:e_cart_app/Core/Services/ProductsRepository.dart';
import 'package:e_cart_app/Core/ViewModel/CartViewModel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => CartViewModel());
  locator.registerLazySingleton(() => ProductsRepository());
}