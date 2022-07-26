import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:twich_ui_clone/utils/colors.dart';
import 'package:twich_ui_clone/utils/utisl.dart';
import 'package:twich_ui_clone/widgets/custom_button.dart';
import 'package:twich_ui_clone/widgets/custom_text_field.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  final _customTextController = TextEditingController();
  Uint8List? image;
  @override
  void dispose() {
    // TODO: implement dispose
    _customTextController.dispose();
    super.dispose();
  }

  Future<void> goLive() async {}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                Uint8List? pickedImage = await pickImage();
                if (pickedImage != null) {
                  setState(() {
                    image = pickedImage;
                  });
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                child: image != null
                    ? SizedBox(
                        height: 300,
                        child: Image.memory(image!),
                      )
                    : DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(10),
                        color: buttonColor,
                        strokeCap: StrokeCap.round,
                        dashPattern: const [10, 4],
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                color: buttonColor,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Select your thumbail",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade400,
                                ),
                              )
                            ],
                          ),
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              color: buttonColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Titlte",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: CustomTextField(
                    controller: _customTextController,
                  ),
                )
              ],
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: CustomButton(onPressed: goLive, text: "Go Live"),
            )
          ],
        ),
      ),
    );
  }
}
