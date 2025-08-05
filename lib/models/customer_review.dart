class CustomerReview {
  final String name;
  final String review;
  final String? date;

  CustomerReview({required this.name, required this.review, this.date});

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] as String,
      review: json['review'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> onAddReview(String id) {
    return {'id': id, 'name': name, 'review': review};
  }
}
