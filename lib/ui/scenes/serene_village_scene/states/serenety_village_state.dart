class SerenetyVillageState {
  int _piesCounter = 0;
  int get piesCount => _piesCounter;
  void increasePies() => _piesCounter++;
  void decreasePies() => _piesCounter--;

  int _friendsCounter = 0;
  int get friendsCount => _friendsCounter;
  void increaseFriends() => _friendsCounter++;
  void decreaseFriends() => _friendsCounter--;
  static const int _maxFriends = 2;

  bool get isMaxFriensNumberReached {
    return _friendsCounter >= _maxFriends;
  }
}
