import 'package:applematch/models/call_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CallScreen extends ConsumerStatefulWidget {
  final String channelId;
  final Call call;
  const CallScreen({
    Key? key,
    required this.channelId,
    required this.call,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CallScreenState();
}

class _CallScreenState extends ConsumerState<CallScreen> {
 

  @override
  void initState() {
    super.initState();
  
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
              child: Stack(
                children: [
                 
                ],
              ),
            ),
    );
  }
}