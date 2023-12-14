import 'package:nyxx/nyxx.dart';
import 'fetch_quotes.dart';

void main() async {
  final quoteFetcher = StoicQuoteFetcher();
  var text = await quoteFetcher.fetchQuote();
  var author = await quoteFetcher.fetchQuote();

  final client =
      await Nyxx.connectGateway('TOKEN', GatewayIntents.allUnprivileged);

  final botUser = await client.users.fetchCurrentUser();

  client.onMessageCreate.listen((event) async {
    if (event.mentions.contains(botUser)) {
      var combinedContent = '$text\n: $author';
      await event.message.channel.sendMessage(MessageBuilder(
        content: combinedContent,
        replyId: event.message.id,
      ));
    }
  });
}
