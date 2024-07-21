import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:wac_task/home/model/home_model_class.dart';
import 'package:wac_task/home/repo/home_screen_local_db_services.dart';
import 'package:wac_task/home/repo/home_screen_remote_services.dart';
import 'package:wac_task/core/failure/api_failure_handler.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isLoading = false;

  List<ProductDetails> _data = [];

  ApiFailureHandler? _apiFailureHandler;

  bool get isLoading => _isLoading;

  List<ProductDetails> get products => _data;

  ApiFailureHandler? get apiFailureHandler => _apiFailureHandler;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  setProducts(List<ProductDetails> value) {
    _data = value;
    notifyListeners();
  }

  setApiFailureHandler(ApiFailureHandler? value) {
    _apiFailureHandler = value;
    notifyListeners();
  }

  void getHomeData() async {
    setIsLoading(true);

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult[0] == ConnectivityResult.none) {
      // No internet connection
      // call local db service to get data
      HomeScreenLocalDbServices.getHomeData().then((value) {
        if (value.isEmpty) {
          setApiFailureHandler(const ApiFailureHandler(
              message: 'No Data Found Check Your Internet Connection'));
          setIsLoading(false);
          return;
        }

        setProducts(value);
        setIsLoading(false);
        return;
      });
      return;
    }

    final response = await HomeScreenRemoteServices.getHomeData();

    response.fold(
      (failure) {
        setApiFailureHandler(failure);
        setIsLoading(false);
      },
      (data) {
        setProducts(data);
        setIsLoading(false);
      },
    );
  }
}
