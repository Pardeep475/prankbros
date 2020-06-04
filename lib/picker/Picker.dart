import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Dialog;
import 'dart:async';

const bool __printDebug = false;

/// Picker selected callback.
typedef PickerSelectedCallback = void Function(
    Picker picker, int index, List<int> selecteds);

/// Picker confirm callback.
typedef PickerConfirmCallback = void Function(
    Picker picker, List<int> selecteds);

/// Picker value format callback.
typedef PickerValueFormat<T> = String Function(T value);

/// Picker
class Picker {
  static const double DefaultTextSize = 20.0;

  /// Index of currently selected items
  List<int> selecteds;

  /// Picker adapter, Used to provide data and generate widgets
  final PickerAdapter adapter;

  /// insert separator before picker columns
  final List<PickerDelimiter> delimiter;

  final VoidCallback onCancel;
  final PickerSelectedCallback onSelect;
  final PickerConfirmCallback onConfirm;

  /// When the previous level selection changes, scroll the child to the first item.
  final changeToFirst;

  /// Specify flex for each column
  final List<int> columnFlex;

  final Widget title;
  final Widget cancel;
  final Widget confirm;
  final String cancelText;
  final String confirmText;

  final double height;

  /// Height of list item
  final double itemExtent;

  final TextStyle textStyle,
      cancelTextStyle,
      confirmTextStyle,
      selectedTextStyle;
  final TextAlign textAlign;

  /// Text scaling factor
  final double textScaleFactor;

  final EdgeInsetsGeometry columnPadding;
  final Color backgroundColor, headercolor, containerColor;

  /// Hide head
  final bool hideHeader;

  /// Show pickers in reversed order
  final bool reversedOrder;

  /// Generate a custom header， [hideHeader] = true
  final WidgetBuilder builderHeader;

  /// List item loop
  final bool looping;

  /// Delay generation for smoother animation, This is the number of milliseconds to wait. It is recommended to > = 200
  final int smooth;

  final Widget footer;

  final Decoration headerDecoration;

  final double magnification;
  final double diameterRatio;
  final double squeeze;

  Widget _widget;
  PickerWidgetState _state;

  Picker(
      {this.adapter,
      this.delimiter,
      this.selecteds,
      this.height = 200.0,
      this.itemExtent = 50.0,
      this.columnPadding,
      this.textStyle,
      this.cancelTextStyle,
      this.confirmTextStyle,
      this.selectedTextStyle,
      this.textAlign = TextAlign.start,
      this.textScaleFactor,
      this.title,
      this.cancel,
      this.confirm,
      this.cancelText,
      this.confirmText,
      this.backgroundColor = Colors.white,
      this.containerColor,
      this.headercolor,
      this.builderHeader,
      this.changeToFirst = false,
      this.hideHeader = false,
      this.looping = false,
      this.reversedOrder = false,
      this.headerDecoration,
      this.columnFlex,
      this.footer,
      this.smooth,
      this.magnification = 1.0,
      this.diameterRatio = 2.5,
      this.squeeze = 1.25,
      this.onCancel,
      this.onSelect,
      this.onConfirm})
      : assert(adapter != null);

  Widget get widget => _widget;

  PickerWidgetState get state => _state;
  int _maxLevel = 1;

  /// 生成picker控件
  /// Build picker control
  Widget makePicker([ThemeData themeData, bool isModal = false]) {
    _maxLevel = adapter.maxLevel;
    adapter.picker = this;
    adapter.initSelects();
    _widget =
        _PickerWidget(picker: this, themeData: themeData, isModal: isModal);
    return _widget;
  }

  /// show picker
  void show(ScaffoldState state, [ThemeData themeData]) {
    state.showBottomSheet((BuildContext context) {
      return makePicker(themeData);
    });
  }

  /// Display modal picker
  Future<T> showModal<T>(BuildContext context, [ThemeData themeData]) async {
    return await showModalBottomSheet<T>(
        context: context, //state.context,
        builder: (BuildContext context) {
          return makePicker(themeData, true);
        });
  }

