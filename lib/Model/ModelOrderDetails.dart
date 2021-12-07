import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResOrderDetails extends BaseModel {
  int code;
  String message;
  OrderData orderData;

  ResOrderDetails({this.code, this.message, this.orderData});

  ResOrderDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    orderData =
        json['result'] != null ? new OrderData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.orderData != null) {
      data['result'] = this.orderData.toJson();
    }
    return data;
  }
}

class OrderData {
  String orderId;
  String shopId;
  String latitude;
  String longitude;
  String driverId;
  String isReviewed;
  String name;
  String bannerImage;
  String address;
  String customerName;
  String date;
  String totalPrice;
  String tipPrice;
  String discountPrice;
  String paymentType;
  String orderStatus;
  String deliveryAddress;
  String phone;
  String deliveryDate;
  String deliveryTime;
  List<Products> products;

  OrderData(
      {this.orderId,
      this.shopId,
      this.latitude,
      this.longitude,
      this.driverId,
      this.isReviewed,
      this.name,
      this.bannerImage,
      this.address,
      this.customerName,
      this.date,
      this.totalPrice,
      this.tipPrice,
      this.discountPrice,
      this.paymentType,
      this.orderStatus,
      this.deliveryAddress,
      this.phone,
      this.deliveryDate,
      this.deliveryTime,
      this.products});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    shopId = json['shop_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    driverId = json['driver_id'];
    isReviewed = json['isReviewed'];
    name = json['name'];
    bannerImage = json['banner_image'];
    address = json['address'];
    customerName = json['customer_name'];
    date = json['date'];
    totalPrice = json['total_price'];
    tipPrice = json['tip_price'];
    discountPrice = json['discount_price'];
    paymentType = json['payment_type'];
    orderStatus = json['order_status'];
    deliveryAddress = json['delivery_address'];
    phone = json['phone'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['shop_id'] = this.shopId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['driver_id'] = this.driverId;
    data['isReviewed'] = this.isReviewed;
    data['name'] = this.name;
    data['banner_image'] = this.bannerImage;
    data['address'] = this.address;
    data['customer_name'] = this.customerName;
    data['date'] = this.date;
    data['total_price'] = this.totalPrice;
    data['tip_price'] = this.tipPrice;
    data['discount_price'] = this.discountPrice;
    data['payment_type'] = this.paymentType;
    data['order_status'] = this.orderStatus;
    data['delivery_address'] = this.deliveryAddress;
    data['phone'] = this.phone;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String productName;
  String discountPrice;
  String productQuantity;
  String productId;
  String type;
  String discount;
  String unitPrice;
  String unit;
  String description;
  String image;

  Products(
      {this.productName,
      this.discountPrice,
      this.productQuantity,
      this.productId,
      this.type,
      this.discount,
      this.unitPrice,
      this.unit,
      this.description,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    discountPrice = json['discount_price'];
    productQuantity = json['product_quantity'];
    productId = json['product_id'];
    type = json['type'];
    discount = json['discount'];
    unitPrice = json['unit_price'];
    unit = json['unit'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['discount_price'] = this.discountPrice;
    data['product_quantity'] = this.productQuantity;
    data['product_id'] = this.productId;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['unit_price'] = this.unitPrice;
    data['unit'] = this.unit;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}