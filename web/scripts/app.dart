import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:speak/client.dart';
import '../components/xplayer.dart';

void main() {
  useShadowDom = true;

  var speak = new SpeakClient("ws://127.0.0.1:3001");

  speak.createStream(video: true).then((stream) {
    var video = new VideoElement()
      ..autoplay = true
      ..src = Url.createObjectUrl(stream);

    document.query('#local').append(video);
  });

  speak.onAdd.listen((message) {
    var video = new VideoElement()
      ..id = 'remote${message['id']}'
      ..autoplay = true
      ..src = Url.createObjectUrl(message['stream']);

    document.query('#remote').append(video);
  });
}