  /// show dialog picker
  Future<List<int>> showDialog(BuildContext context,
      {bool barrierDismissible = true, Key key}) {
    return Dialog.showDialog<List<int>>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          List<Widget> actions = [];

          if (cancel == null) {
            String _cancelText = cancelText;
            if (_cancelText != null && _cancelText != "") {
              actions.add(FlatButton(
                  onPressed: () {
                    Navigator.pop<List<int>>(context, null);
                    if (onCancel != null) onCancel();
                  },
                  child: cancelTextStyle == null
                      ? Text(_cancelText)
                      : DefaultTextStyle(
                          child: Text(_cancelText), style: cancelTextStyle)));
            }
          } else {
            actions.add(cancel);
          }

          if (confirm == null) {
            String _confirmText = confirmText;
            if (_confirmText != null && _confirmText != "") {
              actions.add(FlatButton(
                  onPressed: () {
                    Navigator.pop<List<int>>(context, selecteds);
                    if (onConfirm != null) onConfirm(this, selecteds);
                  },
                  child: confirmTextStyle == null
                      ? Text(_confirmText)
                      : DefaultTextStyle(
                          child: Text(_confirmText), style: confirmTextStyle)));
            }
          } else {
            actions.add(confirm);
          }

          return AlertDialog(
            key: key ?? Key('picker-dialog'),
            title: title,
            actions: actions,
            content: makePicker(),
          );
        });
  }

  /// Get the value of the current selection
  List getSelectedValues() {
    return adapter.getSelectedValues();
  }

  void doCancel(BuildContext context) {
    if (onCancel != null) onCancel();
    Navigator.of(context).pop<List<int>>(null);
    _widget = null;
  }

  void doConfirm(BuildContext context) {
    if (onConfirm != null) onConfirm(this, selecteds);
    Navigator.of(context).pop();
    _widget = null;
  }

  void updateColumn(int index, [bool all = false]) {
    if (all) {
      _state.update();
      return;
    }
    adapter.setColumn(index - 1);
    _state._keys[index].currentState.update();
  }
}

class PickerDelimiter {
  final Widget child;
  final int column;

  PickerDelimiter({this.child, this.column = 1}) : assert(child != null);
}

/// picker data list item
class PickerItem<T> {
  final Widget text;

  final T value;

  final List<PickerItem<T>> children;

  PickerItem({this.text, this.value, this.children});
}

class _PickerWidget<T> extends StatefulWidget {
  final Picker picker;
  final ThemeData themeData;
  final bool isModal;

  _PickerWidget(
      {Key key, @required this.picker, @required this.themeData, this.isModal})
      : super(key: key);

  @override
  PickerWidgetState createState() =>
      PickerWidgetState<T>(picker: this.picker, themeData: this.themeData);
}

class PickerWidgetState<T> extends State<_PickerWidget> {
  final Picker picker;
  final ThemeData themeData;

  PickerWidgetState({Key key, @required this.picker, @required this.themeData});

  ThemeData theme;
  final List<FixedExtentScrollController> scrollController = [];
  final List<GlobalKey<_StateViewState>> _keys = [];

  @override
  void initState() {
    super.initState();
    theme = themeData;
    picker._state = this;
    picker.adapter.doShow();

    if (scrollController.length == 0) {
      for (int i = 0; i < picker._maxLevel; i++) {
        scrollController
            .add(FixedExtentScrollController(initialItem: picker.selecteds[i]));
        _keys.add(GlobalKey(debugLabel: i.toString()));
      }
    }
  }

  void update() {
    setState(() {});
  }

