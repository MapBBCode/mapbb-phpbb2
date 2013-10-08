##############################################################
## MOD Title: MapBBCode for subRebel
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Updates template files for [map] bbcode mod
## MOD Version: 1.0
##
## Installation Level: Easy
## Installation Time: 5 Minutes
## Files To Edit: 4
##                templates/subRebel/bbcode.tpl
##                templates/subRebel/posting_body.tpl
##                templates/subRebel/overall_header.tpl
##                templates/subRebel/simple_header.tpl
##
## License: http://www.wtfpl.net/ WTFPL
##############################################################
## Author Notes:
##    This MOD is written for phpBB 2.0.21 and not tested with other versions.
##    I think this mod is *NOT* EasyMOD friendly.
##############################################################
## MOD History:
##
##   2013-10-08 - Version 1.0
##      - initial release
##
##############################################################
## Before Adding This MOD To Your Forum, You Should Back Up All Files Related To This MOD
##############################################################

#
#-----[ OPEN ]------------------------------------------
#
templates/subRebel/bbcode.tpl
#
#-----[ FIND ]------------------------------------------
#
<!-- BEGIN email --><a href="mailto:{EMAIL}">{EMAIL}</A><!-- END email -->
#
#-----[ AFTER, ADD ]------------------------------------------
#

<!-- BEGIN map --><div id="map{DIVID}">{MAPBBCODE}</div><script language="javascript">mapBBcode.show('map{DIVID}');</script><!-- END map -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subRebel/posting_body.tpl
#
#-----[ FIND ]------------------------------------------
#
f_help = "{L_BBCODE_F_HELP}";
#
#-----[ AFTER, ADD ]------------------------------------------
#
map_help = "{L_BBCODE_MAP_HELP}";
#
#-----[ FIND ]------------------------------------------
#
			  <input type="button" class="button" accesskey="w" name="addbbcode16" value="URL" style="text-decoration: underline; width: 40px" onClick="bbstyle(16)" onMouseOver="helpline('w')" />
			  </span></td>
#
#-----[ AFTER, ADD ]------------------------------------------
#
			<td><span class="genmed"> 
			  <input type="button" class="button" accesskey="m" name="addbbcodemap" value="Map" style="width: 40px" onClick="mapBBcode.editorWindow(document.post.message)" onMouseOver="helpline('map')" />
			  </span></td>
#
#-----[ OPEN ]------------------------------------------
#
templates/subRebel/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
<!-- END switch_enable_pm_popup -->
#
#-----[ AFTER, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<link rel="stylesheet" href="includes/mapbbcode/leaflet.css" />
<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.css" />
<!--[if lte IE 8]>
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.ie.css" />
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.ie.css" />
<![endif]-->
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/leaflet.draw.js"></script>
<script src="includes/mapbbcode/Bing.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script language="Javascript" type="text/javascript">
<!--
function isTrue(val) {
	return val && val !== '0' && val !== 'false';
}

var mapBBcode = new MapBBCode({
	libPath: 'includes/mapbbcode/',
	layers: '{LAYERS}'.split(','),
	defaultZoom: {DEFAULT_ZOOM}+0,
	defaultPosition: [{DEFAULT_POS}],
	viewWidth: {VIEW_WIDTH}+0,
	viewHeight: {VIEW_HEIGHT}+0,
	fullViewHeight: {FULL_HEIGHT}+0,
	editorHeight: {EDITOR_HEIGHT}+0,
	windowWidth: {WINDOW_WIDTH}+0,
	windowHeight: {WINDOW_HEIGHT}+0,
	fullFromStart: isTrue('{ALWAYS_FULL}'),
	preferStandardLayerSwitcher: isTrue('{STANDARD_SWITCHER}'),
	hideInsideClasses: []
});
mapBBcode.setStrings({
	close: '{L_MAPBB_CLOSE}',
	remove: '{L_MAPBB_REMOVE}',
	apply: '{L_MAPBB_APPLY}',
	cancel: '{L_MAPBB_CANCEL}',
	title: '{L_MAPBB_TITLE}',
	bing: '{L_MAPBB_BING}',
	zoomInTitle: '{L_MAPBB_ZOOMINTITLE}',
	zoomOutTitle: '{L_MAPBB_ZOOMOUTTITLE}',
	applyTitle: '{L_MAPBB_APPLYTITLE}',
	cancelTitle: '{L_MAPBB_CANCELTITLE}',
	fullScreenTitle: '{L_MAPBB_FULLSCREENTITLE}',
	helpTitle: '{L_MAPBB_HELPTITLE}',
	outerTitle: '{L_MAPBB_OUTERTITLE}',
	polylineTitle: '{L_MAPBB_POLYLINETITLE}',
	polygonTitle: '{L_MAPBB_POLYGONTITLE}',
	markerTitle: '{L_MAPBB_MARKERTITLE}',
	drawCancelTitle: '{L_MAPBB_DRAWCANCELTITLE}',
	markerTooltip: '{L_MAPBB_MARKERTOOLTIP}',
	polylineStartTooltip: '{L_MAPBB_POLYLINESTARTTOOLTIP}',
	polylineContinueTooltip: '{L_MAPBB_POLYLINECONTINUETOOLTIP}',
	polylineEndTooltip: '{L_MAPBB_POLYLINEENDTOOLTIP}',
	polygonStartTooltip: '{L_MAPBB_POLYGONSTARTTOOLTIP}',
	polygonContinueTooltip: '{L_MAPBB_POLYGONCONTINUETOOLTIP}',
	polygonEndTooltip: '{L_MAPBB_POLYGONENDTOOLTIP}',
	helpContents: [{L_MAPBB_HELPCONTENTS}]
});
//-->
</script>
<!-- END switch_enable_mapbbcode -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subRebel/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
</head>
#
#-----[ BEFORE, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<link rel="stylesheet" href="includes/mapbbcode/leaflet.css" />
<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.css" />
<!--[if lte IE 8]>
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.ie.css" />
	<link rel="stylesheet" href="includes/mapbbcode/leaflet.draw.ie.css" />
<![endif]-->
<script src="includes/mapbbcode/leaflet.js"></script>
<script src="includes/mapbbcode/leaflet.draw.js"></script>
<script src="includes/mapbbcode/Bing.js"></script>
<script src="includes/mapbbcode/mapbbcode.js"></script>
<script src="includes/mapbbcode/mapbbcode-config.js"></script>
<script language="Javascript" type="text/javascript">
<!--
function isTrue(val) {
	return val && val !== '0' && val !== 'false';
}

var mapBBcode = new MapBBCode({
	libPath: 'includes/mapbbcode/',
	layers: '{LAYERS}'.split(','),
	defaultZoom: {DEFAULT_ZOOM}+0,
	defaultPosition: [{DEFAULT_POS}],
	viewWidth: {VIEW_WIDTH}+0,
	viewHeight: {VIEW_HEIGHT}+0,
	fullViewHeight: {FULL_HEIGHT}+0,
	editorHeight: {EDITOR_HEIGHT}+0,
	windowWidth: {WINDOW_WIDTH}+0,
	windowHeight: {WINDOW_HEIGHT}+0,
	fullFromStart: isTrue('{ALWAYS_FULL}'),
	preferStandardLayerSwitcher: isTrue('{STANDARD_SWITCHER}')
});
//-->
</script>
<!-- END switch_enable_mapbbcode -->
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
