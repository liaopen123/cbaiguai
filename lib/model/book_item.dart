class BookItem{
  String _firstLetter;
  String _content;
  int _position;
  bool titleVisible;

  BookItem(this._firstLetter, this._content,this._position,this.titleVisible);

  int get position => _position;

  set position(int value) {
    _position = value;
  }

  bool isTitleVisible(){
    return titleVisible;
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