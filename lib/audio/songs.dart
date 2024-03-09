const List<Song> songs = [
  Song('theme_song.mp3', 'terradorians', artist: 'Telaron'),
  Song('free_run.mp3', 'Free Run', artist: 'TAD'),
  // Song('tropical_fantasy.mp3', 'Tropical Fantasy', artist: 'Spring Spring'),
];

class Song {
  final String filename;

  final String name;

  final String? artist;

  const Song(this.filename, this.name, {this.artist});

  @override
  String toString() => 'Song<$filename>';
}
