class CartItem {
  CartItem({
      this.nftStatus, 
      this.status, 
      this.addressAvailability, 
      this.couponMessage, 
      this.errorMessage, 
      this.productData, 
      this.subTotal, 
      this.subTotalFormat, 
      this.mrpTotal, 
      this.mrpTotalFormat, 
      this.discount, 
      this.discountFormat, 
      this.tax, 
      this.couponDis, 
      this.taxFormat, 
      this.shippingAndHandling, 
      this.mainWalletBalance, 
      this.walletInfo, 
      this.walletBalance, 
      this.walletBalanceFormat, 
      this.walletStatus, 
      this.offerPrice, 
      this.offerPriceFormat, 
      this.total, 
      this.isCouponApplied, 
      this.coupon, 
      this.cashbackMessage, 
      this.couponDiscount, 
      this.couponName, 
      this.totalFormat, 
      this.deliveryCharges, 
      this.delIsApplicable, 
      this.installationCharges, 
      this.insIsApplicable, 
      this.emiData, 
      this.emiStarted, 
      this.overallDiscount, 
      this.mrpabhi, 
      this.subabhi, 
      this.combodiscount, 
      this.isapply, 
      this.codavailabel,});

  CartItem.fromJson(dynamic json) {
    nftStatus = json['nftStatus'];
    status = json['status'];
    addressAvailability = json['address_Availability'];
    couponMessage = json['couponMessage'];
    errorMessage = json['errorMessage'];
    if (json['product_data'] != null) {
      productData = [];
      json['product_data'].forEach((v) {
        productData?.add(ProductData.fromJson(v));
      });
    }
    subTotal = json['sub_total'];
    subTotalFormat = json['sub_total_format'];
    mrpTotal = json['mrp_total'];
    mrpTotalFormat = json['mrp_total_format'];
    discount = json['discount'];
    discountFormat = json['discount_format'];
    tax = json['tax'];
    couponDis = json['coupon_dis'];
    taxFormat = json['tax_format'];
    shippingAndHandling = json['shipping_and_handling'];
    mainWalletBalance = json['main_wallet_balance'];
    walletInfo = json['wallet_info'];
    walletBalance = json['wallet_balance'];
    walletBalanceFormat = json['wallet_balance_format'];
    walletStatus = json['wallet_status'];
    offerPrice = json['offer_price'];
    offerPriceFormat = json['offer_price_format'];
    total = json['total'];
    isCouponApplied = json['is_coupon_applied'];
    coupon = json['coupon'];
    cashbackMessage = json['cashback_message'];
    couponDiscount = json['coupon_discount'];
    couponName = json['coupon_name'];
    totalFormat = json['total_format'];
    deliveryCharges = json['delivery_charges'];
    delIsApplicable = json['del_is_applicable'];
    installationCharges = json['installation_charges'];
    insIsApplicable = json['ins_is_applicable'];
    emiData = json['emi_data'] != null ? EmiData.fromJson(json['emi_data']) : null;
    emiStarted = json['emi_started'];
    overallDiscount = json['overall_discount'];
    mrpabhi = json['mrpabhi'];
    subabhi = json['subabhi'];
    combodiscount = json['combodiscount'];
    isapply = json['isapply'];
    codavailabel = json['codavailabel'];
  }
  dynamic nftStatus;
  String? status;
  num? addressAvailability;
  String? couponMessage;
  String? errorMessage;
  List<ProductData>? productData;
  num? subTotal;
  String? subTotalFormat;
  num? mrpTotal;
  String? mrpTotalFormat;
  num? discount;
  String? discountFormat;
  dynamic tax;
  String? couponDis;
  dynamic taxFormat;
  String? shippingAndHandling;
  dynamic mainWalletBalance;
  dynamic walletInfo;
  dynamic walletBalance;
  dynamic walletBalanceFormat;
  dynamic walletStatus;
  dynamic offerPrice;
  String? offerPriceFormat;
  num? total;
  bool? isCouponApplied;
  String? coupon;
  String? cashbackMessage;
  String? couponDiscount;
  String? couponName;
  String? totalFormat;
  String? deliveryCharges;
  num? delIsApplicable;
  String? installationCharges;
  num? insIsApplicable;
  EmiData? emiData;
  String? emiStarted;
  String? overallDiscount;
  num? mrpabhi;
  num? subabhi;
  num? combodiscount;
  bool? isapply;
  num? codavailabel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nftStatus'] = nftStatus;
    map['status'] = status;
    map['address_Availability'] = addressAvailability;
    map['couponMessage'] = couponMessage;
    map['errorMessage'] = errorMessage;
    if (productData != null) {
      map['product_data'] = productData?.map((v) => v.toJson()).toList();
    }
    map['sub_total'] = subTotal;
    map['sub_total_format'] = subTotalFormat;
    map['mrp_total'] = mrpTotal;
    map['mrp_total_format'] = mrpTotalFormat;
    map['discount'] = discount;
    map['discount_format'] = discountFormat;
    map['tax'] = tax;
    map['coupon_dis'] = couponDis;
    map['tax_format'] = taxFormat;
    map['shipping_and_handling'] = shippingAndHandling;
    map['main_wallet_balance'] = mainWalletBalance;
    map['wallet_info'] = walletInfo;
    map['wallet_balance'] = walletBalance;
    map['wallet_balance_format'] = walletBalanceFormat;
    map['wallet_status'] = walletStatus;
    map['offer_price'] = offerPrice;
    map['offer_price_format'] = offerPriceFormat;
    map['total'] = total;
    map['is_coupon_applied'] = isCouponApplied;
    map['coupon'] = coupon;
    map['cashback_message'] = cashbackMessage;
    map['coupon_discount'] = couponDiscount;
    map['coupon_name'] = couponName;
    map['total_format'] = totalFormat;
    map['delivery_charges'] = deliveryCharges;
    map['del_is_applicable'] = delIsApplicable;
    map['installation_charges'] = installationCharges;
    map['ins_is_applicable'] = insIsApplicable;
    if (emiData != null) {
      map['emi_data'] = emiData?.toJson();
    }
    map['emi_started'] = emiStarted;
    map['overall_discount'] = overallDiscount;
    map['mrpabhi'] = mrpabhi;
    map['subabhi'] = subabhi;
    map['combodiscount'] = combodiscount;
    map['isapply'] = isapply;
    map['codavailabel'] = codavailabel;
    return map;
  }

}

