import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../Constant/constant.dart';
import '../Models/usermodel.dart';

class ProfileImagePreview extends StatefulWidget {
  final String visitedUserId;
  final String currentUserId;
final String
profilePicture;

  const ProfileImagePreview(
      {required Key key,
      required this.visitedUserId,
      required this.currentUserId, required this.profilePicture})
      : super(key: key);
  @override
  _ProfileImagePreviewState createState() => _ProfileImagePreviewState();
}

class _ProfileImagePreviewState extends State<ProfileImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: FutureBuilder(
              future: usersRef.doc(widget.visitedUserId).get(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    'Loading...',
                    style: GoogleFonts.alef(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  );
                } else if (snapshot == ConnectionState.waiting) {
                  return CupertinoActivityIndicator(
                    animating: true,
                    radius: 15,
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    'Snapshot Error',
                    style: GoogleFonts.alef(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  );
                }

                UserModel userModel = UserModel.fromDoc(snapshot.data);
                return Row(
                  children: [
                    Text(
                      userModel.name,
                      style: GoogleFonts.alef(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    userModel.verification.isEmpty
                        ? SizedBox()
                        : Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            size: 16,
                            color: Colors.blue,
                          ),
                  ],
                );
              })),
      backgroundColor: Colors.black,
      body: Stack(
              children: [
                Container(
                    child: PhotoView(
                  imageProvider: NetworkImage(widget.profilePicture),
                )),
              ],
      )
    );
  }
}
