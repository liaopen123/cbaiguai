class BookItem{
  String _firstLetter;
  String _content;
  int _position;

  BookItem(this._firstLetter, this._content,this._position);

  int get position => _position;

  set position(int value) {
    _position = value;
  }

  bool isTitleVisible(){
    return _firstLetter.isNotEmpty;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get firstLetter => _firstLetter;

  set firstLetter(String value) {
    _firstLetter = value;
  }


}