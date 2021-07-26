// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'bookstore_scaffold.dart';

class BookstoreNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final scaffoldKey = const ValueKey<String>('App scaffold');

  const BookstoreNavigator({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Navigator(
        key: navigatorKey,
        onPopPage: (route, dynamic result) => route.didPop(result),
        pages: [
          MaterialPage<void>(
            key: scaffoldKey,
            child: const BookstoreScaffold(),
          ),
        ],
      );
}
