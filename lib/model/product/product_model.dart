import 'package:nanohealth_task/model/product/rating_model.dart';

class ProductModel {
  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.category,
      required this.image,
      required this.rating,
      required this.description});

  int? id;
  String? title;
  dynamic price;
  String? description;
  String? category;
  String? image;
  RatingModel rating;
}
