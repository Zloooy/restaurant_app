import "package:rxdart/rxdart.dart";
import "package:restaurant_app/database/models/account.dart";
import "package:restaurant_app/database/account_storage.dart";

class AccountBloc {
  AccountStorage _db;
  BehaviorSubject<Null> _accountUpdateHandler;
  Stream<Account?>? _accountStream;
  AccountBloc()
      : _db = AccountStorage(),
        _accountUpdateHandler = new BehaviorSubject<Null>() {
    _accountStream = _accountUpdateHandler.map((_) => _db.getCurrentAccount());
  }
  Stream<Account?>? get accountStream => _accountStream;
  void updateAccount() => _accountUpdateHandler.sink.add(null);
  void dispose() {
    _accountUpdateHandler.close();
  }
}
