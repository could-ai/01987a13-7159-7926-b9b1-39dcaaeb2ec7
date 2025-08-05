import 'package:flutter/material.dart';
import '../models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  late String _username;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 从登录页面获取传递过来的用户名
    final username = ModalRoute.of(context)?.settings.arguments as String?;
    _username = username ?? '游客';
  }

  void _handleSendPressed(String text) {
    if (text.trim().isEmpty) return;

    _textController.clear();
    final message = ChatMessage(
      text: text,
      sender: _username, // 在真实应用中，这里应该是当前用户的ID或名称
      timestamp: DateTime.now(),
    );
    setState(() {
      _messages.insert(0, message); // 将新消息添加到列表的开头
    });

    // 注意：这里是您将消息发送到后端（例如 Supabase）的地方。
    // 需要选择一个 Supabase 项目来实现实时聊天功能。
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天室'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // 列表反转，使最新消息显示在底部
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message.sender == _username;
                return _buildMessageBubble(message, isMe);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  // 构建消息气泡
  Widget _buildMessageBubble(ChatMessage message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  // 构建消息输入框
  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration.collapsed(
                hintText: '发送一条消息...',
              ),
              onSubmitted: _handleSendPressed,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSendPressed(_textController.text),
          ),
        ],
      ),
    );
  }
}
