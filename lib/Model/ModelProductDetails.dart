import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

// class ResProductDetails extends BaseModel {
//   int code;
//   String message;
//   List<Result> result;

//   ResProductDetails({this.code, this.message, this.result});

//   ResProductDetails.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     if (json['result'] != null) {
//       result = [];
//       json['result'].forEach((v) {
//         result.add(new Result.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.result != null) {
//       data['result'] = this.result.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Result {
//   String id;
//   String name;
//   String description;
//   String status;
//   String shopName;
//   List<String> image;
//   List<MeasurementUnit> measurement;
//   String discount;
//   String latitude;
//   String longitude;
//   String discountType;
//   String shopAddress;
//   String shopCountry;
//   List<GetSimilarProducst> getSimilarProducst;

//   Result(
//       {this.id,
//       this.name,
//       this.description,
//       this.status,
//       this.shopName,
//       this.image,
//       this.measurement,
//       this.discount,
//       this.latitude,
//       this.longitude,
//       this.discountType,
//       this.shopAddress,
//       this.shopCountry,
//       this.getSimilarProducst});

//   Result.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     status = json['status'];
//     shopName = json['shop_name'];
//     image = json['image'].cast<String>();
//     if (json['measurement'] != null) {
//       measurement = [];
//       json['measurement'].forEach((v) {
//         measurement.add(new MeasurementUnit.fromJson(v));
//       });
//     }
//     discount = json['discount'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     discountType = json['discount_type'];
//     shopAddress = json['shop_address'];
//     shopCountry = json['shop_country'];
//     if (json['getSimilarProducst'] != null) {
//       getSimilarProducst = [];
//       json['getSimilarProducst'].forEach((v) {
//         getSimilarProducst.add(new GetSimilarProducst.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['status'] = this.status;
//     data['shop_name'] = this.shopName;
//     data['image'] = this.image;
//     if (this.measurement != null) {
//       data['measurement'] = this.measurement.map((v) => v.toJson()).toList();
//     }
//     data['discount'] = this.discount;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['discount_type'] = this.discountType;
//     data['shop_address'] = this.shopAddress;
//     data['shop_country'] = this.shopCountry;
//     if (this.getSimilarProducst != null) {
//       data['getSimilarProducst'] =
//           this.getSimilarProducst.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Measurement {
//   String unit;
//   String unitPrice;
//   String quantity;
//   String expiryDate;
//   String isAdded;
//   String totalQuantity;
//   String cartId;
//   String isCart;

//   Measurement(
//       {this.unit,
//       this.unitPrice,
//       this.quantity,
//       this.expiryDate,
//       this.isAdded,
//       this.totalQuantity,
//       this.cartId,
//       this.isCart});

//   Measurement.fromJson(Map<String, dynamic> json) {
//     unit = json['unit'];
//     unitPrice = json['unit_price'];
//     quantity = json['quantity'];
//     expiryDate = json['expiry_date'];
//     isAdded = json['is_added'];
//     totalQuantity = json['total_quantity'];
//     cartId = json['cart_id'];
//     isCart = json['is_cart'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['unit'] = this.unit;
//     data['unit_price'] = this.unitPrice;
//     data['quantity'] = this.quantity;
//     data['expiry_date'] = this.expiryDate;
//     data['is_added'] = this.isAdded;
//     data['total_quantity'] = this.totalQuantity;
//     data['cart_id'] = this.cartId;
//     data['is_cart'] = this.isCart;
//     return data;
//   }
// }

// class GetSimilarProducst {
//   String id;
//   String name;
//   String image;
//   List<Measurement> measurement;
//   String discount;
//   String discountType;

//   GetSimilarProducst(
//       {this.id,
//       this.name,
//       this.image,
//       this.measurement,
//       this.discount,
//       this.discountType});

//   GetSimilarProducst.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     if (json['measurement'] != null) {
//       measurement = [];
//       json['measurement'].forEach((v) {
//         measurement.add(new Measurement.fromJson(v));
//       });
//     }
//     discount = json['discount'];
//     discountType = json['discount_type'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     if (this.measurement != null) {
//       data['measurement'] = this.measurement.map((v) => v.toJson()).toList();
//     }
//     data['discount'] = this.discount;
//     data['discount_type'] = this.discountType;
//     return data;
//   }
// }

