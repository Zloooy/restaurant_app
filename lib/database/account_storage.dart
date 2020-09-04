import "models/account.dart";
class AccountStorage
{
	static AccountStorage _instance = AccountStorage._create();
	Account _currentAccount;
	factory AccountStorage() => _instance;
	AccountStorage._create()
	{
		_currentAccount = new Account(
				id: "1",
				name: "Вася Пупкин",
				role: Account.REGULAR_USER,
				avatarPath: "assets/avatar_sample.png"
				);
	}
	Account getCurrentAccount() => _currentAccount;
}
