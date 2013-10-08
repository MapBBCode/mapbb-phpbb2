<?php
/***************************************************************************
 *			lang_mapbbcode.php [English]
 *			-------------------------------
 *	begin				: 02/10/2013
 *	copyright			: Zverik
 *	email				: zverik@textual.ru
 *
 *	version				: 1.0.0 - 02/10/2013
 *
 *
 ***************************************************************************/

/***************************************************************************
 *
 *   This program is free software under WTFPL license;
 *   do whatever you want with it.
 *
 ***************************************************************************/

$lang['bbcode_map_help'] = 'Insert a map: [map]latitude,longitude(title); ...[/map]  (alt+m)';

$lang['MapBB_close'] = 'Close'; // close feature editing popup
$lang['MapBB_remove'] = 'Delete'; // delete feature from popup
$lang['MapBB_apply'] = 'Apply'; // button on an editing map to apply changes
$lang['MapBB_cancel'] = 'Cancel'; // button on an editing map to discard changes
$lang['MapBB_title'] = 'Title'; // prompt for marker title text
$lang['MapBB_bing'] = 'Bing'; // name of Bing imagery layer

// button titles
$lang['MapBB_zoomInTitle'] = 'Zoom in';
$lang['MapBB_zoomOutTitle'] = 'Zoom out';
$lang['MapBB_applyTitle'] = 'Apply changes';
$lang['MapBB_cancelTitle'] = 'Cancel changes';
$lang['MapBB_fullScreenTitle'] = 'Enlarge or shrink map panel';
$lang['MapBB_helpTitle'] = 'Open help window';
$lang['MapBB_outerTitle'] = 'Show this place on an external map';

// Leaflet.draw
$lang['MapBB_polylineTitle'] = 'Draw a path';
$lang['MapBB_polygonTitle'] = 'Draw an area';
$lang['MapBB_markerTitle'] = 'Add a marker';
$lang['MapBB_drawCancelTitle'] = 'Cancel drawing';
$lang['MapBB_markerTooltip'] = 'Click map to place marker';
$lang['MapBB_polylineStartTooltip'] = 'Click to start drawing a line';
$lang['MapBB_polylineContinueTooltip'] = 'Click to continue drawing line';
$lang['MapBB_polylineEndTooltip'] = 'Click the last point to finish line';
$lang['MapBB_polygonStartTooltip'] = 'Click to start drawing a polygon';
$lang['MapBB_polygonContinueTooltip'] = 'Click to continue drawing polygon';
$lang['MapBB_polygonEndTooltip'] = 'Click the last point to close this polygon';

// editor
$lang['MapBB_view'] = 'View';
$lang['MapBB_editor'] = 'Editor';
$lang['MapBB_editInWindow'] = 'Window';
$lang['MapBB_editInPanel'] = 'Panel';
$lang['MapBB_viewNormal'] = 'Normal';
$lang['MapBB_viewFull'] = 'Full width only';
$lang['MapBB_viewTitle'] = 'Adjusting browsing panel';
$lang['MapBB_editorTitle'] = 'Adjusting editor panel or window';
$lang['MapBB_editInWindowTitle'] = 'Editor will be opened in a popup window';
$lang['MapBB_editInPanelTitle'] = 'Editor will appear inside a page';
$lang['MapBB_viewNormalTitle'] = 'Map panel will have "fullscreen" button';
$lang['MapBB_viewFullTitle'] = 'Map panel will always have maximum size';
$lang['MapBB_growTitle'] = 'Click to grow the panel';
$lang['MapBB_shrinkTitle'] = 'Click to shrink the panel';

