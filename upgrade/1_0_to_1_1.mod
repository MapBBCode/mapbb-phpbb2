## EasyMOD compliant
##############################################################
## MOD Title: MapBBCode
## MOD Author: Zverik <zverik@textual.ru> (Ilya Zverev)
## MOD Description: Upgrade [map] bbcode MOD to 1.1
## MOD Version: 1.1
##
## Installation Level: Easy
## Installation Time: 5 Minutes
## Files To Edit: 10
##		posting.php
##		privmsg.php
##		viewtopic.php
##		includes/bbcode.php
##		includes/page_header.php
##		includes/topic_review.php
##		templates/subSilver/bbcode.tpl
##		templates/subSilver/posting_body.tpl
##		templates/subSilver/overall_header.tpl
##		templates/subSilver/simple_header.tpl
## Included Files: 5 + 16 js,css,png
##		db_install.php
##		language/lang_mapbbcode.php
##		language/lang_mapbbcode_russian.php
##		admin/admin_mapbbcode.php
##		templates/subSilver/admin/mapbbcode_body.tpl
##		includes/mapbbcode/*
##
## License: http://www.wtfpl.net/ WTFPL
##############################################################
## Author Notes:
##    This MOD was tested on phpBB 2.0.21 and 2.0.23.
##    And yes, it is EasyMOD friendly.
##############################################################
## MOD History:
##
##   2013-10-29 - Version 1.1
##      - Support for MapBBCode Share
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
# It is much simpler to copy those files than to modify them
#
copy root/language/lang_mapbbcode.php to language/lang_english/lang_mapbbcode.php
copy root/language/lang_mapbbcode_russian.php to language/lang_russian/lang_mapbbcode.php
copy root/mapbbcode/mapbbcode.js to includes/mapbbcode/mapbbcode.js
copy root/mapbbcode/mapbbcode-window.html to includes/mapbbcode/mapbbcode-window.html
#
#-----[ SQL ]------------------------------------------
#
# Upload and run as forum admin: db_install.php
#
# !!!!(Don't forget to delete db_install.php from the server after you have finished installing this mod!)!!!!
#
# or insert those records manually:
INSERT INTO phpbb_config (config_name, config_value) VALUES ('mapbb_enable_external','0');
#
#-----[ OPEN ]------------------------------------------
#
root/admin/admin_mapbbcode.php
#
#-----[ FIND ]------------------------------------------
#
$std_switcher_no = ( !$new['mapbb_standard_switcher'] ) ? "checked=\"checked\"" : "";
#
#-----[ AFTER, ADD ]------------------------------------------
#
$enable_external_yes = ( $new['mapbb_enable_external'] ) ? "checked=\"checked\"" : "";
$enable_external_no = ( !$new['mapbb_enable_external'] ) ? "checked=\"checked\"" : "";
#
#-----[ FIND ]------------------------------------------
#
	"L_STANDARD_SWITCHER" => $lang['MapBB_Standard_switcher'],
#
#-----[ AFTER, ADD ]------------------------------------------
#
	"L_ENABLE_EXTERNAL" => $lang['MapBB_Enable_external'],
#
#-----[ FIND ]------------------------------------------
#
	"S_STANDARD_SWITCHER_NO" => $std_switcher_no,
#
#-----[ AFTER, ADD ]------------------------------------------
#
	"S_ENABLE_EXTERNAL_YES" => $enable_external_yes,
	"S_ENABLE_EXTERNAL_NO" => $enable_external_no,
#
#-----[ OPEN ]------------------------------------------
#
root/templates/admin/mapbbcode_body.tpl
#
#-----[ FIND ]------------------------------------------
#
		<td class="row2"><input type="radio" name="standard_switcher" value="1" {S_STANDARD_SWITCHER_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="standard_switcher" value="0" {S_STANDARD_SWITCHER_NO} /> {L_NO}</td>
	</tr>
#
#-----[ AFTER, ADD ]------------------------------------------
#
	<tr>
		<td class="row1">{L_ENABLE_EXTERNAL}</td>
		<td class="row2"><input type="radio" name="enable_external" value="1" {S_ENABLE_EXTERNAL_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="enable_external" value="0" {S_ENABLE_EXTERNAL_NO} /> {L_NO}</td>
	</tr>
#
#-----[ OPEN ]------------------------------------------
#
viewtopic.php
#
#-----[ FIND ]------------------------------------------
#
	if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $postrow[$i]['post_text'])) {
#
#-----[ REPLACE WITH ]------------------------------------------
#
	if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $postrow[$i]['post_text'])) {
#
#-----[ OPEN ]------------------------------------------
#
privmsg.php
#
#-----[ FIND ]------------------------------------------
#
	$mapbbcode_present = preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $privmsg['privmsgs_text']);
#
#-----[ REPLACE WITH ]------------------------------------------
#
	$mapbbcode_present = preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $privmsg['privmsgs_text']);
#
#-----[ OPEN ]------------------------------------------
#
includes/bbcode.php
#
#-----[ FIND ]------------------------------------------
#
	$bbcode_tpl['map'] = str_replace('{MAPBBCODE}', '\\1\\3', $bbcode_tpl['map']);
#
#-----[ AFTER, ADD ]------------------------------------------
#
	$bbcode_tpl['mapid'] = str_replace('{DIVID}', '\\1', $bbcode_tpl['mapid']);
	$bbcode_tpl['mapid'] = str_replace('{MAPID}', '\\2', $bbcode_tpl['mapid']);