// class MeasurementUnit {
//   String unit;
//   String unitPrice;
//   String quantity;
//   String expiryDate;

//   MeasurementUnit({this.unit, this.unitPrice, this.quantity, this.expiryDate});

//   MeasurementUnit.fromJson(Map<String, dynamic> json) {
//     unit = json['unit'];
//     unitPrice = json['unit_price'];
//     quantity = json['quantity'];
//     expiryDate = json['expiry_date'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['unit'] = this.unit;
//     data['unit_price'] = this.unitPrice;
//     data['quantity'] = this.quantity;
//     data['expiry_date'] = this.expiryDate;
//     return data;
//   }
// }

////////NEW ONE///////
///
///
class ResProductDetails extends BaseModel {
  int code;
  String message;
  Result result;

  ResProductDetails({this.code, this.message, this.result});

  ResProductDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String id;
  String shopId;
  String status;
  String name;
  String description;
  String shopName;
  List<String> image;
  List<Measurement> measurement;
  String discount;
  String latitude;
  String longitude;
  String discountType;
  String shopAddress;
  String shopCountry;
  List<GetSimilarProducst> getSimilarProducst;

  Result(
      {this.id,
      this.shopId,
      this.status,
      this.name,
      this.description,
      this.shopName,
      this.image,
      this.measurement,
      this.discount,
      this.latitude,
      this.longitude,
      this.discountType,
      this.shopAddress,
      this.shopCountry,
      this.getSimilarProducst});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    status = json['status'];
    name = json['name'];
    description = json['description'];
    shopName = json['shop_name'];
    image = json['image'].cast<String>();
    if (json['measurement'] != null) {
      measurement = [];
      json['measurement'].forEach((v) {
        measurement.add(new Measurement.fromJson(v));
      });
    }
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    discountType = json['discount_type'];
    shopAddress = json['shop_address'];
    shopCountry = json['shop_country'];
    if (json['getSimilarProducst'] != null) {
      getSimilarProducst = [];
      json['getSimilarProducst'].forEach((v) {
        getSimilarProducst.add(new GetSimilarProducst.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_id'] = this.shopId;
    data['status'] = this.status;
    data['name'] = this.name;
    data['description'] = this.description;
    data['shop_name'] = this.shopName;
    data['image'] = this.image;
    if (this.measurement != null) {
      data['measurement'] = this.measurement.map((v) => v.toJson()).toList();
    }
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['discount_type'] = this.discountType;
    data['shop_address'] = this.shopAddress;
    data['shop_country'] = this.shopCountry;
    if (this.getSimilarProducst != null) {
      data['getSimilarProducst'] =
          this.getSimilarProducst.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Measurement {
  String unit;
  String unitPrice;
  String quantity;
  String expiryDate;
  String isAdded;
  String totalQuantity;
  String cartId;

  Measurement(
      {this.unit,
      this.unitPrice,
      this.quantity,
      this.expiryDate,
      this.isAdded,
      this.totalQuantity,
      this.cartId});

  Measurement.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    expiryDate = json['expiry_date'];
    isAdded = json['is_added'];
    totalQuantity = json['total_quantity'];
    cartId = json['cart_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['expiry_date'] = this.expiryDate;
    data['is_added'] = this.isAdded;
    data['total_quantity'] = this.totalQuantity;
    data['cart_id'] = this.cartId;
    return data;
  }
}

class GetSimilarProducst {
  String id;
  String name;
  String image;
  List<Measurement> measurement;
  String discount;
  String discountType;

  GetSimilarProducst(
      {this.id,
      this.name,
      this.image,
      this.measurement,
      this.discount,
      this.discountType});

  GetSimilarProducst.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['measurement'] != null) {
      measurement = [];
      json['measurement'].forEach((v) {
        measurement.add(new Measurement.fromJson(v));
      });
    }
    discount = json['discount'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    if (this.measurement != null) {
      data['measurement'] = this.measurement.map((v) => v.toJson()).toList();
    }
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    return data;
  }
}
