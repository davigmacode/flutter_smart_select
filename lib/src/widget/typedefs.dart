/// Callback for event modal will close
typedef S2ModalWillClose<T> = Future<bool> Function(T state);

/// Callback for event modal will open
typedef S2ModalWillOpen<T> = Future<bool> Function(T state);

/// Callback for event modal opened
typedef S2ModalOpen<T> = void Function(T state);

/// Callback for event modal closed
typedef S2ModalClose<T> = void Function(T state, bool confirmed);

/// Callback for event choice select
typedef S2ChoiceSelect<A, B> = void Function(A state, B choice);
