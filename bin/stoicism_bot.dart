import 'package:nyxx/nyxx.dart';
import 'fetch_quotes.dart';

void main() async {
  final quoteFetcher = StoicQuoteFetcher();
  final client = await Nyxx.connectGateway(
      'Token', //do not publicize your token
      GatewayIntents.allUnprivileged);

  final botUser = await client.users.fetchCurrentUser();

  client.onMessageCreate.listen((event) async {
    if (event.mentions.contains(botUser)) {
      var combinedContent = await quoteFetcher.fetchQuote();
      await event.message.channel.sendMessage(MessageBuilder(
        content: combinedContent,
        replyId: event.message.id,
      ));
    }
  });
}
