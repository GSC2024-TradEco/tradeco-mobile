// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class MessagePage extends StatefulWidget {
//   const MessagePage({Key? key}) : super(key: key);

//   @override
//   State<MessagePage> createState() => _MessagePageState();
// }

// class _MessagePageState extends State<MessagePage> {
//   @override
//   Widget build(BuildContext context) {
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   // Scroll to the latest message
//     //   if (_scrollController.hasClients) {
//     //     _scrollController.animateTo(
//     //       _scrollController.position.maxScrollExtent,
//     //       duration: const Duration(milliseconds: 300),
//     //       curve: Curves.easeOut,
//     //     );
//     //   }
//     // });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(data[1]),
//         backgroundColor: Colors.purple[400],
//       ),

//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.separated(
//               controller: _scrollController, // Attach the ScrollController
//               reverse: false,
//               itemCount: messageList.length,
//               separatorBuilder: (context, index) => Divider(
//                 color: Colors.grey,
//                 height: 1.0,
//               ),
//               itemBuilder: (context, index) {
//                 final message = messageList[index];
//                 final text = message['text'];
//                 final created = message['createdAt'];
//                 final isCurrentUser = message['isCurrentUser'] == 'true';

//                 return Align(
//                   alignment: isCurrentUser
//                       ? Alignment.centerRight
//                       : Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: isCurrentUser ? Colors.purple[400] : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           text!,
//                           style: TextStyle(
//                             color: isCurrentUser ? Colors.white : Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           created!,
//                           style: TextStyle(
//                             color:
//                                 isCurrentUser ? Colors.white70 : Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(10),
//             color: Colors.grey[200],
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController.addMessageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     String message =
//                         messageController.addMessageController.text;
//                     if (message.isNotEmpty) {
//                       sendMessage(message);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     primary: Colors.purple[400],
//                   ),
//                   child: Text('Send'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// }