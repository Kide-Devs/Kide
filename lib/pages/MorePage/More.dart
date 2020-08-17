import 'package:Kide/pages/MorePage/Widgets/MoreCard.dart';
import 'package:Kide/util/data.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DynamicTheme.of(context).data.scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                delegate: SliverChildListDelegate(
                  [
                    for (int i = 0; i < more.length; i++)
                      MoreCard(more[i], more[i].color)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
