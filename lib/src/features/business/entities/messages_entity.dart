class MessagesEntity {
  final List<Message>? _messages;
  List<Message>? get messages => _messages;

  MessagesEntity({
    List<Message>? messages,
  })  : _messages = messages;
}

class Message {
  int? id;
  int? senderId;
  String? senderName;
  String? image;
  String? content;
  String? fileUrl;
  String? messageType;
  String? createdAt;
  String? messageState;

  Message({
    this.id,
    this.senderId,
    this.senderName,
    this.image,
    this.content,
    this.fileUrl,
    this.messageType,
    this.createdAt,
    this.messageState,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    senderName = json['senderName'];
    image = json['image'];
    content = json['content'];
    fileUrl = json['fileUrl'];
    messageType = json['messageType'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> messages = <String, dynamic>{};
    messages['id'] = id;
    messages['senderId'] = senderId;
    messages['senderName'] = senderName;
    messages['image'] = image;
    messages['content'] = content;
    messages['fileUrl'] = fileUrl;
    messages['messageType'] = messageType;
    messages['createdAt'] = createdAt;
    return messages;
  }
}

class ChatStartedEntity {
  int? id;
  String? createdAt;
  int? member1Id;
  int? member2Id;
  int? ministryId;

  ChatStartedEntity({
    this.id,
    this.createdAt,
    this.member1Id,
    this.member2Id,
    this.ministryId,
  });

  ChatStartedEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    member1Id = json['member1Id'];
    member2Id = json['member2Id'];
    ministryId = json['ministryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['member1Id'] = member1Id;
    data['member2Id'] = member2Id;
    data['ministryId'] = ministryId;
    return data;
  }
}


