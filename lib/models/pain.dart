class Pain {
  final int? id;
  final String painLocale;
  final int painScale;
  final String type;
  final String dateTimeEvent;

  Pain({
    this.id,
    required this.painLocale,
    required this.painScale,
    required this.type,
    required this.dateTimeEvent,
  });

  factory Pain.fromJson(Map<String, dynamic> json) {
    return Pain(
      id: json['id'],
      painLocale: json['painLocale'],
      painScale: json['painScale'],
      type: json['type'],
      dateTimeEvent: json['dateTimeEvent'],
    );
  }
}
