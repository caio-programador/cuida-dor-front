class PainResponse {
  final String? image;
  final double? meanBefore;
  final double? meanAfter;

  PainResponse({this.image, this.meanBefore, this.meanAfter});

  factory PainResponse.fromJson(Map<String, dynamic> json) {
    return PainResponse(
      image: json['image'],
      meanBefore: json['meanBefore'],
      meanAfter: json['meanAfter'],
    );
  }
}
