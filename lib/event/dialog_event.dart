class DialogChangeEvent {
  bool show = false;
  String msg;

  DialogChangeEvent(this.show, this.msg);

  DialogChangeEvent.showChanged(this.show);
}
