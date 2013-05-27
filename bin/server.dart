import 'package:speaker/server.dart';

void main() {
  new SpeakerServer()..listen('127.0.0.1', 3001);
}