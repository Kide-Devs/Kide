import 'package:Kide/pages/AvatarPage/AvatarPin.dart';
import 'package:Kide/pages/AvatarPage/avatar_consts.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/RoundedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvatarEditPage extends StatefulWidget {
  AvatarEditPage({Key key, this.uid}) : super(key: key);

  final String uid;

  @override
  State<StatefulWidget> createState() {
    return _AvatarEditPageState();
  }
}

class _AvatarEditPageState extends State<AvatarEditPage> {
  int accessoryIndex = 0,
      hatIndex = 0,
      clothingIndex = 0,
      eyebrowIndex = 0,
      mouthIndex = 0,
      hairIndex = 0,
      faceHairIndex = 0,
      dressColorIndex = 0,
      toneIndex = 0,
      hatColorIndex = 0,
      hairColorIndex = 0,
      eyeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: DynamicTheme.of(context).data.textTheme.subtitle1.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: new Text(
          KIDE_CAPS,
          style: TextStyle(
            color: DynamicTheme.of(context).data.textTheme.subtitle1.color,
            fontFamily: "Michroma",
            fontWeight: FontWeight.w300,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      ),
      backgroundColor: DynamicTheme.of(context).data.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Avatar(
                width: 300,
                height: 300,
                accessory: accessories[accessoryIndex],
                hat: hats[hatIndex],
                clothingType: clothingTypes[clothingIndex],
                eyebrow: eyebrows[eyebrowIndex],
                mouth: mouths[mouthIndex],
                hair: hairs[hairIndex],
                facialHair: facialHairs[faceHairIndex],
                clothingColor: clothingColors[dressColorIndex],
                skinTone: skinTones[toneIndex],
                hatColor: hatColors[hatColorIndex],
                hairColor: hairColors[hairColorIndex],
                eye: eyes[eyeIndex],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: RoundedButton(
              text: 'Save',
              color: Colors.blueAccent.shade700,
              shadowColor: Colors.transparent,
              onPressed: () async {
                print("Saving Avatar...");
                var accessory = accessories[accessoryIndex];
                var clothingType = clothingTypes[clothingIndex];
                var clothingColor = clothingColors[dressColorIndex];
                var eyebrow = eyebrows[eyebrowIndex];
                var eye = eyes[eyeIndex];
                var facialHair = facialHairs[faceHairIndex];
                var hair = hairs[hairIndex];
                var hat = hats[hatIndex];
                var hairColor = hairColors[hairColorIndex];
                var hatColor = hatColors[hatColorIndex];
                var skinTone = skinTones[toneIndex];
                var mouth = mouths[mouthIndex];
                await Firestore.instance
                    .collection("userInfo")
                    .document(widget.uid)
                    .setData({
                  "avatarUrl": "https://bigheads.io/svg?"
                      "accessory=$accessory&"
                      "body=chest&"
                      "circleColor=blue&"
                      "clothing=$clothingType&"
                      "clothingColor=$clothingColor&"
                      "eyebrows=$eyebrow&"
                      "eyes=$eye&"
                      "faceMask=false&"
                      "faceMaskColor=red&"
                      "facialHair=$facialHair&"
                      "graphic=none&"
                      "hair=$hair&"
                      "hairColor=$hairColor&"
                      "hat=$hat&"
                      "hatColor=$hatColor&"
                      "lashes=true&"
                      "lipColor=pink&"
                      "mask=true&"
                      "mouth=$mouth&"
                      "skinTone=$skinTone"
                }, merge: true);
                Navigator.of(context).pop();
              },
            ),
          ),
          _AvatarEditorContainer(
            tabs: [
              _AvatarEditorTab('Body', [
                _AvatarPropertyModifier(
                  'Eyebrow',
                  (index) {
                    setState(() {
                      eyebrowIndex = index;
                    });
                  },
                  eyebrowIndex,
                  eyebrows,
                ),
                _AvatarPropertyModifier(
                  'Mouth',
                  (index) {
                    setState(() {
                      mouthIndex = index;
                    });
                  },
                  mouthIndex,
                  mouths,
                ),
                _AvatarPropertyModifier(
                  'Hair',
                  (index) {
                    setState(() {
                      hairIndex = index;
                    });
                  },
                  hairIndex,
                  hairs,
                ),
                _AvatarPropertyModifier(
                  'Facial Hair',
                  (index) {
                    setState(() {
                      faceHairIndex = index;
                    });
                  },
                  faceHairIndex,
                  facialHairs,
                ),
                _AvatarPropertyModifier(
                  'Hair Color',
                  (index) {
                    setState(() {
                      hairColorIndex = index;
                    });
                  },
                  hairColorIndex,
                  hairColors,
                ),
                _AvatarPropertyModifier(
                  'Eyes',
                  (index) {
                    setState(() {
                      eyeIndex = index;
                    });
                  },
                  eyeIndex,
                  eyes,
                ),
                _AvatarPropertyModifier(
                  'Skin tone',
                  (index) {
                    setState(() {
                      toneIndex = index;
                    });
                  },
                  toneIndex,
                  skinTones,
                ),
              ]),
              _AvatarEditorTab('Clothing', [
                _AvatarPropertyModifier(
                  'Hats',
                  (index) {
                    setState(() {
                      hatIndex = index;
                    });
                  },
                  hatIndex,
                  hats,
                ),
                _AvatarPropertyModifier(
                  'Hat Color',
                  (index) {
                    setState(() {
                      hatColorIndex = index;
                    });
                  },
                  hatColorIndex,
                  hatColors,
                ),
                _AvatarPropertyModifier(
                  'Accessory',
                  (index) {
                    setState(() {
                      accessoryIndex = index;
                    });
                  },
                  accessoryIndex,
                  accessories,
                ),
                _AvatarPropertyModifier(
                  'Clothing',
                  (index) {
                    setState(() {
                      clothingIndex = index;
                    });
                  },
                  clothingIndex,
                  clothingTypes,
                ),
                _AvatarPropertyModifier(
                  'Clothing Color',
                  (index) {
                    setState(() {
                      dressColorIndex = index;
                    });
                  },
                  dressColorIndex,
                  clothingColors,
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

class _AvatarEditorContainer extends StatefulWidget {
  final List<_AvatarEditorTab> tabs;

  _AvatarEditorContainer({@required this.tabs});

  @override
  __AvatarEditorContainerState createState() => __AvatarEditorContainerState();
}

class __AvatarEditorContainerState extends State<_AvatarEditorContainer>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.withOpacity(0.3),
              Colors.blueGrey.withOpacity(0.2)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: DynamicTheme.of(context).data.indicatorColor,
              labelColor:
                  DynamicTheme.of(context).data.tabBarTheme.labelStyle.color,
              labelStyle: TextStyle(
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
              tabs: [
                ...widget.tabs
                    .map((tab) => Tab(
                          text: tab.title,
                        ))
                    .toList(),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: widget.tabs
                    .map(
                      (tab) => ListView(
                        children: tab.modifiers,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarEditorTab {
  final String title;
  final List<_AvatarPropertyModifier> modifiers;

  const _AvatarEditorTab(this.title, this.modifiers);
}
class _AvatarPropertyModifier extends StatelessWidget {
  final String title;
  final List<String> values;
  final int currentIndex;
  final Function(int index) indexChangeCallback;

  const _AvatarPropertyModifier(
    this.title,
    this.indexChangeCallback,
    this.currentIndex,
    this.values, {
    Key key,
  }) : super(key: key);

  static const TextStyle _titleStyle = TextStyle(
    fontFamily: "Quicksand",
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const double BUTTON_SIZE = 40;

  static Color _buttonColor(BuildContext context) {
    return DynamicTheme.of(context).data.accentColor;
  } 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Text(
            title,
            style: _titleStyle,
          ),
          Spacer(),
          Text(
            values[currentIndex],
            style: TextStyle(
              fontFamily: "Quicksand",
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_left_outlined),
            iconSize: BUTTON_SIZE,
            color: _buttonColor(context),
            onPressed: () {
              final newIndex = (currentIndex - 1) % values.length;
              indexChangeCallback(newIndex);
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_right_outlined),
            iconSize: BUTTON_SIZE,
            color: _buttonColor(context),
            onPressed: () {
              final newIndex = (currentIndex + 1) % values.length;
              indexChangeCallback(newIndex);
            },
          ),
        ],
      ),
    );
  }
}