// help: array of html paragraphs, simply joined together. First line is <h1>, start with '#' for <h2>.
$lang['MapBB_helpContents'] = array(
  'Map BBCode Editor',
  'You have opened this help window from inside the map editor. It is activated with "Map" button. When the cursor in the textarea is inside [map] sequence, the editor will edit that bbcode, otherwise it will create new bbcode and insert it at cursor position after clicking "Apply".',
  '# BBCode',
  'Map BBCode is placed inside <tt>[map]...[/map]</tt> tags. Opening tag may contain zoom with optional position in latitude,longitude format: <tt>[map=10]</tt> or <tt>[map=15,60.1,30.05]</tt>. Decimal separator is always a full stop.',
  'The tag contains a semicolon-separated list of features: markers and paths. They differ only by a number of space-separated coordinates: markers have one, and paths have more. There can be optional title in brackets after the list: <tt>12.3,-5.1(Popup)</tt> (only for markers in the editor). Title is HTML and can contain any characters, but "(" should be replaced with "\\(", and only a limited set of HTML tags is allowed.',
  'Paths can have different colours, which are stated in <i>parameters</i>: part of a title followed by "|" character. For example, <tt>12.3,-5.1 12.5,-5 12,0 (red|)</tt> will produce a red path.',
  '# Map Viewer',
  'Plus and minus buttons on the map change its zoom. Other buttons are optional. A button with four arrows ("fullscreen") expands map view to maximum width and around twice the height. If a map has many layers, there is a layer switcher in the top right corner. There also might be a button with a curved arrow, that opens an external site (usually www.openstreetmap.org) at a position shown on the map.',
  'You can drag the map to pan around, press zoom buttons while holding Shift key to change zoom quickly, or drag the map with Shift pressed to zoom to an area. Scroll-wheel zoom is disabled in viewer to not interfere with page scrolling, but in works in map editor.',
  '# Editor Buttons',
  '"Apply" saves map features (or map state if there are none) to a post body, "Cancel" just closes the editor panel. And you have already figured out what the button with a question mark does. Two buttons underneath zoom controls add features on the map.',
  'To draw a path, press the button with a diagonal line and click somewhere on the map. Then click again, and again, until you\'ve got a nice polyline. Do not worry if you got some points wrong: you can fix it later. Click on the final point to finish drawing. Then you may fix points and add intermediate nodes by dragging small square or circular handlers. To delete a path (or a marker), click on it, and in the popup window press "Delete" button.',
  'Markers are easier to place: click on the marker button, then click on the map. In a popup window for a marker you can type a title: if it is 1 or 2 characters long, the text would appear right on the marker. Otherwise map viewers would have to click on a marker to read the title. A title may contain URLs and line feeds.',
  '# Plugin',
  'Map BBCode Editor is an open source product, available at <a href="https://github.com/Zverik/MapBBCode">github</a>. You will also find there plugins for some of popular forum engines. All issues and suggestions can be placed in the github issue tracker.'
);

$lang['MapBB_Config'] = 'MapBBCode Configuration';
$lang['MapBB_Config_explain'] = 'This form allows you to customize map panels and layers in both view and edit modes.';
$lang['MapBB_Panel_Config'] = 'Map panel';
$lang['MapBB_Layers'] = 'Tile layers setup';
$lang['MapBB_Select_layer'] = 'Select layer';
$lang['MapBB_Add_layer'] = 'Add layer';
$lang['MapBB_Default_zoom_pos'] = 'Default zoom level and coordinates';
$lang['MapBB_Panel_size'] = 'View panel size';
$lang['MapBB_Full_height'] = 'Maximized panel size';
$lang['MapBB_Editor_height'] = 'Inline editor panel height';
$lang['MapBB_Window_size'] = 'Editor window size';
$lang['MapBB_Key_needed'] = 'This layer needs a developer key';
$lang['MapBB_Bing_key'] = 'This layer needs a developer key (<a href="%s" target="bing">how to get it</a>)';
$lang['MapBB_Standard_switcher'] = 'Hide layer list behind a button control';
$lang['MapBB_Outer_link'] = 'External link template, if needed (parameters: {zoom}, {lat}, {lon})';
$lang['MapBB_Outer_link_example'] = 'Example: http://www.openstreetmap.org/#map={zoom}/{lat}/{lon}';
$lang['MapBB_Allowed_tags'] = 'Allowed HTML tags in popups (regular expression)';
$lang['Click_return_mapbbcode_config'] = 'Click %sHere%s to return to MapBBCode Configuration';

?>
