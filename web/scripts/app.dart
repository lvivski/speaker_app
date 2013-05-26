import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:speak/client.dart';
import '../components/xplayer.dart';

// initial value for click-counter
int startingCount = 0;

void main() {
  // Enable this to use Shadow DOM in the browser.
  useShadowDom = true;

  var speak = new SpeakClient("ws://127.0.0.1:3001");

  speak.createStream((stream) {
    var video = new VideoElement()
    ..autoplay = true
    ..src = Url.createObjectUrl(stream);

    document.query('#local').append(video);
  });

  speak.on('add', (e) {
    var video = new VideoElement()
    ..autoplay = true
    ..src = Url.createObjectUrl(e['data'].stream);

    document.query('#remote').append(video);
  });

}
