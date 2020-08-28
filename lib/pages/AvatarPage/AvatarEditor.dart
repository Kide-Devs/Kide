import 'package:Kide/pages/AvatarPage/AvatarPin.dart';
import 'package:Kide/pages/AvatarPage/avatar_consts.dart';
import 'package:Kide/util/constants.dart';
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
      body: ListView(
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
          SizedBox(height: 30),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          accessoryIndex =
                              (accessoryIndex + 1) % accessories.length;
                        });
                      },
                      child: Text("Accessory"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          hatIndex = (hatIndex + 1) % hats.length;
                        });
                      },
                      child: Text("Hat"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          clothingIndex =
                              (clothingIndex + 1) % clothingTypes.length;
                        });
                      },
                      child: Text("Clothing"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          eyebrowIndex = (eyebrowIndex + 1) % eyebrows.length;
                        });
                      },
                      child: Text("Eyebrow"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          mouthIndex = (mouthIndex + 1) % mouths.length;
                        });
                      },
                      child: Text("Mouth"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          hairIndex = (hairIndex + 1) % hairs.length;
                        });
                      },
                      child: Text("Hair"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          faceHairIndex =
                              (faceHairIndex + 1) % facialHairs.length;
                        });
                      },
                      child: Text("Face Hair"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          dressColorIndex =
                              (dressColorIndex + 1) % clothingColors.length;
                        });
                      },
                      child: Text("Dress Color"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          toneIndex = (toneIndex + 1) % skinTones.length;
                        });
                      },
                      child: Text("Tone"),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          hatColorIndex =
                              (hatColorIndex + 1) % hatColors.length;
                        });
                      },
                      child: Text("Hat Color"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          hairColorIndex =
                              (hairColorIndex + 1) % hairColors.length;
                        });
                      },
                      child: Text("Hair Color"),
                    ),
                    MaterialButton(
                      color: Colors.indigoAccent,
                      onPressed: () {
                        setState(() {
                          eyeIndex = (eyeIndex + 1) % eyes.length;
                        });
                      },
                      child: Text("Eye"),
                    ),
                  ],
                ),
                MaterialButton(
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
                  child: Text("Save"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
