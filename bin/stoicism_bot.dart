import 'package:nyxx/nyxx.dart';
import 'fetch_quotes.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  CommandsPlugin commands = CommandsPlugin(
    prefix: (message) => '/',
    options: CommandsOptions(
      logErrors: true,
    ),
  );

// ping command
  ChatCommand ping = ChatCommand(
    'ping',
    'Checks if the bot is online',
    id('ping', (ChatContext context) {
      context.respond(MessageBuilder(content: 'pong!'));
    }),
  );

  commands.addCommand(ping);

// say command
  ChatCommand say = ChatCommand(
    'say',
    'Make the bot say something',
    id('say', (ChatContext context, String message) {
      context.respond(MessageBuilder(content: message));
    }),
  );

  commands.addCommand(say);

  final quoteFetcher = StoicQuoteFetcher();
  final client = await Nyxx.connectGateway(
    'Token', //do not publicize your token
    GatewayIntents.allUnprivileged,
    options: GatewayClientOptions(
        plugins: [commands, logging, cliIntegration, ignoreExceptions]),
  );

  final botUser = await client.users.fetchCurrentUser();
// mention command
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
