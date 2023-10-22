import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlocBase {
  void dispose();
}

abstract class BlocBaseWithState<ScreenState> extends BlocBase {
  late final BehaviorSubject<ScreenState> _state;

  ScreenState? get currentState => _state.valueOrNull;

  Stream<ScreenState> get state => _state;

  BlocBaseWithState() {
    _state = BehaviorSubject<ScreenState>(
      onListen: () => doOnStateListen(),
      onCancel: () => doOnStateStopListen(),
    );
  }

  void doOnStateListen() {
    // Start subscriptions here
    // Can be called multiple times
  }

  void doOnStateStopListen() {
    // Pause subscriptions here
    // Can be called multiple times
  }

  void setState(ScreenState newState) {
    if (_state.isClosed) return;
    _state.add(newState);
  }

  void updateState() {
    final state = currentState;
    if (state != null) setState(state);
  }

  @override
  @mustCallSuper
  void dispose() {
    _state.close();
  }
}