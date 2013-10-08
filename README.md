# MapBBCode MOD for phpBB 2

The purpose of writing MapBBCode library was to allow users at
[spb-projects forum](http://spb-projects.ru/forum/) to pinpoint roads and construction
sites on a map. But since the main part of it is the user interface, the modification
quickly grew into a javascript library with just a tiny modifications to phpBB source code.

That forum works on phpBB 2.0.21 with subRebel template and an attachments plugin,
so obviously that is the target configuration. But the MOD was also tested
on the latest phpBB 2 version, 2.0.23, and seemed to work.

## Installation

### EasyMOD

Those steps are based on [the official instructions](http://easymod.sourceforge.net/readme/#g_faq_mod_inst).

1. Unzip `mapbbcode_mod.zip` to `$PHPBB/admin/mods`.
2. Open your forum, login as administrator and enter the Administration Panel
3. Click "Install MODs" in the left tab (under "MOD Center" header) and enter your admin password for the third time.
4. Look for "MapBBCode" mod and click "Process" next to it.
5. Check that everything looks good, and click "Next Step", then "Complete Installation" a couple of times.
6. Now you can check out the "MapBBCode" administration panel and add maps to forum posts.

### No EasyMOD

1. Unzip `mapbbcode_mod.zip` somewhere.
2. Copy `db_install.php` to the forum root directory and open it in a browser. You'll have to login as administrator.
3. Open `install.mod` with a text editor and follow every instruction precisely. There will be a lot of copying and pasting.
4. Go to the forum and check that [map] bbcode works.

## List of changes

New files are understandable: one stand-alone script for inserting configuration values
into `phpbb_config` database table, two language files, a script and a template
for administration panel, and a directory with the javascript library.

Here is why phpbb files are changed:

| Location  |        File         | What is changed
|-----------|---------------------|------------------
|           | `posting.php`       | Adds translation string for "Map" button in posting form.
|           | `viewtopic.php`     | A simple check for [map] tag presence in posts on a current page, loop in 8 lines.
|           | `privmsg.php`       | 4 insertions for setting `$mapbbcode_present` flag: one for new PM form (editor), one for displaying a message (only if there's [map]), one for preview window, and a translation string for "Map" again.
| includes  | `bbcode.php`        | Appends code to a second pass of parsing: adds random id to each [map], and then sets two variables for the bbcode template.
| includes  | `topic_review.php`  | The same as for `viewtopic.php`: iterate over posts, and if [map] bbcode found, set `$mapbbcode_present` to `TRUE`. The difference is, it doesn't read all posts before printing the page header, so it adds an SQL query.
| includes  | `page_header.php`   | Includes mapbbcode language files and assigns a lot of template variables for the javascript library. Of course, only if `$mapbbcode_present` is TRUE.
| templates | `bbcode.tpl`        | Appends a line `<div id="{id}">{bbcode}</div><script>mapBBcode.show('{id}')</script>`.
| templates | `posting_body.tpl`  | Adds `map_help` variable and a "Map" button.
| templates | `overall_header.tpl`| Adds a block `switch_enable_mapbbcode` with all scripts, stylesheets, translation strings and initialization code.
| templates | `simple_header.tpl` | The same, but without translations.

## License

The phpBB 2 source code is filled with GPLv2 marks, and I've done a lot of copy-pasting in PHP code, so I guess it is GPLv2. But all javascript parts and the general idea of MapBBCode integration are under WTFPL: take it, use it, adapt to other forum engines, you don't even have to credit the author.
