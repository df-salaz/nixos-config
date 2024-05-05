{ userSettings, ... }:
{
	programs.git = {
		enable = true;
		userEmail = userSettings.email;
		userName = userSettings.name;
	};
}
