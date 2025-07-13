class CacheManager {
  final _storyCache = <String, String>{};
  final _artCache = <String, Uint8List>{};

  Future<String> getStoryFromCache(String key) async {
    if (_storyCache.containsKey(key)) {
      return _storyCache[key]!;
    } else {
      final newStory = await StoryEngine().generateStory(...);
      _storyCache[key] = newStory;
      return newStory;
    }
  }

  Future<Uint8List> getArtFromCache(String key) async {
    if (_artCache.containsKey(key)) {
      return _artCache[key]!;
    } else {
      final newArt = await StoryEngine().generatePixelArt(...);
      _artCache[key] = newArt;
      return newArt;
    }
  }
}
