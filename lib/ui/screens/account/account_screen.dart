import "package:flutter/material.dart";
import "package:restaurant_app/database/models/account.dart";
import "package:restaurant_app/temporary_blocs/account_bloc.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
class AccountScreen extends StatefulWidget
{
	AccountScreen({Key key}): super(key:key);
	@override
	_AccountScreenState createState() => new _AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen>
{
	AccountBloc _bloc = new AccountBloc();
	_AccountScreenState();
	@override
	void initState()
	{
		super.initState();
		_bloc.updateAccount();
	}
	@override
	void dispose()
	{
		super.dispose();
		_bloc.dispose();
	}
	@override
	Widget build(BuildContext context) =>
		Scaffold(
				appBar:AppBar(
						title: Text("Аккаунт"),
						),
				body:StreamBuilder<Account>(
				  stream: _bloc.accountStream,
				  builder: (context, snapshot) {
					  if (snapshot.hasData) return Column(children:
						    [
							    CircleAvatar(radius: 40.dp, backgroundImage: snapshot.data.avatar),
							    
							    Padding(
							      padding: EdgeInsets.all(5.dp),
							      child: Align(
									    alignment:Alignment.topLeft,
							        child: Wrap(
										alignment:WrapAlignment.start,
									direction:Axis.vertical,	
									spacing:5.dp,
									    children:
									    [
							        Text(snapshot.data.name,
										style:Theme.of(context).textTheme.headline6),
							        Text(snapshot.data.role,
									style: Theme.of(context).textTheme.subtitle2	)
									    ]
							        ),
							      ),
							    )
						    ]
						    );
					  else return SizedBox();
				  }
				)
				);

}
