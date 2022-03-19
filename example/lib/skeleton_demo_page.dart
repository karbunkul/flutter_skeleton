import 'dart:math';

import 'package:easy_skeleton/easy_skeleton.dart';
import 'package:example/person_item.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

class SkeletonDemoPage extends StatefulWidget {
  const SkeletonDemoPage({Key? key}) : super(key: key);

  @override
  State<SkeletonDemoPage> createState() => _SkeletonDemoPageState();
}

class _SkeletonDemoPageState extends State<SkeletonDemoPage> {
  List<Person> items = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2500), () {
      setState(() {
        items = List<Person>.generate(25, (index) => Person.random());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeleton demo'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  items.clear();
                });
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) {
                return SkeletonGroup(
                  skeleton: items.isEmpty,
                  builder: (context) {
                    final item = items.isEmpty
                        ? Person.random()
                        : items.elementAt(index);
                    return PersonItem(item);
                  },
                );
              },
              childCount: items.isNotEmpty ? items.length : 3,
            ),
          )
        ],
      ),
    );
  }
}

class Person {
  final String firstName;
  final String lastName;
  final String jobTitle;
  final bool? inRest;

  const Person({
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    this.inRest,
  });

  String get displayName => '$firstName $lastName';

  String get avatar {
    return firstName.substring(0, 1) + lastName.substring(0, 1).toUpperCase();
  }

  factory Person.random() {
    final person = faker.person;
    return Person(
      firstName: person.firstName(),
      lastName: person.lastName(),
      jobTitle: faker.job.title(),
      inRest: Random().nextBool(),
    );
  }
}
