<link rel="stylesheet" href="../includes/mapbbcode/leaflet.css" />
<script src="../includes/mapbbcode/leaflet.js"></script>
<script src="../includes/mapbbcode/mapbbcode-config.js"></script>
<script src="../includes/mapbbcode/lang/{L_MAPBB_LANG_JS}.config.js"></script>
{L_MAPBB_JS_ADDONS}

<h1>{L_MAPBBCODE_CONFIG}</h1>

<p>{L_MAPBBCODE_CONFIG_EXPLAIN}</p>

<form action="{S_CONFIG_ACTION}" method="post" name="mapfm">
<input type="hidden" name="default_zoom" value="{DEFAULT_ZOOM}" />
<input type="hidden" name="default_pos" value="{DEFAULT_POS}" />
<input type="hidden" name="view_width" value="{VIEW_WIDTH}" />
<input type="hidden" name="view_height" value="{VIEW_HEIGHT}" />
<input type="hidden" name="full_height" value="{FULL_HEIGHT}" />
<input type="hidden" name="editor_height" value="{EDITOR_HEIGHT}" />
<input type="hidden" name="window_width" value="{WINDOW_WIDTH}" />
<input type="hidden" name="window_height" value="{WINDOW_HEIGHT}" />
<input type="hidden" name="always_full" value="{ALWAYS_FULL}" />
<input type="hidden" name="editor_window" value="{EDITOR_WINDOW}" />
<input type="hidden" name="layers" value="{LAYERS}" />
<table width="99%" cellpadding="4" cellspacing="1" border="0" align="center" class="forumline">
	<tr>
	  <th class="thHead" colspan="2">{L_PANEL_CONFIG}</th>
	</tr>
	<tr>
		<td class="row1">{L_LAYERS}</td>
		<td class="row2"><select id="layer_select" size="1"></select> <input type="button" id="addbutton"/></td>
	</tr>
	<tr style="display: none;" id="bing_key_row">
		<td class="row1" id="bing_key_title"></td>
		<td class="row2"><input class="post" type="text" maxlength="80" size="40" id="bing_key"/></td>
	</tr>
	<tr><td class="row2" colspan="2">
		<div id="panel_config"></div>
	</td></tr>
	<tr>
		<td class="row1">{L_DEFAULT_ZOOM_POS}</td>
		<td class="row2" id="default_zoom_pos"></td>
	</tr>
	<tr>
		<td class="row1">{L_PANEL_SIZE}</td>
		<td class="row2" id="panel_size"></td>
	</tr>
	<tr>
		<td class="row1">{L_FULL_HEIGHT}</td>
		<td class="row2" id="full_height"></td>
	</tr>
	<tr>
		<td class="row1">{L_WINDOW_SIZE}</td>
		<td class="row2" id="window_size"></td>
	</tr>
	<tr>
		<td class="row1">{L_EDITOR_HEIGHT}</td>
		<td class="row2" id="editor_height"></td>
	</tr>
	<tr>
		<td class="row1">{L_STANDARD_SWITCHER}</td>
		<td class="row2"><input type="radio" name="standard_switcher" value="1" {S_STANDARD_SWITCHER_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="standard_switcher" value="0" {S_STANDARD_SWITCHER_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1">{L_ENABLE_EXTERNAL}</td>
		<td class="row2"><input type="radio" name="enable_external" value="1" {S_ENABLE_EXTERNAL_YES} /> {L_YES}&nbsp;&nbsp;<input type="radio" name="enable_external" value="0" {S_ENABLE_EXTERNAL_NO} /> {L_NO}</td>
	</tr>
	<tr>
		<td class="row1">{L_OUTER_LINK}<br><span class="gensmall">{L_OUTER_LINK_EXAMPLE}</span></td>
		<td class="row2"><input class="post" type="text" maxlength="120" size="40" name="outer_link" value="{OUTER_LINK}" /></td>
	</tr>
	<tr>
		<td class="row1">{L_ALLOWED_TAGS}</td>
		<td class="row2"><input class="post" type="text" maxlength="120" size="40" name="allowed_tags" value="{ALLOWED_TAGS}" /></td>
	</tr>

	<tr>
		<td class="catBottom" colspan="2" align="center">{S_HIDDEN_FIELDS}<input type="submit" name="submit" value="{L_SUBMIT}" class="mainoption" />&nbsp;&nbsp;<input type="reset" value="{L_RESET}" class="liteoption" />
		</td>
	</tr>
</table>
</form>

<br clear="all" />

<script language="javascript" type="text/javascript">
<!--
// All scripts in this file are licensed WTFPL.

function isTrue(val) {
    return val && val !== '0' && val !== 'false';
}

function updateTableValues() {
	var f = document.forms['mapfm'],
	    full = isTrue(f.elements['always_full'].value),
	    win = isTrue(f.elements['editor_window'].value);
	document.getElementById('default_zoom_pos').innerHTML = f.elements['default_zoom'].value + ',' + f.elements['default_pos'].value;
	document.getElementById('panel_size').innerHTML = (full ? '<span style="color: #777;">' : '') + f.elements['view_width'].value + 'x' + f.elements['view_height'].value + (full ? '</span>' : '');
	document.getElementById('full_height').innerHTML = f.elements['full_height'].value;
	document.getElementById('window_size').innerHTML = (win ? '' : '<span style="color: #777;">') + f.elements['window_width'].value + 'x' + f.elements['window_height'].value + (win ? '' : '</span>');
	document.getElementById('editor_height').innerHTML = (win ? '<span style="color: #777;">' : '') + f.elements['editor_height'].value + (win ? '</span>' : '');
}

var config = new MapBBCodeConfig({
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
//        editorTypeFixed: true, // uncomment if needed
	editorInWindow: isTrue('{EDITOR_WINDOW}') // set to true or false is needed
});
config.on('show change', function(options) {
	var f = document.forms['mapfm'];
	f.elements['default_zoom'].value = options.defaultZoom;
	f.elements['default_pos'].value = '' + options.defaultPosition[0] + ',' + options.defaultPosition[1];
	f.elements['view_width'].value = options.viewWidth;
	f.elements['view_height'].value = options.viewHeight;
	f.elements['full_height'].value = options.fullViewHeight;
	f.elements['editor_height'].value = options.editorHeight;
	f.elements['window_width'].value = options.windowWidth;
	f.elements['window_height'].value = options.windowHeight;
	f.elements['layers'].value = options.layers.join(',');
	f.elements['always_full'].value = options.fullFromStart ? '1' : '';
	f.elements['editor_window'].value = options.editorInWindow ? '1' : '';
	updateTableValues();
});
config.bindLayerAdder({
    select: 'layer_select',
    button: 'addbutton',
    keyBlock: 'bing_key_row',
    keyBlockDisplay: 'table-row',
    keyTitle: 'bing_key_title',
    keyValue: 'bing_key'
});
config.show('panel_config');
// -->
</script>