class EmiData {
  EmiData({
      this.hDFCBank, 
      this.iCICIBank, 
      this.aXISBank, 
      this.kotakBank, 
      this.yesBank, 
      this.standardCharteredBank, 
      this.bankOfBaroda, 
      this.indusIndBank, 
      this.rbl,});

  EmiData.fromJson(dynamic json) {
    if (json['HDFC Bank'] != null) {
      hDFCBank = [];
      json['HDFC Bank'].forEach((v) {
        hDFCBank?.add(HdfcBank.fromJson(v));
      });
    }
    if (json['ICICI Bank'] != null) {
      iCICIBank = [];
      json['ICICI Bank'].forEach((v) {
        iCICIBank?.add(IciciBank.fromJson(v));
      });
    }
    if (json['AXIS Bank'] != null) {
      aXISBank = [];
      json['AXIS Bank'].forEach((v) {
        aXISBank?.add(AxisBank.fromJson(v));
      });
    }
    if (json['Kotak Bank'] != null) {
      kotakBank = [];
      json['Kotak Bank'].forEach((v) {
        kotakBank?.add(KotakBank.fromJson(v));
      });
    }
    if (json['Yes Bank'] != null) {
      yesBank = [];
      json['Yes Bank'].forEach((v) {
        yesBank?.add(YesBank.fromJson(v));
      });
    }
    if (json['Standard Chartered Bank'] != null) {
      standardCharteredBank = [];
      json['Standard Chartered Bank'].forEach((v) {
        standardCharteredBank?.add(StandardCharteredBank.fromJson(v));
      });
    }
    if (json['Bank Of Baroda'] != null) {
      bankOfBaroda = [];
      json['Bank Of Baroda'].forEach((v) {
        bankOfBaroda?.add(BankOfBaroda.fromJson(v));
      });
    }
    if (json['IndusInd Bank'] != null) {
      indusIndBank = [];
      json['IndusInd Bank'].forEach((v) {
        indusIndBank?.add(IndusIndBank.fromJson(v));
      });
    }
    if (json['RBL'] != null) {
      rbl = [];
      json['RBL'].forEach((v) {
        rbl?.add(Rbl.fromJson(v));
      });
    }
  }
  List<HdfcBank>? hDFCBank;
  List<IciciBank>? iCICIBank;
  List<AxisBank>? aXISBank;
  List<KotakBank>? kotakBank;
  List<YesBank>? yesBank;
  List<StandardCharteredBank>? standardCharteredBank;
  List<BankOfBaroda>? bankOfBaroda;
  List<IndusIndBank>? indusIndBank;
  List<Rbl>? rbl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (hDFCBank != null) {
      map['HDFC Bank'] = hDFCBank?.map((v) => v.toJson()).toList();
    }
    if (iCICIBank != null) {
      map['ICICI Bank'] = iCICIBank?.map((v) => v.toJson()).toList();
    }
    if (aXISBank != null) {
      map['AXIS Bank'] = aXISBank?.map((v) => v.toJson()).toList();
    }
    if (kotakBank != null) {
      map['Kotak Bank'] = kotakBank?.map((v) => v.toJson()).toList();
    }
    if (yesBank != null) {
      map['Yes Bank'] = yesBank?.map((v) => v.toJson()).toList();
    }
    if (standardCharteredBank != null) {
      map['Standard Chartered Bank'] = standardCharteredBank?.map((v) => v.toJson()).toList();
    }
    if (bankOfBaroda != null) {
      map['Bank Of Baroda'] = bankOfBaroda?.map((v) => v.toJson()).toList();
    }
    if (indusIndBank != null) {
      map['IndusInd Bank'] = indusIndBank?.map((v) => v.toJson()).toList();
    }
    if (rbl != null) {
      map['RBL'] = rbl?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Rbl {
  Rbl({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  Rbl.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class IndusIndBank {
  IndusIndBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  IndusIndBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class BankOfBaroda {
  BankOfBaroda({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  BankOfBaroda.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class StandardCharteredBank {
  StandardCharteredBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  StandardCharteredBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class YesBank {
  YesBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  YesBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class KotakBank {
  KotakBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  KotakBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class AxisBank {
  AxisBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  AxisBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class IciciBank {
  IciciBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  IciciBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class HdfcBank {
  HdfcBank({
      this.bank, 
      this.months, 
      this.rs, 
      this.interest,});

  HdfcBank.fromJson(dynamic json) {
    bank = json['bank'];
    months = json['months'];
    rs = json['Rs'];
    interest = json['Interest'];
  }
  String? bank;
  String? months;
  String? rs;
  String? interest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank'] = bank;
    map['months'] = months;
    map['Rs'] = rs;
    map['Interest'] = interest;
    return map;
  }

}

class ProductData {
  ProductData({
      this.key, 
      this.fabricConcept, 
      this.productId, 
      this.codAvailable, 
      this.materialType, 
      this.name, 
      this.stockStatus, 
      this.model, 
      this.sku, 
      this.image, 
      this.thumb, 
      this.option, 
      this.newOptions, 
      this.quantity, 
      this.price, 
      this.priceNum, 
      this.special, 
      this.specialNum, 
      this.totalSpecialNum, 
      this.ourPrice, 
      this.ourpricewf, 
      this.threePriceStatus, 
      this.cashbakCoupon, 
      this.installation, 
      this.deliveryCharges, 
      this.productDiscount, 
      this.pDisc, 
      this.youSaved, 
      this.codStatus, 
      this.savedMsg, 
      this.installReqCharge,});

  ProductData.fromJson(dynamic json) {
    key = json['key'];
    fabricConcept = json['fabric_concept'];
    productId = json['product_id'];
    codAvailable = json['cod_available'];
    materialType = json['material_type'];
    name = json['name'];
    stockStatus = json['stock_status'];
    model = json['model'];
    sku = json['sku'];
    image = json['image'];
    thumb = json['thumb'];
    // if (json['option'] != null) {
    //   option = [];
    //   json['option'].forEach((v) {
    //     option?.add(Dynamic.fromJson(v));
    //   });
    // }
    newOptions = json['new_options'];
    quantity = json['quantity'];
    price = json['price'];
    priceNum = json['price_num'];
    special = json['special'];
    specialNum = json['special_num'];
    totalSpecialNum = json['total_special_num'];
    ourPrice = json['ourPrice'];
    ourpricewf = json['ourpricewf'];
    threePriceStatus = json['three_price_status'];
    cashbakCoupon = json['cashbak_coupon'];
    installation = json['installation'];
    deliveryCharges = json['delivery_charges'];
    productDiscount = json['product_discount'];
    pDisc = json['p_disc'];
    youSaved = json['youSaved'];
    codStatus = json['cod_status'];
    savedMsg = json['savedMsg'];
    installReqCharge = json['install_req_charge'];
  }
  num? key;
  num? fabricConcept;
  String? productId;
  String? codAvailable;
  String? materialType;
  String? name;
  num? stockStatus;
  String? model;
  String? sku;
  String? image;
  String? thumb;
  List<dynamic>? option;
  bool? newOptions;
  num? quantity;
  String? price;
  dynamic priceNum;
  String? special;
  num? specialNum;
  num? totalSpecialNum;
  String? ourPrice;
  num? ourpricewf;
  num? threePriceStatus;
  num? cashbakCoupon;
  String? installation;
  String? deliveryCharges;
  String? productDiscount;
  String? pDisc;
  String? youSaved;
  num? codStatus;
  String? savedMsg;
  num? installReqCharge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['fabric_concept'] = fabricConcept;
    map['product_id'] = productId;
    map['cod_available'] = codAvailable;
    map['material_type'] = materialType;
    map['name'] = name;
    map['stock_status'] = stockStatus;
    map['model'] = model;
    map['sku'] = sku;
    map['image'] = image;
    map['thumb'] = thumb;
    if (option != null) {
      map['option'] = option?.map((v) => v.toJson()).toList();
    }
    map['new_options'] = newOptions;
    map['quantity'] = quantity;
    map['price'] = price;
    map['price_num'] = priceNum;
    map['special'] = special;
    map['special_num'] = specialNum;
    map['total_special_num'] = totalSpecialNum;
    map['ourPrice'] = ourPrice;
    map['ourpricewf'] = ourpricewf;
    map['three_price_status'] = threePriceStatus;
    map['cashbak_coupon'] = cashbakCoupon;
    map['installation'] = installation;
    map['delivery_charges'] = deliveryCharges;
    map['product_discount'] = productDiscount;
    map['p_disc'] = pDisc;
    map['youSaved'] = youSaved;
    map['cod_status'] = codStatus;
    map['savedMsg'] = savedMsg;
    map['install_req_charge'] = installReqCharge;
    return map;
  }

}