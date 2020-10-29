import '../../graphx/events/mixins.dart';
import '../../graphx/events/signal_data.dart';
import 'updatable.dart';

class GxTween with IUpdatable, JugglerSignalMixin {
  Object target;
  double duration;
  JugglerObjectEventData _eventData;

  bool get isComplete => false;
  GxTween nextTween;

  /// todo: add

  GxTween(Object target, double time) {
    _eventData = JugglerObjectEventData(this);
    reset(target, time);
  }

  GxTween reset(Object target, double time) {
    target = target;
    duration = time;
    return this;
  }

  @override
  void update(double delta) {}

  static List<GxTween> _pool = [];
  static void toPool(GxTween obj) {
    /// reset all references to make sure is garbage collected.
    obj.target = null;
    obj.$onRemovedFromJuggler?.removeAll();
    _pool.add(obj);
  }

  static GxTween fromPool(Object target, double time) {
    if (_pool.isNotEmpty) return _pool.removeLast().reset(target, time);
    return GxTween(target, time);
  }
}