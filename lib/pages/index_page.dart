// import 'dart:async';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_calling_app/pages/video_call.dart';
//
// class IndexPage extends StatefulWidget {
//   const IndexPage({super.key});
//
//   @override
//   State<StatefulWidget> createState() => IndexState();
// }
//
// class IndexState extends State<IndexPage> {
//   /// create a channelController to retrieve text value
//   final _channelController = TextEditingController();
//
//   /// if channel textField is validated to have error
//   bool _validateError = false;
//
//   ClientRoleType? _role = ClientRoleType.clientRoleBroadcaster;
//
//   @override
//   void dispose() {
//     // dispose input controller
//     _channelController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Agora Calling'),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           height: 400,
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: _channelController,
//                       decoration: InputDecoration(
//                         errorText:
//                         _validateError ? 'Channel name is mandatory' : null,
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(width: 1),
//                         ),
//                         hintText: 'Channel name',
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   ListTile(
//                     title:
//                     Text(ClientRoleType.clientRoleBroadcaster.toString()),
//                     leading: Radio(
//                       value: ClientRoleType.clientRoleBroadcaster,
//                       groupValue: _role,
//                       onChanged: (ClientRoleType? value) {
//                         setState(() {
//                           _role = value;
//                         });
//                       },
//                     ),
//                   ),
//                   ListTile(
//                     title: Text(ClientRoleType.clientRoleAudience.toString()),
//                     leading: Radio(
//                       value: ClientRoleType.clientRoleAudience,
//                       groupValue: _role,
//                       onChanged: (ClientRoleType? value) {
//                         setState(() {
//                           _role = value;
//                         });
//                       },
//                     ),
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: onJoin,
//                         style: ButtonStyle(
//                             backgroundColor:
//                             MaterialStateProperty.all(Colors.blueAccent),
//                             foregroundColor:
//                             MaterialStateProperty.all(Colors.white)),
//                         child: const Text('Video Call'),
//                       ),
//                     ),
//                     // Expanded(
//                     //   child: RaisedButton(
//                     //     onPressed: onJoin,
//                     //     child: Text('Join'),
//                     //     color: Colors.blueAccent,
//                     //     textColor: Colors.white,
//                     //   ),
//                     // )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> onJoin() async {
//     // update input validation
//     setState(() {
//       _channelController.text.isEmpty
//           ? _validateError = true
//           : _validateError = false;
//     });
//     if (_channelController.text.isNotEmpty) {
//       // await for camera and mic permissions before pushing video page
//       await _handleCameraAndMic(Permission.camera);
//       await _handleCameraAndMic(Permission.microphone);
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VideoCall(),
//         ),
//       );
//     }
//   }
//
//   Future<void> _handleCameraAndMic(Permission permission) async {
//     final status = await permission.request();
//     print(status);
//   }
// }

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_calling_app/pages/call_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRoleType? _role = ClientRoleType.clientRoleBroadcaster;

  @override
  void dispose() {
    super.dispose();
    _channelController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Agora"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Image.network("https://tinyurl.com/2p889y4k"),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: _channelController,
                decoration: InputDecoration(
                    fillColor: Colors.black26,
                    filled: true,
                    hintText: "Channel Name",
                    border: UnderlineInputBorder(
                        // borderSide: BorderSide(width: 1),
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)),
                    errorText:
                        _validateError ? 'Channel Name is Mandatory' : null),
              ),
              RadioListTile(
                  title: Text("BroadCaster"),
                  value: ClientRoleType.clientRoleBroadcaster,
                  groupValue: _role,
                  onChanged: (ClientRoleType? value) {
                    setState(() {
                      _role = value;
                    });
                  }),
              RadioListTile(
                  title: Text("Audience"),
                  value: ClientRoleType.clientRoleAudience,
                  groupValue: _role,
                  onChanged: (ClientRoleType? value) {
                    setState(() {
                      _role = value;
                    });
                  }),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(MediaQuery.sizeOf(context).width, 55)),
                  onPressed: onJoin,
                  child: Text(
                    "Join",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => CallPage()));
    }
  }
}
