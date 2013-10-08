/*
 * List of public-use layers.
 */
window.MapBBCode.layersList = {
    "OSM": "L.tileLayer('http://tile.openstreetmap.org/{z}/{x}/{y}', { attribution: 'Map &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a>', minZoom: 0, maxZoom: 19 })",
    "CycleMap": "L.tileLayer('http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}', { attribution: 'Map &copy; <a href=\"http://openstreetmap.org\">OSM</a> | Tiles &copy; Andy Allan', minZoom: 0, maxZoom: 18 })",
    "MapSurfer": "L.tileLayer('http://129.206.74.245:8001/tms_r.ashx?x={x}&y={y}&z={z}', { name: 'MapSurfer', attribution: 'Map &copy; <a href=\"http://openstreetmap.org\">OSM</a> | Tiles &copy; <a href=\"http://giscience.uni-hd.de/\">GIScience Heidelberg</a>', minZoom: 0, maxZoom: 19 })"
};

function getLeafletLayers( layers ) {
    var l = layers.split(','),
        layerList = window.MapBBCode.layersList,
        result = [];
    for( var i = 0; i < l.length; i++ )
        if( layerList[l[i]] )
            result.push(layerList[l[i]]);
    return result;
}
