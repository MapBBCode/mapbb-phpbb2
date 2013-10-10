## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Adds [map] bbcode and its editor to phpBB 2
## MOD Version: 1.0
##
## Installation Level: Easy
## Installation Time: 15 Minutes
## Files To Edit: 10
##                posting.php
##                privmsg.php
##                viewtopic.php
##                includes/bbcode.php
##                includes/page_header.php
##                includes/topic_review.php
##                templates/subSilver/bbcode.tpl
##                templates/subSilver/posting_body.tpl
##                templates/subSilver/overall_header.tpl
##                templates/subSilver/simple_header.tpl
## Included Files: 5 + 16 js,css,png
##                db_install.php
##                language/lang_mapbbcode.php
##                language/lang_mapbbcode_russian.php
##                admin/admin_mapbbcode.php
##                templates/subSilver/admin/mapbbcode_body.tpl
##                includes/mapbbcode/*
##
## License: http://www.wtfpl.net/ WTFPL
##############################################################
## Author Notes:
##    This MOD was tested on phpBB 2.0.21 and 2.0.23.
##    And yes, it is EasyMOD friendly.
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
#-----[ COPY ]------------------------------------------------
#
copy root/language/lang_mapbbcode.php to language/lang_english/lang_mapbbcode.php
copy root/language/lang_mapbbcode_russian.php to language/lang_russian/lang_mapbbcode.php
copy root/admin/admin_mapbbcode.php to admin/admin_mapbbcode.php
copy root/templates/admin/mapbbcode_body.tpl to templates/subSilver/admin/mapbbcode_body.tpl
copy root/mapbbcode/leaflet.js to includes/mapbbcode/leaflet.js
copy root/mapbbcode/leaflet.css to includes/mapbbcode/leaflet.css
copy root/mapbbcode/leaflet.ie.css to includes/mapbbcode/leaflet.ie.css
copy root/mapbbcode/leaflet.draw.js to includes/mapbbcode/leaflet.draw.js
copy root/mapbbcode/leaflet.draw.css to includes/mapbbcode/leaflet.draw.css
copy root/mapbbcode/leaflet.draw.ie.css to includes/mapbbcode/leaflet.draw.ie.css
copy root/mapbbcode/Bing.js to includes/mapbbcode/Bing.js
copy root/mapbbcode/mapbbcode.js to includes/mapbbcode/mapbbcode.js
copy root/mapbbcode/mapbbcode-config.js to includes/mapbbcode/mapbbcode-config.js
copy root/mapbbcode/mapbbcode-window.html to includes/mapbbcode/mapbbcode-window.html
copy root/mapbbcode/images/layers.png to includes/mapbbcode/images/layers.png
copy root/mapbbcode/images/layers-2x.png to includes/mapbbcode/images/layers-2x.png
copy root/mapbbcode/images/marker-icon.png to includes/mapbbcode/images/marker-icon.png
copy root/mapbbcode/images/marker-icon-2x.png to includes/mapbbcode/images/marker-icon-2x.png
copy root/mapbbcode/images/marker-shadow.png to includes/mapbbcode/images/marker-shadow.png
copy root/mapbbcode/images/spritesheet.png to includes/mapbbcode/images/spritesheet.png
copy root/mapbbcode/images/spritesheet-2x.png to includes/mapbbcode/images/spritesheet-2x.png
#
#-----[ SQL ]------------------------------------------
#
# Upload and run as forum admin: db_install.php
#
# !!!!(Don't forget to delete db_install.php from the server after you have finished installing this mod!)!!!!
#
# or insert those records manually:
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_default_zoom','2');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_default_pos','22,11');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_view_width','600');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_view_height','300');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_full_height','600');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_always_full','');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_editor_height','400');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_window_width','800');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_window_height','500');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_editor_window','1');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_outer_link','');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_allowed_tags','[auib]|span|br|em|strong|tt');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_standard_switcher','1');
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_layers','OpenStreetMap');
#
#-----[ OPEN ]------------------------------------------
#
posting.php
#
#-----[ FIND ]------------------------------------------
#
generate_smilies('inline', PAGE_POSTING);
#
#-----[ AFTER, ADD ]------------------------------------------
#
$mapbbcode_present = TRUE;
#
#-----[ FIND ]------------------------------------------
#
	'L_EMPTY_MESSAGE' => $lang['Empty_message'],
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	'L_BBCODE_MAP_HELP' => $lang['bbcode_map_help'],
#
#-----[ OPEN ]------------------------------------------
#
viewtopic.php
#
#-----[ FIND ]------------------------------------------
#
$resync = FALSE; 
if ($forum_topic_data['topic_replies'] + 1 < $start + count($postrow))
#
#-----[ BEFORE, ADD ]------------------------------------------
#
// 
// Check if MapBBCode scripts need to be added to the header
//
$mapbbcode_present = FALSE;
for($i = 0; $i < $total_posts; $i++)
{
	if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $postrow[$i]['post_text'])) {
		$mapbbcode_present = TRUE;
		break;
	}
}

