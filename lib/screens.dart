// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'data.dart';
import 'routing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to the Bookstore!'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => RouteStateScope.of(context)!.go('/popular'),
                child: const Text('See the books'),
              ),
            ],
          ),
        ),
      );
}

class BooksScreen extends StatefulWidget {
  final String path;
  BooksScreen(this.path, {Key? key}) : super(key: key) {
    print('BookScreen: path= $path');
  }

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(_handleTabIndexChanged);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    switch (widget.path) {
      case '/popular':
        _tabController.index = 0;
        break;
      case '/new':
        _tabController.index = 1;
        break;
      case '/all':
        _tabController.index = 2;
        break;
      default:
        throw Exception('unknown path: ' + widget.path);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Popular',
                icon: Icon(Icons.people),
              ),
              Tab(
                text: 'New',
                icon: Icon(Icons.new_releases),
              ),
              Tab(
                text: 'All',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            BookList(books: Library.sample.popularBooks),
            BookList(books: Library.sample.newBooks),
            BookList(books: Library.sample.allBooks),
          ],
        ),
      );

  String get title {
    switch (_tabController.index) {
      case 0:
        return 'Popular';
      case 1:
        return 'New';
      case 2:
        return 'All';
      default:
        throw Exception('unknown index: ${_tabController.index}');
    }
  }

  void _handleTabIndexChanged() {
    final routeState = RouteStateScope.of(context)!;

    switch (_tabController.index) {
      case 0:
        routeState.go('/popular');
        break;
      case 1:
        routeState.go('/new');
        break;
      case 2:
        routeState.go('/all');
        break;
      default:
        throw Exception('invalid index: ${_tabController.index}');
    }
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;
  const BookList({required this.books, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(books[index].title),
          subtitle: Text(books[index].authorName),
        ),
      );
}
