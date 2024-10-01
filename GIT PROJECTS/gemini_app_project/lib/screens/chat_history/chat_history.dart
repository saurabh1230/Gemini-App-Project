import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/routes/app_routes.dart';
import 'package:gemini_app_project/core/utils/utils.dart';
import 'package:gemini_app_project/db/chat/gemini_chat.dart';
import 'package:gemini_app_project/provider/chat_provider.dart';
import 'package:gemini_app_project/widget/wrap_text.dart';
import 'package:provider/provider.dart';

class SessionModel {
  final String sessionId;
  final List<GeminiChat> chats;

  SessionModel({required this.sessionId, required this.chats});
}

class ChatHistory extends StatefulWidget {
  const ChatHistory({super.key});

  @override
  State<ChatHistory> createState() => _ChatHistoryState();
}

class _ChatHistoryState extends State<ChatHistory> {
  List<SessionModel> getSessionChats(List<GeminiChat> chats) {
    Map<String, List<GeminiChat>> sessionsMap = {};


    for (var chat in chats) {
      if (!sessionsMap.containsKey(chat.sessionId)) {
        sessionsMap[chat.sessionId!] = [];
      }
      sessionsMap[chat.sessionId!]!.add(chat);
    }

    List<SessionModel> sessionChats = [];

    sessionsMap.forEach((sessionId, chats) {
      sessionChats.add(
        SessionModel(
          sessionId: sessionId,
          chats: chats,
        ),
      );
    });

    return sessionChats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.chatHistory),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Consumer(
              builder: (context, ChatProvider chatProvider, child) {
                return FutureBuilder(
                  future: chatProvider.getFavoriteChats(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (!snapshot.hasError &&
                        snapshot.hasData &&
                        snapshot.data!.isNotEmpty) {
                      var chats = snapshot.data as List<GeminiChat>;
                      var sessionChats = getSessionChats(chats);

                      return chats.isEmpty
                          ? _buildEmptyCard()
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: sessionChats.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return _buildCard(
                                  sessionChats[index].chats,
                                  chatProvider,
                                );
                              },
                            );
                    } else {
                      return _buildEmptyCard();
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.inventory_2_outlined,
              size: 100,
              color: Theme.of(context).brightness == Brightness.dark
                  ? darkGrey
                  : Colors.grey[300],
            ),
          ),
          const Text(AppStrings.noChtFound),
        ],
      ),
    );
  }

  Widget _buildCard(List<GeminiChat> chats, ChatProvider chatProvider) {
    return Card(
      color: Theme.of(context).brightness == Brightness.dark
          ? darkGrey
          : whiteGrey,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WrapText(title: AppStrings.chatTitle, text: chats.first.chat!),
              WrapText(
                title: AppStrings.sessionId,
                text: chats.first.sessionId!,
              ),
              WrapText(
                title: AppStrings.created,
                text: chatProvider
                    .getTimeNow(chats.first.createdAt ?? DateTime.now()),
              ),
            ],
          ),
        ),
        onTap: () {
          // Navigate to chat screen
          chatProvider.updateChatsGemini(chats).whenComplete(() {
            Navigator.pushNamed(context, AppRoutes.chatScreen);
          });
        },
        trailing: IconButton.filled(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red.shade400),
          ),
          onPressed: () async {
            await chatProvider.removeChat(chats).whenComplete(
                  () => snackbar(
                    context,
                    AppStrings.chatDeleted,
                    backgroundColor: Colors.red,
                  ),
                );
          },
          icon: const Icon(
            Icons.delete_outline_outlined,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
