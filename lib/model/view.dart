class View {
  final int id; // View ID
  final int partnerId; // Partner ID
  final int? userId; // User ID (nullable)
  final DateTime viewedAt; // Viewed at timestamp

  View({
    required this.id,
    required this.partnerId,
    this.userId,
    required this.viewedAt,
  });

  // Factory constructor to create a View object from JSON
  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      id: json['id'] as int,
      partnerId: json['partnerId'] as int,
      userId: json['userId'] != null ? json['userId'] as int : null,
      viewedAt: DateTime.parse(json['viewedAt'] as String),
    );
  }

  // Method to convert a View object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partnerId': partnerId,
      'userId': userId,
      'viewedAt': viewedAt.toIso8601String(),
    };
  }

  // Convert a list of JSON objects to a list of View objects
  static List<View> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => View.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
