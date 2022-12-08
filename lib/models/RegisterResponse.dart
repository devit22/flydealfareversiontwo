class RegisterResponse {

  String? data;
  String? error;
  String? status;

  RegisterResponse({
      this.data, 
      this.error, 
      this.status,});

  RegisterResponse.fromJson(dynamic json) {
    data = json['data'];
    error = json['error'];
    status = json['status'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = data;
    map['error'] = error;
    map['status'] = status;
    return map;
  }

}