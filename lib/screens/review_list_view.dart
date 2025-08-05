import 'package:flutter/material.dart';
import 'package:restaurant_app/models/customer_review.dart';
import 'package:restaurant_app/models/restaurant.dart';

class ReviewListScreen extends StatefulWidget {
  const ReviewListScreen({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  List<CustomerReview> reviews = [];

  @override
  void initState() {
    if (widget.restaurant.customerReviews != null) {
      reviews = widget.restaurant.customerReviews!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Review')),
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) => ListTile(
          // contentPadding: EdgeInsets.zero,
          title: Text(reviews[index].name),
          subtitle: Text(reviews[index].review),
          trailing: Text(reviews[index].date ?? ''),
        ),
      ),
    );
  }
}
