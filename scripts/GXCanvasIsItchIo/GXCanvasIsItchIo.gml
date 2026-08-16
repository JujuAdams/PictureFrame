// feather ignore all

function GXCanvasIsItchIo() {
	static __onItchIO = string_starts_with(url_get_domain(), "html-classic.itch.zone") || string_starts_with(url_get_domain(), "itch.io");
	return __onItchIO;
}