  // var ref = 0;
  @override
  Widget build(BuildContext context) {
    // print("picker build ${ref++}");
    if (_wait && picker.smooth != null && picker.smooth > 0) {
      Future.delayed(Duration(milliseconds: picker.smooth), () {
        if (!_wait) return;
        setState(() {
          _wait = false;
        });
      });
    } else
      _wait = false;

    var _body = <Widget>[];

    _body.add(_wait
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildViews(),
          )
        : AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildViews(),
            ),
          ));

    if (picker.footer != null) _body.add(picker.footer);
    Widget v = Column(
      mainAxisSize: MainAxisSize.min,
      children: _body,
    );
    if (widget.isModal != null && widget.isModal) {
      return GestureDetector(
        onTap: () {},
        child: v,
      );
    }
    return v;
  }

  bool _changeing = false;
  bool _wait = true;
  final Map<int, int> lastData = {};

  List<Widget> _buildViews() {
    if (__printDebug) print("_buildViews");
    if (theme == null) theme = Theme.of(context);

    List<Widget> items = [];

    PickerAdapter adapter = picker.adapter;
    if (adapter != null) adapter.setColumn(-1);

    if (adapter != null && adapter.length > 0) {
      var _decoration = BoxDecoration(
        color: picker.containerColor == null
            ? theme.dialogBackgroundColor
            : picker.containerColor,
      );

      for (int i = 0; i < picker._maxLevel; i++) {
        Widget view = Expanded(
          flex: adapter.getColumnFlex(i),
          child: Container(
            padding: picker.columnPadding,
            height: picker.height,
            decoration: _decoration,
            child: _wait
                ? null
                : _StateView(
                    key: _keys[i],
                    builder: (context) {
                      adapter.setColumn(i - 1);
                      var _length = adapter.length;
                      var _view = CupertinoPicker.builder(
                        backgroundColor: picker.backgroundColor,
                        scrollController: scrollController[i],
                        itemExtent: picker.itemExtent,
                        magnification: picker.magnification,
                        diameterRatio: picker.diameterRatio,
                        squeeze: picker.squeeze,
                        onSelectedItemChanged: (int _index) {
                          if (__printDebug) print("onSelectedItemChanged");
                          if (_length <= 0) return;
                          var index = _index % _length;
                          picker.selecteds[i] = index;
                          updateScrollController(i);
                          adapter.doSelect(i, index);
                          if (picker.changeToFirst) {
                            for (int j = i + 1;
                                j < picker.selecteds.length;
                                j++) {
                              picker.selecteds[j] = 0;
                              scrollController[j].jumpTo(0.0);
                            }
                          }
                          if (picker.onSelect != null)
                            picker.onSelect(picker, i, picker.selecteds);

                          if (adapter.needUpdatePrev(i))
                            setState(() {});
                          else {
                            _keys[i].currentState.update();
                            if (adapter.isLinkage) {
                              for (int j = i + 1;
                                  j < picker.selecteds.length;
                                  j++) {
                                if (j == i) continue;
                                adapter.setColumn(j - 1);
                                _keys[j].currentState.update();
                              }
                            }
                          }
                        },
                        itemBuilder: (context, index) {
                          adapter.setColumn(i - 1);
                          return adapter.buildItem(context, index % _length);
                        },
                        childCount: picker.looping ? null : _length,
                      );

                      if (!picker.changeToFirst &&
                          picker.selecteds[i] >= _length) {
                        Timer(Duration(milliseconds: 100), () {
                          if (__printDebug) print("timer last");
                          adapter.setColumn(i - 1);
                          var _len = adapter.length;
                          var _index = (_len < _length ? _len : _length) - 1;
                          scrollController[i]?.jumpToItem(_index);
                        });
                      }

                      return _view;
                    },
                  ),
          ),
        );
        items.add(view);
      }
    }

    if (picker.delimiter != null && !_wait) {
      for (int i = 0; i < picker.delimiter.length; i++) {
        var o = picker.delimiter[i];
        if (o.child == null) continue;
        var item = Container(child: o.child, height: picker.height);
        if (o.column < 0)
          items.insert(0, item);
        else if (o.column >= items.length)
          items.add(item);
        else
          items.insert(o.column, item);
      }
    }

    if (picker.reversedOrder) return items.reversed.toList();

    return items;
  }

  void updateScrollController(int i) {
    if (_changeing || !picker.adapter.isLinkage) return;
    _changeing = true;
    for (int j = 0; j < picker.selecteds.length; j++) {
      if (j != i) {
        if (scrollController[j].position.maxScrollExtent == null) continue;
        scrollController[j].position.notifyListeners();
      }
    }
    _changeing = false;
  }
}

