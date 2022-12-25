import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MyCatView extends StatefulWidget {
  final int index;
  const MyCatView(this.index, {super.key});

  @override
  State<StatefulWidget> createState() => _MyCatViewState();
}

class _MyCatViewState extends State<MyCatView> {

  late int itemId;
  late Uint8List imageData;
  bool canLoad = false;
  _asyncMethod() async {
    Map<String, String> requestHeaders = {
      'Accept': 'images/*',
    };

    var url = Uri.parse("https://randomfox.ca/images/$itemId.jpg");

    var response = await get(url, headers: requestHeaders);

    if(mounted){
      setState(() {
        imageData = response.bodyBytes;
        canLoad = true;
      });
    }
  }
  @override
  void initState() {
    itemId = widget.index;
    _asyncMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(canLoad) {
      return Table(
        children: [
          TableRow(children: [
            Text('Равным образом социально-экономическое развитие играет выжную роль.2 $itemId'),
            Image.memory(imageData, width: 100, height: 100)
          ])
        ],
      );
    }else{
      return const Center(
        child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
                backgroundColor: Colors.lime,
                strokeWidth: 5)
        ),
      );
    }
  }
}