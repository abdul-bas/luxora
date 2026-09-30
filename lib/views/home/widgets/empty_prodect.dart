import 'package:flutter/material.dart';
import 'package:luxora/views/home/widgets/message.dart';

class EmptyProdect extends StatelessWidget {
  const EmptyProdect({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverFillRemaining(
    hasScrollBody: false,
    child: MessageWidget(
      icon: Icons.search_off_rounded,
      title: 'No products found',
      subtitle: 'Try a different search or clear your filters.',
    ));
  }
}