abstract class PickerAdapter<T> {
  Picker picker;

  int getLength();

  int getMaxLevel();

  void setColumn(int index);

  void initSelects();

  Widget buildItem(BuildContext context, int index);

  /// Need to update previous columns
  bool needUpdatePrev(int curIndex) {
    return false;
  }

  Widget makeText(Widget child, String text, bool isSel) {
    return new Center(
        //alignment: Alignment.center,
        child: DefaultTextStyle(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: picker.textAlign,
            style: picker.textStyle ??
                TextStyle(
                    color: Colors.black87, fontSize: Picker.DefaultTextSize),
            child: child != null
                ? child
                : Text(text,
                    textScaleFactor: picker.textScaleFactor,
                    style: (isSel ? picker.selectedTextStyle : null))));
  }

  Widget makeTextEx(
      Widget child, String text, Widget postfix, Widget suffix, bool isSel) {
    List<Widget> items = [];
    if (postfix != null) items.add(postfix);
    items.add(
        child ?? Text(text, style: (isSel ? picker.selectedTextStyle : null)));
    if (suffix != null) items.add(suffix);

    var _txtColor = Colors.black87;
    var _txtSize = Picker.DefaultTextSize;
    if (isSel && picker.selectedTextStyle != null) {
      if (picker.selectedTextStyle.color != null)
        _txtColor = picker.selectedTextStyle.color;
      if (picker.selectedTextStyle.fontSize != null)
        _txtSize = picker.selectedTextStyle.fontSize;
    }

    return new Center(
        //alignment: Alignment.center,
        child: DefaultTextStyle(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: picker.textAlign,
            style: picker.textStyle ??
                TextStyle(color: _txtColor, fontSize: _txtSize),
            child: Wrap(
              children: items,
            )));
  }

  String getText() {
    return getSelectedValues().toString();
  }

  List<T> getSelectedValues() {
    return [];
  }

  void doShow() {}

  void doSelect(int column, int index) {}

  int getColumnFlex(int column) {
    if (picker.columnFlex != null && column < picker.columnFlex.length)
      return picker.columnFlex[column];
    return 1;
  }

  int get maxLevel => getMaxLevel();

  /// Content length of current column
  int get length => getLength();

  String get text => getText();

  bool get isLinkage => getIsLinkage();

  @override
  String toString() {
    return getText();
  }

  bool getIsLinkage() {
    return true;
  }

  void notifyDataChanged() {
    if (picker != null && picker.state != null) {
      picker.adapter.doShow();
      picker.adapter.initSelects();
      for (int j = 0; j < picker.selecteds.length; j++) {
        picker.state.scrollController[j].jumpToItem(picker.selecteds[j]);
      }
    }
  }
}

class PickerDataAdapter<T> extends PickerAdapter<T> {
  List<PickerItem<T>> data;
  List<PickerItem<dynamic>> _datas;
  int _maxLevel = -1;
  int _col = 0;
  final bool isArray;

  PickerDataAdapter({List pickerdata, this.data, this.isArray = false}) {
    _parseData(pickerdata);
  }

  @override
  bool getIsLinkage() {
    return !isArray;
  }

  void _parseData(final List pickerData) {
    if (pickerData != null &&
        pickerData.length > 0 &&
        (data == null || data.length == 0)) {
      if (data == null) data = List<PickerItem<T>>();
      if (isArray) {
        _parseArrayPickerDataItem(pickerData, data);
      } else {
        _parsePickerDataItem(pickerData, data);
      }
    }
  }

