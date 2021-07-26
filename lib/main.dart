// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'books_screen.dart';
import 'routing.dart';

void main() => runApp(const Bookstore());

class Bookstore extends StatefulWidget {
  const Bookstore({Key? key}) : super(key: key);

  @override
  _BookstoreState createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {
  late final RouteState routeState;
  late final SimpleRouterDelegate routerDelegate;
  late final TemplateRouteParser routeParser;

  @override
  void initState() {
    routeParser = TemplateRouteParser(
      allowedPaths: [
        '/books/new',
        '/books/all',
        '/books/popular',
      ],
      initialRoute: '/books/popular',
    );

    routeState = RouteState(routeParser);

    routerDelegate = SimpleRouterDelegate(
      routeState: routeState,
      builder: (context) {
        final uri = Uri.parse(RouteStateScope.of(context)!.route.path);
        final seg = uri.pathSegments.last;
        return BooksScreen(seg);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: routeState,
        child: MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: routeParser,
        ),
      );

  @override
  void dispose() {
    routeState.dispose();
    routerDelegate.dispose();
    super.dispose();
  }
}
