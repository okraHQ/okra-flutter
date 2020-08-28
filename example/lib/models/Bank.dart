class Bank{

  Bank();

  String id;
  String name;
  String slug;
  String primaryColor;
  String secondaryColor;

  factory Bank.fromJson(dynamic json) {
    Bank bank = new Bank();
    bank.id = json["id"];
    bank.name = json["name"];
    bank.slug = json["slug"];
    bank.primaryColor = json["primaryColor"];
    bank.secondaryColor = json["secondaryColor"];
    return bank;
  }
}