  _parseArrayPickerDataItem(List pickerData, List<PickerItem> data) {
    if (pickerData == null) return;
    var len = pickerData.length;
    for (int i = 0; i < len; i++) {
      var v = pickerData[i];
      if (!(v is List)) continue;
      List lv = v;
      if (lv.length == 0) continue;

      PickerItem item = PickerItem<T>(children: List<PickerItem<T>>());
      data.add(item);

      for (int j = 0; j < lv.length; j++) {
        var o = lv[j];
        if (o is T) {
          item.children.add(PickerItem<T>(value: o));
        } else if (T == String) {
          String _v = o.toString();
          item.children.add(PickerItem<T>(value: _v as T));
        }
      }
    }
    if (__printDebug) print("data.length: ${data.length}");
  }

  _parsePickerDataItem(List pickerData, List<PickerItem> data) {
    if (pickerData == null) return;
    var len = pickerData.length;
    for (int i = 0; i < len; i++) {
      var item = pickerData[i];
      if (item is T) {
        data.add(new PickerItem<T>(value: item));
      } else if (item is Map) {
        final Map map = item;
        if (map.length == 0) continue;

        List<T> _mapList = map.keys.toList();
        for (int j = 0; j < _mapList.length; j++) {
          var _o = map[_mapList[j]];
          if (_o is List && _o.length > 0) {
            List<PickerItem> _children = new List<PickerItem<T>>();
            //print('add: ${data.runtimeType.toString()}');
            data.add(
                new PickerItem<T>(value: _mapList[j], children: _children));
            _parsePickerDataItem(_o, _children);
          }
        }
      } else if (T == String && !(item is List)) {
        String _v = item.toString();
        //print('add: $_v');
        data.add(new PickerItem<T>(value: _v as T));
      }
    }
  }

  void setColumn(int index) {
    if (_datas != null && _col == index + 1) return;
    _col = index + 1;
    if (isArray) {
      if (__printDebug) print("index: $index");
      if (_col < data.length)
        _datas = data[_col].children;
      else
        _datas = null;
      return;
    }
    if (index < 0) {
      _datas = data;
    } else {
      _datas = data;
      for (int i = 0; i <= index; i++) {
        var j = picker.selecteds[i];
        if (_datas != null && _datas.length > j)
          _datas = _datas[j].children;
        else {
          _datas = null;
          break;
        }
      }
    }
  }

  @override
  int getLength() {
    return _datas == null ? 0 : _datas.length;
  }

  @override
  getMaxLevel() {
    if (_maxLevel == -1) _checkPickerDataLevel(data, 1);
    return _maxLevel;
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    final PickerItem item = _datas[index];
    if (item.text != null) {
      return item.text;
    }
    return makeText(item.text, item.text != null ? null : item.value.toString(),
        index == picker.selecteds[_col]);
  }

  @override
  void initSelects() {
    if (picker.selecteds == null || picker.selecteds.length == 0) {
      if (picker.selecteds == null) picker.selecteds = new List<int>();
      for (int i = 0; i < _maxLevel; i++) picker.selecteds.add(0);
    }
  }

  @override
  List<T> getSelectedValues() {
    List<T> _items = [];
    if (picker.selecteds != null) {
      var _sLen = picker.selecteds.length;
      if (isArray) {
        for (int i = 0; i < _sLen; i++) {
          int j = picker.selecteds[i];
          if (j < 0 || data[i].children == null || j >= data[i].children.length)
            break;
          _items.add(data[i].children[j].value);
        }
      } else {
        List<PickerItem<dynamic>> datas = data;
        for (int i = 0; i < _sLen; i++) {
          int j = picker.selecteds[i];
          if (j < 0 || j >= datas.length) break;
          _items.add(datas[j].value);
          datas = datas[j].children;
          if (datas == null || datas.length == 0) break;
        }
      }
    }
    return _items;
  }

