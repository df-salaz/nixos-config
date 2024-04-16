let configDir = ../config;
in {
	home.file = {
		".config/discocss".source = "${configDir}/discocss";
	};
}

