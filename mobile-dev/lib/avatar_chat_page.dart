import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/avatar_provider.dart';

class AvatarChatPage extends StatefulWidget {
  const AvatarChatPage({super.key});

  @override
  State<AvatarChatPage> createState() => _AvatarChatPageState();
}

class _AvatarChatPageState extends State<AvatarChatPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatar = Provider.of<AvatarProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Directionality(textDirection: TextDirection.rtl, child: Text('محادثة أكورا')),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              padding: const EdgeInsets.all(16),
              itemCount: avatar.messages.length,
              itemBuilder: (context, index) {
                final msg = avatar.messages[index];
                return Align(
                  alignment: msg.fromUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.fromUser ? Colors.green[50] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black12.withOpacity(0.03), blurRadius: 4)],
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(msg.text, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(hintText: 'أكتب رسالتك...'),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: avatar.isSending
                      ? null
                      : () async {
                          final txt = _controller.text.trim();
                          if (txt.isEmpty) return;
                          _controller.clear();
                          await avatar.sendMessage(txt);
                        },
                  child: avatar.isSending ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('إرسال'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
