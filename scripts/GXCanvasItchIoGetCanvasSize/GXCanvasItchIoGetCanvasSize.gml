// feather ignore all

function GXCanvasItchIoGetCanvasSize() {
	static _size = {
		width: 0,
		height: 0,
	};

	if (!GXCanvasIsItchIo()) return _size;
	_size.width = GXCanvasGetWindowInnerWidth();
	_size.height = GXCanvasGetWindowInnerHeight();
	return _size;
}