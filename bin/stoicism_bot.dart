import 'package:nyxx/nyxx.dart';
import 'fetch_quotes.dart';

void main() async {
  final quoteFetcher = StoicQuoteFetcher();
  var combinedContent = await quoteFetcher.fetchQuote();
  final client = await Nyxx.connectGateway(
      'TOKEN', //do not publicize your token
      GatewayIntents.allUnprivileged);

  final botUser = await client.users.fetchCurrentUser();

  client.onMessageCreate.listen((event) async {
    if (event.mentions.contains(botUser)) {
      await event.message.channel.sendMessage(MessageBuilder(
        content: combinedContent,
        replyId: event.message.id,
      ));
    }
  });
}
