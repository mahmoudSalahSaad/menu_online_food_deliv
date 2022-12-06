class Setting {
  int id;
  String androidBuildNumber;
  String appleBuildNumber;
  String googlePlayLink;
  String appStoreLink;

  Setting(
      {this.id,
      this.androidBuildNumber,
      this.appleBuildNumber,
      this.googlePlayLink,
      this.appStoreLink});

  Setting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    androidBuildNumber = json['android_build_number'];
    appleBuildNumber = json['apple_build_number'];
    googlePlayLink = json['googlePlayLink'];
    appStoreLink = json['appStoreLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['android_build_number'] = this.androidBuildNumber;
    data['apple_build_number'] = this.appleBuildNumber;
    data['googlePlayLink'] = this.googlePlayLink;
    data['appStoreLink'] = this.appStoreLink;
    return data;
  }
}
