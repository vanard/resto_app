import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/customer_review.dart';
import 'package:restaurant_app/providers/restaurants_provider.dart';

class AddReviewScreens extends StatefulWidget {
  const AddReviewScreens({super.key, required this.restoId});

  final String restoId;

  @override
  State<AddReviewScreens> createState() => _AddReviewScreensState();
}

class _AddReviewScreensState extends State<AddReviewScreens> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredReview = '';
  var _isLoading = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final provider = Provider.of<RestaurantsProvider>(context, listen: false);
    await provider.addCustomerReview(
      widget.restoId,
      CustomerReview(name: _enteredName, review: _enteredReview),
    );

    setState(() {
      _isLoading = false;
    });

    if (!context.mounted) {
      return;
    }

    if (provider.error.isNotEmpty) {
      return _showErrorMessage(provider.error);
    }

    Navigator.of(context).pop();
  }

  void _showErrorMessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        top: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 4) {
                    return 'Please enter name at least 4 characters.';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Review'),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 4) {
                    return 'Please enter review at least 4 characters.';
                  }

                  return null;
                },
                onSaved: (value) {
                  _enteredReview = value!;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  const SizedBox(width: 4),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submit,
                          child: Text('Add Review'),
                        ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
