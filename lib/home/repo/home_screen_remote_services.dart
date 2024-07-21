import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:wac_task/home/model/home_model_class.dart';
import 'package:wac_task/core/failure/api_failure_handler.dart';
import 'package:http/http.dart' as http;
import 'package:wac_task/home/repo/home_screen_local_db_services.dart';

///[HomeScreenRemoteServices] is a class that is used to fetch data from the remote server.
///[getHomeData] is a method that is used to fetch data from the remote server.
///[getHomeData] returns a [Future] of [Either] type which is a generic class.
///[Either] is a class that is used to return two types of data.
///[ApiFailureHandler] is a class that is used to handle the failure of the API.
///[List<ProductDetails>] is a class that is used to store the data of the product details.
class HomeScreenRemoteServices {
  static Future<Either<ApiFailureHandler, List<ProductDetails>>>
      getHomeData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://64bfc2a60d8e251fd111630f.mockapi.io/api/Todo',
        ),
      );

      if (response.statusCode == 200) {
        final List<ProductDetails> productDetails =
            productDetailsFromJson(response.body);

        debugPrint('productDetails: $productDetails');

        await HomeScreenLocalDbServices.storeHomeData(productDetails);

        return Right(productDetails);
      } else {
        return const Left(
          ApiFailureHandler(
            message: 'Failed to load data',
          ),
        );
      }
    } catch (e) {
      // Handle the exception based on the type of exception
      if (e is TimeoutException) {
        return const Left(
          ApiFailureHandler(
            message: 'Timeout!! Try again later',
          ),
        );
      } else if (e is FormatException) {
        return const Left(
          ApiFailureHandler(
            message: 'Format Exception',
          ),
        );
      } else if (e is SocketException) {
        return const Left(
          ApiFailureHandler(
            message: 'Check your internet connection',
          ),
        );
      }
      if (e is HttpException) {
        return const Left(
          ApiFailureHandler(
            message: 'Check your internet connection',
          ),
        );
      } else {
        return const Left(
          ApiFailureHandler(
            message: 'Something went wrong try again later',
          ),
        );
      }
    }
  }
}