#
#-----[ OPEN ]------------------------------------------
#
privmsg.php
#
#-----[ FIND ]------------------------------------------
#
if ( $mode == 'newpm' )
{
#
#-----[ AFTER, ADD ]------------------------------------------
#
	$mapbbcode_present = TRUE;
#
#-----[ FIND ]------------------------------------------
#
	$page_title = $lang['Read_pm'];
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	$mapbbcode_present = preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $privmsg['privmsgs_text']);
#
#-----[ FIND ]------------------------------------------
#
	$page_title = $lang['Send_private_message'];
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	$mapbbcode_present = TRUE;
#
#-----[ FIND ]------------------------------------------
#
		'L_EMPTY_MESSAGE' => $lang['Empty_message'],
#
#-----[ BEFORE, ADD ]------------------------------------------
#
		'L_BBCODE_MAP_HELP' => $lang['bbcode_map_help'],
#
#-----[ OPEN ]------------------------------------------
#
includes/bbcode.php
#
#-----[ FIND ]------------------------------------------
#
	$bbcode_tpl['email'] = str_replace('{EMAIL}', '\\1', $bbcode_tpl['email']);
#
#-----[ AFTER, ADD ]------------------------------------------
#

	$bbcode_tpl['map'] = str_replace('{DIVID}', '\\2', $bbcode_tpl['map']);
	$bbcode_tpl['map'] = str_replace('{MAPBBCODE}', '\\1\\3', $bbcode_tpl['map']);
#
#-----[ FIND ]------------------------------------------
#
	$replacements[] = $bbcode_tpl['email'];
#
#-----[ AFTER, ADD ]------------------------------------------
#

	// [map]...[/map] code. First prepare individual codes
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
	$patterns[] = $mapre;
	$replacements[] = $bbcode_tpl['map'];
#
#-----[ OPEN ]------------------------------------------
#
includes/topic_review.php
#
#-----[ FIND ]------------------------------------------
#
	//
	// Dump out the page header and load viewtopic body template
#
#-----[ BEFORE, ADD ]------------------------------------------
#
	//
	// Check if MapBBCode scripts need to be added to the header
	// 
	$sql = "SELECT pt.post_text
		FROM " . POSTS_TABLE . " p, " . USERS_TABLE . " u, " . POSTS_TEXT_TABLE . " pt
		WHERE p.topic_id = $topic_id
			AND p.poster_id = u.user_id
			AND p.post_id = pt.post_id
		ORDER BY p.post_time DESC
		LIMIT " . $board_config['posts_per_page'];

	$mapbbcode_present = FALSE;
	if ( $result = $db->sql_query($sql) )
	{
		while ( $row = $db->sql_fetchrow($result) )
		{
			if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $row['post_text'])) {
				$mapbbcode_present = TRUE;
				break;
			}
		}
	}
	$db->sql_freeresult($result);

