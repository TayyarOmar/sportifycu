import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sportify_app/providers/chat_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';
import 'package:sportify_app/presentation/widgets/app_drawer.dart';

class AiCoachScreen extends StatefulWidget {
  const AiCoachScreen({super.key});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('AI Coach'),
        actions: [
          Consumer<ChatProvider>(builder: (context, provider, _) {
            return IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Clear session',
              onPressed: provider.isLoading ? null : () => provider.clear(),
            );
          }),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
          )
        ],
      ),
      endDrawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(child: Consumer<ChatProvider>(builder: (_, provider, __) {
            return ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(12),
              itemCount: provider.messages.length,
              itemBuilder: (_, idx) {
                final message =
                    provider.messages[provider.messages.length - 1 - idx];
                final isUser = message.role == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: isUser
                          ? AppColors.primary.withOpacity(0.8)
                          : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: isUser
                        ? Text(
                            message.content,
                            style: const TextStyle(color: Colors.white),
                          )
                        : MarkdownBody(
                            data: message.content,
                            styleSheet: MarkdownStyleSheet.fromTheme(
                                    Theme.of(context))
                                .copyWith(
                                    p: const TextStyle(color: Colors.white)),
                          ),
                  ),
                );
              },
            );
          })),
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Consumer<ChatProvider>(builder: (context, provider, child) {
      return SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                maxLines: null,
                maxLength: 500,
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSubmitted: (_) => _send(provider),
              ),
            ),
            IconButton(
              icon: provider.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.send),
              onPressed: provider.isLoading ? null : () => _send(provider),
            )
          ],
        ),
      );
    });
  }

  void _send(ChatProvider provider) {
    final text = _controller.text;
    _controller.clear();
    provider.sendUserMessage(text);
  }
}
