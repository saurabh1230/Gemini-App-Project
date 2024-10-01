import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:gemini_app_project/core/constants/colors.dart';
import 'package:gemini_app_project/core/constants/icons.dart';
import 'package:gemini_app_project/core/constants/strings.dart';
import 'package:gemini_app_project/core/utils/enums.dart';
import 'package:gemini_app_project/core/utils/utils.dart';
import 'package:gemini_app_project/model/chat_model.dart';
import 'package:gemini_app_project/model/dropdown_icon_model.dart';
import 'package:gemini_app_project/provider/chat_provider.dart';
import 'package:gemini_app_project/widget/bottom_sheet.dart';
import 'package:gemini_app_project/widget/text_form_field.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();

  final scrollController = ScrollController();

  // Dropdown icon
  final dropdownItems = <DropDownIcon>[
    DropDownIcon(title: AppStrings.copy, icon: Icons.copy),
    DropDownIcon(title: AppStrings.share, icon: Icons.share),
  ];

  // Scroll to down
  void downToScroll() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  // Dropdown menu actions
  _selectedItem(String value, String text) async {
    switch (value) {
      case AppStrings.copy:
        Clipboard.setData(ClipboardData(text: text));
        break;
      case AppStrings.share:
        await Share.share(text);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    msgController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.sizeOf(context);
    final chatProvider = context.read<ChatProvider>();
    return PopScope(
      onPopInvoked: (didPop) {
        chatProvider.clearSelection();
        chatProvider.clearChats();
      },
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(AppStrings.assistance),
          // Hide/Show circle back button
          // leading: const GoBack(),
          actions: [
            Consumer<ChatProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  tooltip: 'Save chat',
                  onPressed: () {
                    provider.favoriteClick(context);
                  },
                  icon: Icon(
                    provider.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                );
              },
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: _buildChat(context)),
                ],
              ),
            ),
            _buildBottomField(context),
          ],
        ),
      ),
    );
  }

  Widget _buildChat(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              ListView.builder(
                itemCount: provider.chatMessages.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final model = provider.chatMessages[index];
                  return _chatCard(context, model, provider);
                },
              ),
              if (provider.isLoading)
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 40,
                        width: 80,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? darkGrey
                              : whiteGrey,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                            bottomRight: Radius.circular(14),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Transform.scale(
                          scale: 3,
                          child: Lottie.asset(
                            Theme.of(context).colorScheme.loadingLottie,
                            delegates: LottieDelegates(
                              values: [
                                ValueDelegate.color(
                                  const ['**', '4', '**'],
                                  value: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? loadingColor
                                      : menuTextColor,
                                ),
                                ValueDelegate.color(
                                  const ['**', '3', '**'],
                                  value: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? loadingColor
                                      : menuTextColor,
                                ),
                                ValueDelegate.color(
                                  const ['**', '2', '**'],
                                  value: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? loadingColor
                                      : menuTextColor,
                                ),
                              ],
                            ),
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // model
  Widget _chatCard(BuildContext context, Chat chat, ChatProvider provider) {
    return Container(
      margin: chat.chats!.role == Role.user.name
          ? const EdgeInsets.only(left: 10.0, bottom: 20.0)
          : const EdgeInsets.only(right: 0.0, bottom: 20.0),
      child: Align(
        alignment: chat.chats!.role == Role.model.name
            ? Alignment.topLeft
            : Alignment.topRight,
        child: Column(
          crossAxisAlignment: chat.chats!.role == Role.user.name
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                chat.chats!.role == Role.user.name
                    ? _buildPopUp(
                        chat.chats!.parts.first.text!,
                        chat.imgData?.data,
                      )
                    : const SizedBox.shrink(),
                if (chat.chats!.role == Role.model.name) ...[
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? darkGrey
                          : whiteGrey,
                      borderRadius: BorderRadius.circular(60),
                      border: const GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [gradientMain2, gradientMain1],
                        ),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        Theme.of(context).colorScheme.splashLogo,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? darkGrey
                          : whiteGrey,
                      borderRadius: chat.chats!.role == Role.user.name
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )
                          : const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                      gradient: chat.chats!.role == Role.user.name
                          ? const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [gradientMain2, gradientMain1],
                            )
                          : null,
                    ),
                    // alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (chat.chats!.role == Role.user.name) ...[
                          if (chat.imgData?.data != null)
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.memory(
                                    base64Decode(chat.imgData!.data!),
                                    height: 100,
                                  ),
                                ),
                              ),
                            ),
                        ],
                        Text(
                          chat.chats!.parts.first.text!,
                          style: TextStyle(
                            color: chat.chats!.role == Role.user.name
                                ? whiteColor2
                                : Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? whiteColor2
                                    : menuTextColor1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                chat.chats!.role == Role.model.name
                    ? _buildPopUp(
                        chat.chats!.parts.first.text!,
                        chat.imgData?.data,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            Padding(
              padding: chat.chats!.role == Role.user.name
                  ? const EdgeInsets.only(top: 8.0, left: 50.0)
                  : const EdgeInsets.only(top: 8.0, right: 50.0),
              child:
                  Text(provider.getTimeNow(chat.createdAt ?? DateTime.now())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopUp(String text, String? image) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      elevation: 0,
      onSelected: (value) => _selectedItem(value, text),
      itemBuilder: (context) => <PopupMenuEntry>[
        for (var item in dropdownItems)
          PopupMenuItem(
            value: item.title,
            child: Row(
              children: [
                Icon(item.icon),
                const SizedBox(width: 8.0),
                Text(item.title, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
      ],
      // items: dropdownItems.map((item) {
      //   return DropdownMenuItem(
      //     value: item,
      //     child: image != null
      //         ? const SizedBox.shrink()
      //         : Row(
      //             children: [
      //               Icon(item.icon),
      //               const SizedBox(width: 8.0),
      //               Text(item.title,
      //                   style: Theme.of(context).textTheme.bodySmall),
      //             ],
      //           ),
      //   );
      // }).toList(),
    );
    // PopupMenuButton(
    //   icon: const Icon(Icons.more_vert),
    //   elevation: 0,
    //   onSelected: (value) {
    //     // Copy to clipBoard
    //     Clipboard.setData(ClipboardData(text: text));
    //   },
    //   itemBuilder: (context) => <PopupMenuEntry>[
    //     PopupMenuItem(
    //       value: AppStrings.copy,
    //       child: Row(
    //         children: [
    //           const Icon(
    //             Icons.copy,
    //           ),
    //           const SizedBox(width: 8.0),
    //           Text(AppStrings.copy,
    //               style: Theme.of(context).textTheme.bodySmall),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }

  // Bottom text field widget
  Widget _buildBottomField(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return SizedBox(
          height: chatProvider.selectedFile != null ? 150 : 55,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (chatProvider.selectedFile != null) ...[
                Container(
                  height: 80,
                  margin: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: const GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [gradientMain2, gradientMain1],
                      ),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.file(
                          chatProvider.selectedFile!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: -2,
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: IconButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.black26,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              chatProvider.clearSelection();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
              Container(
                color: Theme.of(context).brightness == Brightness.dark
                    ? backgroundColorDarkTheme
                    : backgroundColorLightTheme,
                height: 55,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        openBottomSheet(
                          context,
                          onTabImageGallery: () {
                            chatProvider.selectFile();
                            Navigator.pop(context);
                          },
                          onTabImageCamera: () {
                            chatProvider.selectFile(source: ImageSource.camera);
                            Navigator.pop(context);
                          },
                        );
                      },
                      icon: SvgPicture.asset(
                        Theme.of(context).colorScheme.galleryIcon,
                        colorFilter: const ColorFilter.mode(
                          menuTextColor1,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppFormField(
                        hint: AppStrings.hintText,
                        controller: msgController,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 44,
                        decoration: BoxDecoration(
                          border: const GradientBoxBorder(
                            gradient: LinearGradient(
                              colors: [gradientMain2, gradientMain1],
                            ),
                          ),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            downToScroll();
                            if (msgController.value.text.isEmpty) {
                              snackbar(context, AppStrings.chatRequiredText);
                              return;
                            }

                            chatProvider.chat(msgController.text);
                            msgController.clear();
                          },
                          icon: SvgPicture.asset(
                            Theme.of(context).colorScheme.sendIcon,
                            colorFilter: const ColorFilter.mode(
                              menuTextColor1,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
