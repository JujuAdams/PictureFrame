function GXCanvasGetCanvasCSSWidth() {
	return parseInt(canvasElement.style.width);
}

function GXCanvasGetCanvasCSSHeight() {
	return parseInt(canvasElement.style.height);
}

function GXCanvasSetCanvasCSSSize(width, height) {
	canvasElement.style.width = width + "px";
	canvasElement.style.height = height + "px";
}

function GXCanvasSetCanvasSize(width, height) {
	canvasElement.width = width;
	canvasElement.height = height;
}

function GXCanvasGetWindowInnerWidth() {
	return window.innerWidth;
}

function GXCanvasGetWindowInnerHeight() {
	return window.innerHeight;
}

function GXCanvasGetScreenWidth() {
	return screen.width;
}

function GXCanvasGetScreenHeight() {
	return screen.height;
}

function GXCanvasGetCanvasWidth() {
	return canvasElement.width;
}

function GXCanvasGetCanvasHeight() {
	return canvasElement.height;
}

function GXCanvasSetStyleProperty(style, value) {
	canvasElement.style[style] = value;
}

function GXCanvasGetStyleProperty(style) {
	return canvasElement.style[style];
}

function GXCanvasGetStyle() {
	return canvasElement.style;
}

function GXCanvasSetStyle(style) {
	for(entry in style) {
		canvasElement.style[entry] = style[entry];
	}
}

function __GXCanvasInit() {
	console.log("GXCanvas, initialised! By TabularElf - https://tabelf.link/");
	// Deleting aspect ratio correction
	g_GXCanvasInit = true;
}

function GXCanvasRemoveOutputContainer() {
	var GXCanvas_output_container = document.getElementById("output-container");
	GXCanvas_output_container.remove();
	return true;
}