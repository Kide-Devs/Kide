import 'package:Kide/pages/AvatarPage/AvatarPin.dart';
import 'package:Kide/pages/AvatarPage/avatar_consts.dart';
import 'package:Kide/util/constants.dart';
import 'package:Kide/widgets/RoundedButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedButton(
              text: 'Save',
              color: Colors.blueAccent.shade700,
              shadowColor: Colors.transparent,
              onPressed: () async {
                print("Saving Avatar...");
                var accessory = accessories[accessoryIndex].value;
                var clothingType = clothingTypes[clothingIndex].value;
                var clothingColor = clothingColors[dressColorIndex].value;
                var eyebrow = eyebrows[eyebrowIndex].value;
                var eye = eyes[eyeIndex].value;
                var facialHair = facialHairs[faceHairIndex].value;
                var hair = hairs[hairIndex].value;
                var hat = hats[hatIndex].value;
                var hairColor = hairColors[hairColorIndex].value;
                var hatColor = hatColors[hatColorIndex].value;
                var skinTone = skinTones[toneIndex].value;
                var mouth = mouths[mouthIndex].value;
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
        ],
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
                accessory: accessories[accessoryIndex].value,
                hat: hats[hatIndex].value,
                clothingType: clothingTypes[clothingIndex].value,
                eyebrow: eyebrows[eyebrowIndex].value,
                mouth: mouths[mouthIndex].value,
                hair: hairs[hairIndex].value,
                facialHair: facialHairs[faceHairIndex].value,
                clothingColor: clothingColors[dressColorIndex].value,
                skinTone: skinTones[toneIndex].value,
                hatColor: hatColors[hatColorIndex].value,
                hairColor: hairColors[hairColorIndex].value,
                eye: eyes[eyeIndex].value,
              ),
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
                  'Skin Tone',
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
        margin: const EdgeInsets.fromLTRB(10, 10, 20, 0),
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
                      (tab) => Scrollbar(
                        child: ListView(
                          children: tab.modifiers,
                        ),
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
  final List<AvatarProperty> values;
  final int currentIndex;
  final Function(int index) indexChangeCallback;

  const _AvatarPropertyModifier(
    this.title,
    this.indexChangeCallback,
    this.currentIndex,
    this.values, {
    Key key,
  }) : super(key: key);

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
          Expanded(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  iconSize: BUTTON_SIZE,
                  color: _buttonColor(context),
                  onPressed: () {
                    final newIndex = (currentIndex - 1) % values.length;
                    indexChangeCallback(newIndex);
                  },
                ),
                Flexible(
                  child: Text(
                    values[currentIndex].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  iconSize: BUTTON_SIZE,
                  color: _buttonColor(context),
                  onPressed: () {
                    final newIndex = (currentIndex + 1) % values.length;
                    indexChangeCallback(newIndex);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
