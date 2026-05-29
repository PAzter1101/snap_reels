import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:snap_reels/snap_reels.dart';

void main() {
  testWidgets('SnapReels widget can be created', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SnapReels(
            reels: [],
          ),
        ),
      ),
    );
    expect(find.byType(SnapReels), findsOneWidget);
  });
}
