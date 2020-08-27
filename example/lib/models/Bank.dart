class Bank{

  Bank();

  String id;
  String name;
  String slug;

  factory Bank.fromJson(dynamic json) {
    Bank bank = new Bank();
    bank.id = json["id"];
    bank.name = json["name"];
    bank.slug = json["slug"];
    return bank;
  }
}