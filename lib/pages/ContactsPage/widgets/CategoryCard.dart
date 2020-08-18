import 'package:Kide/models/ContactCategory.dart';
import 'package:Kide/pages/ContactsPage/ContactList.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(this.contactCategory);

  final ContactCategory contactCategory;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: DynamicTheme.of(context).data.cardColor,
      margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: new InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ContactList.routeName, arguments: contactCategory);
        },
        child: Center(
          child: Text(
            contactCategory.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: DynamicTheme.of(context).data.textTheme.subtitle1.color,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
