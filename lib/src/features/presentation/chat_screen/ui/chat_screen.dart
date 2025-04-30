import 'package:chat_app/chat_export.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatController=TextEditingController();
  late final ChatBloc _bloc = sl.get();

  @override
  void initState() {
    super.initState();
    _bloc.add(GetMessages(chatId: 1, page: 1)); // Use the appropriate chatId and page number
  }
  @override
  Widget build(BuildContext context) {
      return Stack(
        alignment: Alignment.center,
        children: [
        SizedBox.expand(
          child: ColoredBox(
            color: AppColors.primaryColor,
              child: Opacity(
                opacity: 0.45,
                child: Image.asset(Assets.backgroundImage,
                ),
              ),),
        ),
        Scaffold(
          backgroundColor: AppColors.transparent,
          body:  GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: BlocProvider(
              create: (context) => _bloc,
              child: Builder(
                builder: (context) =>  BlocListener(
                  bloc: _bloc,
                  listener: ((context, state) => {
                    // if (state is LoginStateLoggingIn)
                    //   {
                    //   }
                    //   else if (state is LoginStateIdle)
                    //       {
                    //       }
                  }),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(Assets.backButton,height: 48,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 17),
                                    decoration: BoxDecoration(
                                        color: AppColors.groupTileColor,
                                        borderRadius: BorderRadius.only(bottomLeft:Radius.circular(32),bottomRight:Radius.circular(32)),
                                        border: Border.all(
                                          color: AppColors.groupTileBorderColor,
                                          width: 1,
                                        )
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                                          child: Image.asset(
                                            Assets.groupImage,
                                            height: 44,
                                            width: 44,
                                            fit: BoxFit.cover, // Optional, depending on your layout
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        CommonText(
                                          "Tommy’s Group",
                                          Assets.frauncesBold,
                                          18,
                                          color: AppColors.blackTextColor,
                                        ),
                                        Spacer(),
                                        BlackDot(),
                                        BlackDot(),
                                        BlackDot(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20,),
                              ],
                            ),
                            SizedBox(height: 20,),
                            BlocBuilder<ChatBloc, ChatState>(
                              builder: (context, state) {
                                if (state is MessagesLoadingState) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (state is MessagesLoadedState) {
                                  final messages = state.messages;
                                  if (messages.isEmpty) {
                                    return Center(child: Text("No messages available"));
                                  }

                                  return Expanded(
                                    child: ListView.separated(
                                      reverse: true,
                                      itemCount: messages.length,
                                      itemBuilder: (context, index) {
                                        final message = messages[index];
                                        debugPrint("DATE===${message.createdAt}");
                                        DateTime parsedDate = DateTime.parse(message.createdAt??"");

                                        String formattedTime = DateFormat('HH:mm').format(parsedDate);
                                        return
                                          message.senderId==0?
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.only(top: 12, bottom: 7,left: 25,right: 12),
                                            margin: EdgeInsets.only(right: 12,left: 100),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: Offset(-5,5),
                                                  color: AppColors.blackTextColor.withValues(alpha: 0.05),
                                                  blurRadius: 2,
                                                  spreadRadius: 0,
                                                )
                                              ],
                                              color: AppColors.groupTileColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(35), bottomLeft: Radius.circular(35)),
                                              border: Border.all(color: AppColors.groupTileBorderColor),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CommonText(
                                                  message.content ?? '',
                                                  Assets.frauncesRegular,
                                                  14,
                                                  color: AppColors.blackTextColor2,
                                                  lines: 100,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    CommonText(
                                                      formattedTime,
                                                      Assets.frauncesRegular,
                                                      12,
                                                      color: AppColors.timeColor,
                                                      lines: 100,
                                                    ),
                                                  ],),
                                              ],
                                            ),
                                          ):
                                          Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.only(top: 12, bottom: 7,left: 12,right: 30),
                                          margin: EdgeInsets.only(right: 100,left: 12),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                offset: Offset(-5,5),
                                                color: AppColors.blackTextColor.withValues(alpha: 0.05),
                                                blurRadius: 2,
                                                spreadRadius: 0,
                                              )
                                            ],
                                            color: AppColors.othersGroupTileColor,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(35), bottomRight: Radius.circular(35)),
                                            border: Border.all(color: AppColors.groupTileBorderColor),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  message.senderId==2?
                                                  Image.asset(message.image ?? '', height: 24, width: 24):
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: AppColors.userOneNameColor)),
                                                      child: Image.asset(message.image ?? '', height: 24, width: 24)),
                                                  SizedBox(width: 5),
                                                  Expanded(
                                                    child: CommonText(
                                                      message.senderName ?? '',
                                                      Assets.frauncesSemiBold,
                                                      16,
                                                      color:message.senderId==1?AppColors.userOneNameColor:message.senderId==2?AppColors.blackTextColor:AppColors.userThreeNameColor,
                                                      lines: 100,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              CommonText(
                                                message.content ?? '',
                                                Assets.frauncesRegular,
                                                14,
                                                color: AppColors.blackTextColor2,
                                                lines: 100,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                CommonText(
                                                  formattedTime,
                                                  Assets.frauncesRegular,
                                                  12,
                                                  color: AppColors.timeColor,
                                                  lines: 100,
                                                ),
                                              ],),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (BuildContext context, int index) {
                                        return SizedBox(height: 10);
                                      },
                                    ),
                                  );
                                }

                                return Center(child: Text("No messages available"));
                              },
                            ),

                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.chatBoxColor,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                                border: Border.all(
                                  color: AppColors.userOneNameColor
                                )
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 4, // Limits to 4 lines
                                      minLines: 2, // Optional: starts with 1 line and grows
                                      controller: chatController,
                                      decoration: InputDecoration(
                                        hintText: "write a message",
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,

                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            // Add the message to the list
                                            String messageContent = chatController.text.trim();
                                            if (messageContent.isNotEmpty) {
                                              // You can add the message to your bloc state here
                                              _bloc.add(AddMessage(messageContent: messageContent, mediaUrl: '', messageType: 'text')); // Add this event to your bloc
                                              chatController.clear(); // Clear the text field
                                            }
                                          },
                                          child: SvgPicture.asset(Assets.malBox,width: 37,)),
                                      SizedBox(width: 5,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset(Assets.camera,width: 25,),
                                          SizedBox(height: 5,),
                                          SvgPicture.asset(Assets.flag,width: 18,),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BlackDot extends StatelessWidget {
  const BlackDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(height: 7,width: 7, margin:EdgeInsets.only(right: 2),decoration: BoxDecoration(color: AppColors.blackTextColor,shape: BoxShape.circle),);
  }
}


