import 'package:flutter/foundation.dart';
import '../models/Contact.dart';

class ContactCategory {
  final String id;
  final String name;
  final List<Contact> contacts;
  ContactCategory({
    @required this.id,
    @required this.name,
    @required this.contacts
  });
}