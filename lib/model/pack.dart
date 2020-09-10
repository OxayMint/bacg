class Pack {
  Pack(
      {this.id,
      this.name,
      this.callCount,
      this.duration,
      this.priceAzn,
      this.priceUsd});
  int id;
  String priceUsd;
  String priceAzn;
  String name;
  int callCount;
  int duration;

  String getPrice(String forLang) {
    return forLang == "eng" ? "\$$priceUsd" : "$priceAzn AZN";
  }

  factory Pack.fromJson(Map<String, dynamic> json) {
    return Pack(
      id: json['id'],
      name: json['name'],
      callCount: json['call_limit'],
      priceAzn: json['price_azn'],
      priceUsd: json['price_usd'],
      duration: json['life_days'],
    );
  }
}
