import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:speaker/client.dart';

void main() {
  useShadowDom = true;

  var speaker = new SpeakerClient('ws://127.0.0.1:3001', room: 'room');

  speaker.createStream(video: true).then((stream) {
    var video = new VideoElement()
      ..autoplay = true
      ..src = Url.createObjectUrl(stream);

    document.query('#local').append(video);
  });

  speaker.onAdd.listen((message) {
    var video = new VideoElement()
      ..id = 'remote${message['id']}'
      ..autoplay = true
      ..src = Url.createObjectUrl(message['stream']);

    document.query('#remote').append(video);

    document.query('#chat').onChange.where((e) => e.target.value != '').listen((e) {
      speaker.send(e.target.value);
      e.target.value = '';
    });
  });

  speaker.onData.listen((message) {
    print(message['data']);
  });

  speaker.onLeave.listen((message) {
    var video = document.query('#remote${message['id']}');
    if (video != null) {
      video.remove();
    }
  });
}
