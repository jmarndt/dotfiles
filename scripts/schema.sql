CREATE TABLE IF NOT EXISTS packages (
	package_id INTEGER PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	for_server BOOLEAN NOT NULL,
	for_work BOOLEAN NOT NULL,
	apt TEXT,
    dnf TEXT,
	brew TEXT,
	flatpak TEXT
);

CREATE TABLE IF NOT EXISTS dotfiles (
	dotfile_id INTEGER PRIMARY KEY,
	name TEXT NOT NULL UNIQUE,
	target TEXT NOT NULL,
	config TEXT NOT NULL
);
