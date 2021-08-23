class Item {
  String? image;
  String? itemName;
  String? itemCode;

  Item({
    this.image,
    this.itemName,
    this.itemCode,
  });

  Item.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    itemName = json['itemName'];
    itemCode = json['itemCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['itemName'] = this.itemName;
    data['itemCode'] = this.itemCode;
    return data;
  }
}