#
#-----[ OPEN ]------------------------------------------
#
includes/page_header.php
#
#-----[ FIND ]------------------------------------------
#
//
// Login box?
#
#-----[ BEFORE, ADD ]------------------------------------------
#
if( $mapbbcode_present )
{
	if ( @file_exists($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_mapbbcode.' . $phpEx) )
	{
		include($phpbb_root_path . 'language/lang_' . $board_config['default_lang'] . '/lang_mapbbcode.' . $phpEx);
	}
	else
	{
		include($phpbb_root_path . 'language/lang_english/lang_mapbbcode.' . $phpEx);
	}

	function mapbb_array_to_array($line) {
		return "'".str_replace("'", "\\'", str_replace("\\", "\\\\", $line))."'";
	}

	$template->assign_vars(array(
		'L_MAPBB_CLOSE' => $lang['MapBB_close'],
		'L_MAPBB_REMOVE' => $lang['MapBB_remove'],
		'L_MAPBB_APPLY' => $lang['MapBB_apply'],
		'L_MAPBB_CANCEL' => $lang['MapBB_cancel'],
		'L_MAPBB_TITLE' => $lang['MapBB_title'],
		'L_MAPBB_BING' => $lang['MapBB_bing'],
		'L_MAPBB_ZOOMINTITLE' => $lang['MapBB_zoomInTitle'],
		'L_MAPBB_ZOOMOUTTITLE' => $lang['MapBB_zoomOutTitle'],
		'L_MAPBB_APPLYTITLE' => $lang['MapBB_applyTitle'],
		'L_MAPBB_CANCELTITLE' => $lang['MapBB_cancelTitle'],
		'L_MAPBB_FULLSCREENTITLE' => $lang['MapBB_fullScreenTitle'],
		'L_MAPBB_HELPTITLE' => $lang['MapBB_helpTitle'],
		'L_MAPBB_OUTERTITLE' => $lang['MapBB_outerTitle'],
		'L_MAPBB_POLYLINETITLE' => $lang['MapBB_polylineTitle'],
		'L_MAPBB_POLYGONTITLE' => $lang['MapBB_polygonTitle'],
		'L_MAPBB_MARKERTITLE' => $lang['MapBB_markerTitle'],
		'L_MAPBB_DRAWCANCELTITLE' => $lang['MapBB_drawCancelTitle'],
		'L_MAPBB_MARKERTOOLTIP' => $lang['MapBB_markerTooltip'],
		'L_MAPBB_POLYLINESTARTTOOLTIP' => $lang['MapBB_polylineStartTooltip'],
		'L_MAPBB_POLYLINECONTINUETOOLTIP' => $lang['MapBB_polylineContinueTooltip'],
		'L_MAPBB_POLYLINEENDTOOLTIP' => $lang['MapBB_polylineEndTooltip'],
		'L_MAPBB_POLYGONSTARTTOOLTIP' => $lang['MapBB_polygonStartTooltip'],
		'L_MAPBB_POLYGONCONTINUETOOLTIP' => $lang['MapBB_polygonContinueTooltip'],
		'L_MAPBB_POLYGONENDTOOLTIP' => $lang['MapBB_polygonEndTooltip'],
		'L_MAPBB_HELPCONTENTS' => implode(',', array_map('mapbb_array_to_array', $lang['MapBB_helpContents'])),

		"LAYERS" => $board_config['mapbb_layers'],
		"DEFAULT_ZOOM" => $board_config['mapbb_default_zoom'],
		"DEFAULT_POS" => $board_config['mapbb_default_pos'],
		"VIEW_WIDTH" => $board_config['mapbb_view_width'],
		"VIEW_HEIGHT" => $board_config['mapbb_view_height'],
		"FULL_HEIGHT" => $board_config['mapbb_full_height'],
		"EDITOR_HEIGHT" => $board_config['mapbb_editor_height'],
		"WINDOW_WIDTH" => $board_config['mapbb_window_width'],
		"WINDOW_HEIGHT" => $board_config['mapbb_window_height'],
		"OUTER_LINK" => $board_config['mapbb_outer_link'],
		"ALWAYS_FULL" => $board_config['mapbb_always_full'] ? 'true' : 'false',
 		"STANDARD_SWITCHER" => $board_config['mapbb_standard_switcher'] ? 'true' : 'false',
 		"EDITOR_WINDOW" => $board_config['mapbb_editor_window'] ? 'true' : 'false',
		"ALLOWED_TAGS" => $board_config['mapbb_allowed_tags'])
	);
	$template->assign_block_vars('switch_enable_mapbbcode', array());
}

#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/bbcode.tpl
#
#-----[ FIND ]------------------------------------------
#
<!-- BEGIN img --><img src="{URL}" border="0" /><!-- END img -->
#
#-----[ AFTER, ADD ]------------------------------------------
#

<!-- BEGIN map --><div id="map{DIVID}">{MAPBBCODE}</div><script language="javascript">mapBBcode.show('map{DIVID}');</script><!-- END map -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/posting_body.tpl
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
# not needed if editor is always opened in a window
#
	  <td class="row2" valign="top"><span class="gen"> <span class="genmed"> </span>
#
#-----[ AFTER, ADD ]------------------------------------------
#
	  <div id="mapedit"></div>
#
#-----[ FIND ]------------------------------------------
#
			  <input type="button" class="button" accesskey="w" name="addbbcode16" value="URL" style="text-decoration: underline; width: 40px" onClick="bbstyle(16)" onMouseOver="helpline('w')" />
			  </span></td>
#
#-----[ AFTER, ADD ]------------------------------------------
#
			<td><span class="genmed"> 
			  <input type="button" class="button" accesskey="m" name="addbbcodemap" value="Map" style="width: 40px" onClick="{EDITOR_WINDOW} ? mapBBcode.editorWindow(document.post.message) : mapBBcode.editor('mapedit', document.post.message);" onMouseOver="helpline('map')" />
			  </span></td>
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
{META}
#
#-----[ BEFORE, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- END switch_enable_mapbbcode -->
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
	fullFromStart: {ALWAYS_FULL},
	preferStandardLayerSwitcher: {STANDARD_SWITCHER},
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
templates/subSilver/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
{META}
#
#-----[ BEFORE, ADD ]------------------------------------------
#
<!-- BEGIN switch_enable_mapbbcode -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- END switch_enable_mapbbcode -->
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
	fullFromStart: {ALWAYS_FULL},
	preferStandardLayerSwitcher: {STANDARD_SWITCHER}
});
//-->
</script>
<!-- END switch_enable_mapbbcode -->
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
