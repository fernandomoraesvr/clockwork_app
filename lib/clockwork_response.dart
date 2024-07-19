// {
//   "messages": [
//     {
//       "title": "Clockwork timer started",
//       "body": "Counting working time on SPP-13 for Piotr Stefaniak",
//       "type": "info",
//       "actions": {
//         "clockwork.action.navigate.issue-key.SPP-13": "View SPP-13"
//       }
//     }
//   ]
// }
class ClockworkResponse {
  final List<ClockworkMessage> messages;

  ClockworkResponse.fromJson(Map<String, dynamic> json)
      : messages = (List<ClockworkMessage>.from((json['messages'] as List)
            .map((e) => ClockworkMessage.fromJson(e))));
}

class ClockworkMessage {
  final String title;
  final String body;
  final String type;

  ClockworkMessage.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        type = json['type'];
}
