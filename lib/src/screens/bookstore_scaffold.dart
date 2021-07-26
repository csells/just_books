// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../routing.dart';
import 'books_screen.dart';

class BookstoreScaffold extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  const BookstoreScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Navigator(
          key: navigatorKey,
          onPopPage: (route, dynamic result) => route.didPop(result),
          pages: [
            MaterialPage<void>(
              key: const ValueKey('books'),
              child:
                  BooksScreen(currentRoute: RouteStateScope.of(context)!.route),
            )
          ],
        ),
      );
}