#
#-----[ FIND ]------------------------------------------
#
	$patterns[] = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
#
#-----[ REPLACE WITH ]------------------------------------------
#
	$mapre = '#(\[map(?:=[0-9,.-]+|id)?)(:[a-fA-F0-9]+)?(\].*?\[/map(?:id)?\])#si';
	$text = preg_replace_callback($mapre, create_function('$m','return $m[1].":".make_bbcode_uid().$m[3];'), $text);
	$mapre = '#(\[map(?:=[0-9,.-]+)?)(:[a-fA-F0-9]+)?(\].*?\[/map\])#si';
#
#-----[ FIND ]------------------------------------------
#
	$replacements[] = $bbcode_tpl['map'];
#
#-----[ AFTER, ADD ]------------------------------------------
#

	global $board_config;
	if (isset($board_config) && $board_config['mapbb_enable_external'])
	{
		$patterns[] = '#\[mapid(:[a-fA-F0-9]+)?\]([a-z]+)\[/mapid\]#i';
		$replacements[] = $bbcode_tpl['mapid'];
	}
	
#
#-----[ OPEN ]------------------------------------------
#
includes/topic_review.php
#
#-----[ FIND ]------------------------------------------
#
			if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]/', $row['post_text'])) {
#
#-----[ REPLACE WITH ]------------------------------------------
#
			if (preg_match('/\[map(?:=[0-9.,-]+)?\].*?\[\/map\]|\[mapid\][a-z]+\[\/mapid\]/', $row['post_text'])) {
#
#-----[ OPEN ]------------------------------------------
#
includes/page_header.php
#
#-----[ FIND ]------------------------------------------
#
		'L_MAPBB_OUTERTITLE' => $lang['MapBB_outerTitle'],
#
#-----[ AFTER, ADD ]------------------------------------------
#
		'L_MAPBB_EXPORT' => $lang['MapBB_export'],
		'L_MAPBB_EXPORTTITLE' => $lang['MapBB_exportTitle'],
		'L_MAPBB_UPLOAD' => $lang['MapBB_upload'],
		'L_MAPBB_UPLOADTITLE' => $lang['MapBB_uploadTitle'],
		'L_MAPBB_UPLOADING' => $lang['MapBB_uploading'],
		'L_MAPBB_UPLOADERROR' => $lang['MapBB_uploadError'],
		'L_MAPBB_UPLOADSUCCESS' => $lang['MapBB_uploadSuccess'],
		'L_MAPBB_SHAREDFORMHEADER' => $lang['MapBB_sharedFormHeader'],
		'L_MAPBB_SHAREDFORMERROR' => $lang['MapBB_sharedFormError'],
		'L_MAPBB_SHAREDFORMINVALIDCODE' => $lang['MapBB_sharedFormInvalidCode'],
		'L_MAPBB_SHAREDCODEERROR' => $lang['MapBB_sharedCodeError'],
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/bbcode.tpl
#
#-----[ FIND ]------------------------------------------
#
<!-- BEGIN map --><div id="map{DIVID}">{MAPBBCODE}</div><script language="javascript">mapBBcode.show('map{DIVID}');</script><!-- END map -->
#
#-----[ AFTER, ADD ]------------------------------------------
#
<!-- BEGIN mapid --><div id="map{DIVID}"></div><script language="javascript">mapBBcode.showExternal('map{DIVID}', '{MAPID}');</script><!-- END mapid -->
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/overall_header.tpl
#
#-----[ FIND ]------------------------------------------
#
	libPath: 'includes/mapbbcode/',
#
#-----[ REPLACE WITH ]------------------------------------------
#
	windowPath: 'includes/mapbbcode/mapbbcode-window.html',
#
#-----[ FIND ]------------------------------------------
#
	fullFromStart: {ALWAYS_FULL},
#
#-----[ AFTER, ADD ]------------------------------------------
#
	outerLinkTemplate: '{OUTER_LINK}',
#
#-----[ FIND ]------------------------------------------
#
	outerTitle: '{L_MAPBB_OUTERTITLE}',
#
#-----[ AFTER, ADD ]------------------------------------------
#
	exportName: '{L_MAPBB_EXPORT}',
	exportTitle: '{L_MAPBB_EXPORTTITLE}',
	upload: '{L_MAPBB_UPLOAD}',
	uploadTitle: '{L_MAPBB_UPLOADTITLE}',
	uploading: '{L_MAPBB_UPLOADING}',
	uploadError: '{L_MAPBB_UPLOADERROR}',
	uploadSuccess: '{L_MAPBB_UPLOADSUCCESS}',
	sharedFormHeader: '{L_MAPBB_SHAREDFORMHEADER}',
	sharedFormError: '{L_MAPBB_SHAREDFORMERROR}',
	sharedFormInvalidCode: '{L_MAPBB_SHAREDFORMINVALIDCODE}',
	sharedCodeError: '{L_MAPBB_SHAREDCODEERROR}',
#
#-----[ OPEN ]------------------------------------------
#
templates/subSilver/simple_header.tpl
#
#-----[ FIND ]------------------------------------------
#
	fullFromStart: {ALWAYS_FULL},
#
#-----[ AFTER, ADD ]------------------------------------------
#
	outerLinkTemplate: '{OUTER_LINK}',
#
#-----[ SAVE/CLOSE ALL FILES ]------------------------------------------
#
# EoM