  _checkPickerDataLevel(List<PickerItem> data, int level) {
    if (data == null) return;
    if (isArray) {
      _maxLevel = data.length;
      return;
    }
    for (int i = 0; i < data.length; i++) {
      if (data[i].children != null && data[i].children.length > 0)
        _checkPickerDataLevel(data[i].children, level + 1);
    }
    if (_maxLevel < level) _maxLevel = level;
  }
}

class NumberPickerColumn {
  final List<int> items;
  final int begin;
  final int end;
  final int initValue;
  final int columnFlex;
  final int jump;
  final Widget postfix, suffix;
  final PickerValueFormat<int> onFormatValue;

  const NumberPickerColumn({
    this.begin = 0,
    this.end = 9,
    this.items,
    this.initValue,
    this.jump = 1,
    this.columnFlex = 1,
    this.postfix,
    this.suffix,
    this.onFormatValue,
  }) : assert(jump != null);

  int indexOf(int value) {
    if (value == null) return -1;
    if (items != null) return items.indexOf(value);
    if (value < begin || value > end) return -1;
    return (value - begin) ~/ (this.jump == 0 ? 1 : this.jump);
  }

  int valueOf(int index) {
    if (items != null) {
      return items[index];
    }
    return begin + index * (this.jump == 0 ? 1 : this.jump);
  }

  String getValueText(int index) {
    return onFormatValue == null
        ? "${valueOf(index)}"
        : onFormatValue(valueOf(index));
  }

  int count() {
    var v = (end - begin) ~/ (this.jump == 0 ? 1 : this.jump) + 1;
    if (v < 1) return 0;
    return v;
  }
}

class NumberPickerAdapter extends PickerAdapter<int> {
  NumberPickerAdapter({this.data}) : assert(data != null);

  final List<NumberPickerColumn> data;
  NumberPickerColumn cur;
  int _col = 0;

  @override
  int getLength() {
    if (cur == null) return 0;
    if (cur.items != null) return cur.items.length;
    return cur.count();
  }

  @override
  int getMaxLevel() {
    return data == null ? 0 : data.length;
  }

  @override
  bool getIsLinkage() {
    return false;
  }

  @override
  void setColumn(int index) {
    if (index != -1 && _col == index + 1) return;
    _col = index + 1;
    if (_col >= data.length) {
      cur = null;
    } else {
      cur = data[_col];
    }
  }

  @override
  void initSelects() {
    int _maxLevel = getMaxLevel();
    if (picker.selecteds == null || picker.selecteds.length == 0) {
      if (picker.selecteds == null) picker.selecteds = new List<int>();
      for (int i = 0; i < _maxLevel; i++) {
        int v = data[i].indexOf(data[i].initValue);
        if (v < 0) v = 0;
        picker.selecteds.add(v);
      }
    }
  }

  @override
  Widget buildItem(BuildContext context, int index) {
    if (cur.postfix == null && cur.suffix == null) {
      return makeText(
          null, cur.getValueText(index), index == picker.selecteds[_col]);
    } else {
      return makeTextEx(null, cur.getValueText(index), cur.postfix, cur.suffix,
          index == picker.selecteds[_col]);
    }
  }

  @override
  int getColumnFlex(int column) {
    return data[column].columnFlex;
  }

  @override
  List<int> getSelectedValues() {
    List<int> _items = [];
    if (picker.selecteds != null) {
      for (int i = 0; i < picker.selecteds.length; i++) {
        int j = picker.selecteds[i];
        int v = data[i].valueOf(j);
        _items.add(v);
      }
    }
    return _items;
  }
}

class _StateView extends StatefulWidget {
  final WidgetBuilder builder;

  const _StateView({Key key, this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateViewState();
}

class _StateViewState extends State<_StateView> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  update() {
    setState(() {});
  }
}
