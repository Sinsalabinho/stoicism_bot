import 'package:nyxx/nyxx.dart';

void main() async {
  final client = await Nyxx.connectGateway(
    'TOKEN', // Replace this with your bot's token
    GatewayIntents.allUnprivileged,
    options: GatewayClientOptions(plugins: [logging, cliIntegration]),
  );

  final botUser = await client.users.fetchCurrentUser();

  client.onMessageCreate.listen((event) async {
    if (event.mentions.contains(botUser)) {
      await event.message.channel.sendMessage(MessageBuilder(
        content: 'Hi There!',
        replyId: event.message.id,
      ));
    }
  });
}
