// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Book {
  final int id;
  final String title;
  final String authorName;
  final bool isPopular;
  final bool isNew;

  Book(this.id, this.title, this.authorName, this.isPopular, this.isNew);
}

class Library {
  static Library sample = Library()
    ..addBook(
        title: 'Left Hand of Darkness',
        authorName: 'Ursula K. Le Guin',
        isPopular: true,
        isNew: true)
    ..addBook(
        title: 'Too Like the Lightning',
        authorName: 'Ada Palmer',
        isPopular: false,
        isNew: true)
    ..addBook(
        title: 'Kindred',
        authorName: 'Octavia E. Butler',
        isPopular: true,
        isNew: false)
    ..addBook(
        title: 'The Lathe of Heaven',
        authorName: 'Ursula K. Le Guin',
        isPopular: false,
        isNew: false);
  final List<Book> allBooks = [];

  void addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) =>
      allBooks.add(Book(allBooks.length, title, authorName, isPopular, isNew));

  List<Book> get popularBooks => [
        ...allBooks.where((book) => book.isPopular),
      ];

  List<Book> get newBooks => [
        ...allBooks.where((book) => book.isNew),
      ];
}
