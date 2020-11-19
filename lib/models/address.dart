class Address {
  final int id;
  final String countryName;
  final String countryAbbr;
  final String firstName;
  final String lastName;
  final String companyName;
  final String address1;
  final String address2;
  final String city;
  final String stateName;
  final String pincode;
  final String mobile;
  final bool isDefault;

  Address(
      {this.id,
      this.countryName,
      this.countryAbbr,
      this.firstName,
      this.lastName,
      this.companyName,
      this.address1,
      this.address2,
      this.city,
      this.stateName,
      this.pincode,
      this.mobile,
      this.isDefault});
}
