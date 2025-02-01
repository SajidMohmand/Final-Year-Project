import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatelessWidget {
  final List<Map<String, String>> chatData = [
    {
      'imagePath': 'assets/images/lawyer1.png',
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'number': '1',
      'date': '2025-01-27',
    },
    {
      'imagePath': 'assets/images/lawyer2.png',
      'name': 'Jane Smith',
      'message': 'Are you free today?',
      'number': '2',
      'date': '2025-01-26',
    },
    {
      'imagePath': 'assets/images/lawyer3.png',
      'name': 'Bob Johnson',
      'message': 'Let\'s catch up soon!',
      'number': '5',
      'date': '2025-01-25',
    },
    {
      'imagePath': 'assets/images/lawyer4.png',
      'name': 'Alice Cooper',
      'message': 'The meeting is scheduled.',
      'number': '4',
      'date': '2025-01-24',
    },
    {
      'imagePath': 'assets/images/lawyer1.png',
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'number': '1',
      'date': '2025-01-27',
    },
    {
      'imagePath': 'assets/images/lawyer2.png',
      'name': 'Jane Smith',
      'message': 'Are you free today?',
      'number': '2',
      'date': '2025-01-26',
    },
    {
      'imagePath': 'assets/images/lawyer3.png',
      'name': 'Bob Johnson',
      'message': 'Let\'s catch up soon!',
      'number': '5',
      'date': '2025-01-25',
    },
    {
      'imagePath': 'assets/images/lawyer4.png',
      'name': 'Alice Cooper',
      'message': 'The meeting is scheduled.',
      'number': '4',
      'date': '2025-01-24',
    },
    {
      'imagePath': 'assets/images/lawyer1.png',
      'name': 'John Doe',
      'message': 'Hey, how are you?',
      'number': '1',
      'date': '2025-01-27',
    },
    {
      'imagePath': 'assets/images/lawyer2.png',
      'name': 'Jane Smith',
      'message': 'Are you free today?',
      'number': '2',
      'date': '2025-01-26',
    },
    {
      'imagePath': 'assets/images/lawyer3.png',
      'name': 'Bob Johnson',
      'message': 'Let\'s catch up soon!',
      'number': '5',
      'date': '2025-01-25',
    },
    {
      'imagePath': 'assets/images/lawyer4.png',
      'name': 'Alice Cooper',
      'message': 'The meeting is scheduled.',
      'number': '4',
      'date': '2025-01-24',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: ListView.builder(
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          var chatItem = chatData[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: _buildChatItem(
              context,
              chatItem['imagePath']!,
              chatItem['name']!,
              chatItem['message']!,
              chatItem['number']!,
              chatItem['date']!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatItem(
    BuildContext context,
    String imagePath,
    String name,
    String message,
    String number,
    String date,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 25,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(message),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 23,
              width: 24,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Text(
                  number,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetailScreen(
              name: name,
              number: number,
            ),
          ),
        );
      },
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String number;

  ChatDetailScreen({required this.name, required this.number});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> messages = [];
  FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _audioFilePath;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _soundRecorder.openRecorder();
  }

  @override
  void dispose() {
    _soundRecorder.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      final tempDir = await getTemporaryDirectory();
      _audioFilePath =
          '${tempDir.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _soundRecorder.startRecorder(toFile: _audioFilePath);
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print('Error starting recorder: $e');
    }
  }

  Future<void> _stopRecording() async {
    await _soundRecorder.stopRecorder();
    setState(() {
      _isRecording = false;
      messages.add("Audio: $_audioFilePath");
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      String filePath = result.files.single.path!;
      setState(() {
        messages.add("File: $filePath");
      });
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.brown,
            ),
            onPressed: _sendMessage,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          messages[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '4:00 PM',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(width: 4,),
                            Stack(
                              alignment: Alignment.center,
                              children: [

                                Positioned(
                                  left: -3,
                                  child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),),

                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),


          Padding(
            padding: EdgeInsets.only(left: 12,right: 12,bottom: 28),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  onPressed: _isRecording ? _stopRecording : _startRecording,
                ),
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                Expanded(
                    child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type something here...',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send,color: Colors.brown,),
                      onPressed: _sendMessage,
                    ),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.brown.shade100,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
