class FavouriteModel
{
  bool ?status;
  String? message;
  Data ?data;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data
{
  int? currentPage;
  List<FavouritesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  void nextPageUrl;
  String? path;
  int? perPage;
  void prevPageUrl;
  int ?to;
  int ?total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavouritesData>[];
      json['data'].forEach((v) {
        data!.add(FavouritesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = null;
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = null;
    to = json['to'];
    total = json['total'];
  }
}

class FavouritesData
{
  int? id;
  Product? product;

  FavouritesData({int? id, Product? product}) {
    id = id!;
    product = product!;
  }

  FavouritesData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product
{
  int id;
  int? price;
  int? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;



  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        oldPrice = json['old_price'],
        discount = json['discount'],
        image = json['image'],
        name = json['name'],
        description = json['description'];

}