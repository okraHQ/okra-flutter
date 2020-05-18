
class Filter{

  Filter(String industryType, List<String> banks){
    this.industry_type = industryType;
    this.banks = banks;
  }

  // ignore: non_constant_identifier_names
  String industry_type;
  List<String> banks;

  Map<String, dynamic> toJson() {
    return {
      'industry_type': industry_type,
      'banks': banks
    };
  }

}

