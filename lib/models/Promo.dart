class Promo {
  String id;
  String name;
  String description;
  List<String> claimBy;

  Promo({this.name, this.description, this.claimBy});

  Promo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    claimBy = json['claim_by'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['claim_by'] = this.claimBy;
    return data;
  }
}