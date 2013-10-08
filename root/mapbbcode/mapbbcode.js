/*
 A JavaScript library for [map] BBCode parsing, displaying and editing.
 https://github.com/MapBBCode/mapbbcode
 (c) 2013, Ilya Zverev
 Licensed WTFPL.
*/
!function(t,e){t.MapBBCodeProcessor={_getRegExp:function(){var t="\\s*(-?\\d+(?:\\.\\d+)?)\\s*,\\s*(-?\\d+(?:\\.\\d+)?)",e="\\((?:([a-zA-Z0-9,]*)\\|)?(|[^]*?[^\\\\])\\)",o=t+"(?:"+t+")*(?:\\s*"+e+")?",i="\\[map(?:=([12]?\\d)(?:,"+t+")?)?\\]",n=i+"("+o+"(?:\\s*;"+o+")*)?\\s*\\[/map\\]",a=new RegExp(n,"i");return{coord:t,params:e,map:n,mapCompiled:a}},isValid:function(t){return this._getRegExp().mapCompiled.test(t)},stringToObjects:function(t){var e=this._getRegExp(),o=t.match(e.mapCompiled),i={objs:[]};if(o&&o[1]&&o[1].length&&+o[1]>0&&(i.zoom=+o[1],o[3]&&o[3].length>0))try{i.pos=L.LatLng?new L.LatLng(o[2],o[3]):[+o[2],+o[3]]}catch(n){}if(o&&o[4])for(var a=o[4].replace(/;;/g,"##%##").split(";"),s=new RegExp("^"+e.coord),r=new RegExp(e.params),l=0;l<a.length;l++){var p,d=a[l].replace(/##%##/g,";"),c=[],h="",u=[];for(p=d.match(s);p;)c.push(L.LatLng?new L.LatLng(p[1],p[2]):[+p[1],+p[2]]),d=d.substr(p[0].length),p=d.match(s);p=d.match(r),p&&(p[1]&&(u=p[1].split(",")),h=p[2].replace(/\\\)/g,")").replace(/^\s+|\s+$/g,"")),i.objs.push({coords:c,text:h,params:u})}return i},objectsToString:function(t){var e="";t.zoom>0&&(e="="+t.zoom,t.pos&&(e+=","+this._latLngToString(t.pos)));for(var o="",i=t.objs||[],n=0;n<i.length;n++){n>0&&(o+="; ");for(var a=i[n].coords,s=0;s<a.length;s++)s>0&&(o+=" "),o+=this._latLngToString(a[s]);var r=i[n].text||"",l=i[n].params||[];r.indexOf("|")>=0&&0===l.length&&(r="|"+r),(r.length>0||l.length>0)&&(o=o+"("+(l.length>0?l.join(",")+"|":"")+r.replace(/\)/g,"\\)").replace(/;/g,";;")+")")}return o.length||e.length?"[map"+e+"]"+o+"[/map]":""},_latLngToString:function(t){var e=Math.pow(10,5);return""+Math.round((t.lat||t[0])*e)/e+","+Math.round((t.lng||t[1])*e)/e}},t.MapBBCode=L.Class.extend({options:{createLayers:null,layers:null,maxInitialZoom:15,defaultPosition:[22,11],defaultZoom:2,leafletOptions:{},lineColors:{def:"#0022dd",blue:"#0022dd",red:"#bb0000",green:"#007700",brown:"#964b00",purple:"#800080",black:"#000000"},polygonOpacity:.1,editorHeight:"400px",viewWidth:"600px",viewHeight:"300px",fullViewHeight:"600px",fullScreenButton:!0,fullFromStart:!1,windowWidth:0,windowHeight:0,windowFeatures:"resizable,status,dialog",usePreparedWindow:!0,libPath:"lib/",outerLinkTemplate:!1,showHelp:!0,allowedHTML:"[auib]|span|br|em|strong|tt",letterIcons:!0,enablePolygons:!0,preferStandardLayerSwitcher:!1,hideInsideClasses:[]},strings:{},initialize:function(t){L.setOptions(this,t)},setStrings:function(t){this.strings=L.extend({},this.strings,t)},_zoomToLayer:function(t,e,o,i){var n=e.getBounds();if(!n||!n.isValid())return o&&o.zoom?t.setView(o.pos||this.options.defaultPosition,o.zoom):i&&t.setView(this.options.defaultPosition,this.options.defaultZoom),void 0;var a=function(){if(o&&o.pos)t.setView(o.pos,o.zoom||this.options.maxInitialZoom);else{var e=this.options.maxInitialZoom;t.fitBounds(n,{animate:!1}),o&&o.zoom?t.setZoom(o.zoom,{animate:!1}):i&&t.getZoom()>e&&t.setZoom(e,{animate:!1})}},s=t.getBoundsZoom(n,!1);s?a.call(this):t.on("load",a,this)},_objectToLayer:function(t){var e,o=this.options.lineColors,i=t.params.length>0&&t.params[0]in o?o[t.params[0]]:o.def;return 1==t.coords.length?e=L.marker(t.coords[0]):t.coords.length>2&&t.coords[0].equals(t.coords[t.coords.length-1])?(t.coords.splice(t.coords.length-1,1),e=L.polygon(t.coords,{color:i,weight:3,opacity:.7,fill:!0,fillColor:i,fillOpacity:this.options.polygonOpacity})):e=L.polyline(t.coords,{color:i,weight:5,opacity:.7}),t.text?(e._text=t.text,L.LetterIcon&&e instanceof L.Marker&&this.options.letterIcons&&t.text.length>=1&&t.text.length<=2?(e.setIcon(new L.LetterIcon(t.text)),e.options.clickable=!1):e.bindPopup(t.text.replace(new RegExp("<(?!/?("+this.options.allowedHTML+")[ >])","g")),"&lt;")):e.options.clickable=!1,e._objParams=t.params,e},createOpenStreetMapLayer:function(){return L.tileLayer("http://tile.openstreetmap.org/{z}/{x}/{y}.png",{name:"OpenStreetMap",attribution:'Map &copy; <a href="http://openstreetmap.org">OpenStreetMap</a>',minZoom:2,maxZoom:18})},_addLayers:function(e){var o=this.options.createLayers?this.options.createLayers.call(this,L):null;o&&o.length||!t.layerList||!this.options.layers||(o=t.layerList.getLeafletLayers(this.options.layers,L)),o&&o.length||(o=[this.createOpenStreetMapLayer()]);for(var i=0;i<o.length;i++)"OSM"===o[i]&&(o[i]=this.createOpenStreetMapLayer());if(e.addLayer(o[0]),o.length>1){var n,a;if(!this.options.preferStandardLayerSwitcher&&L.StaticLayerSwitcher){for(n=L.staticLayerSwitcher(),a=0;a<o.length;a++)n.addLayer(o[a].options.name,o[a]);e.addControl(n)}else{for(n=L.control.layers(),a=0;a<o.length;a++)n.addBaseLayer(o[a],o[a].options.name);e.addControl(n)}}},_hideClassPresent:function(t){if("string"!=typeof t.className)return!1;var e,o,i=t.className.split(" "),n=this.options.hideInsideClasses;if(!n||!n.length)return!1;for(e=0;e<i.length;e++)for(o=0;o<n.length;o++)if(i[e]===n[o])return!0;return t.parentNode&&this._hideClassPresent(t.parentNode)},show:function(o,i){var n="string"==typeof o?e.getElementById(o):o;if(n&&(i||(i=n.getAttribute("bbcode")||n.innerHTML.replace(/^\s+|\s+$/g,"")),i)){for(;n.firstChild;)n.removeChild(n.firstChild);if(!this._hideClassPresent(n)){var a=n.ownerDocument.createElement("div");a.style.width=this.options.fullFromStart?"100%":this.options.viewWidth,a.style.height=this.options.fullFromStart?this.options.fullViewHeight:this.options.viewHeight,n.appendChild(a);var s=L.map(a,L.extend({},{scrollWheelZoom:!1,zoomControl:!1},this.options.leafletOptions));s.addControl(new L.Control.Zoom({zoomInTitle:this.strings.zoomInTitle,zoomOutTitle:this.strings.zoomOutTitle})),this._addLayers(s);var r=new L.FeatureGroup;r.addTo(s);for(var l=t.MapBBCodeProcessor.stringToObjects(i),p=l.objs,d=0;d<p.length;d++)this._objectToLayer(p[d]).addTo(r);if(this._zoomToLayer(s,r,{zoom:l.zoom,pos:l.pos},!0),this.options.fullScreenButton&&!this.options.fullFromStart){var c,h=new L.FunctionButton(t.MapBBCode.buttonsImage,{position:"topright",bgPos:L.point(0,0),title:this.strings.fullScreenTitle}),u=!1;s.addControl(h),h.on("clicked",function(){var t=s.getContainer().style;u||c||(c=[t.width,t.height]),u=!u,t.width=u?"100%":c[0],t.height=u?this.options.fullViewHeight:c[1],s.invalidateSize(),h.options.bgPos.x=u?26:0,h.updateBgPos(),this._zoomToLayer(s,r)},this)}if(this.options.outerLinkTemplate){var g=L.functionButton(t.MapBBCode.buttonsImage,{position:"topright",bgPos:L.point(52,0),title:this.strings.outerTitle});g.on("clicked",function(){var e=this.options.outerLinkTemplate;e=e.replace("{zoom}",s.getZoom()).replace("{lat}",s.getCenter().lat).replace("{lon}",s.getCenter().lng),t.open(e,"mapbbcode_outer")},this),s.addControl(g)}}}}}),L.FunctionButtons=L.Control.extend({includes:L.Mixin.Events,initialize:function(t,e){if(this._content=t,e.titles||(e.titles=[]),e.titles.length<t.length)for(var o=e.titles.length;o<t.length;o++)e.titles.push("");L.Control.prototype.initialize.call(this,e)},onAdd:function(t){this._map=t,this._links=[];for(var e=L.DomUtil.create("div","leaflet-bar"),o=0;o<this._content.length;o++){var i=L.DomUtil.create("a","",e);this._links.push(i),i.href="#",i.style.padding="0 4px",i.style.width="auto",i.style.minWidth="20px",this.options.titles&&this.options.titles.length>o&&(i.title=this.options.titles[o]),this._updateContent(o);var n=L.DomEvent.stopPropagation;L.DomEvent.on(i,"click",n).on(i,"mousedown",n).on(i,"dblclick",n).on(i,"click",L.DomEvent.preventDefault).on(i,"click",this.clicked,this)}return e},setContent:function(t,e){t>=this._content.length||(this._content[t]=e,this._updateContent(t))},_updateContent:function(t){if(!(t>=this._content.length)){var e=this._links[t],o=this._content[t];if("string"==typeof o){var i=o.length<4?"":o.substring(o.length-4),n="data:image/"===o.substring(0,11);".png"===i||".gif"===i||".jpg"===i||n?(e.style.width=""+(this.options.imageSize||26)+"px",e.style.height=""+(this.options.imageSize||26)+"px",e.style.padding="0",e.style.backgroundImage="url("+o+")",e.style.backgroundRepeat="no-repeat",e.style.backgroundPosition=this.options.bgPos?-this.options.bgPos.x+"px "+-this.options.bgPos.y+"px":"0px 0px"):e.innerHTML=o}else{for(;e.firstChild;)e.removeChild(e.firstChild);e.appendChild(o)}}},setTitle:function(t,e){this.options.titles[t]=e,this._links[t].title=e},updateBgPos:function(){this._links[0].style.backgroundPosition=this.options.bgPos?-this.options.bgPos.x+"px "+-this.options.bgPos.y+"px":"0px 0px"},clicked:function(t){for(var e=t.target,o=this._links.length;--o>=0&&e!==this._links[o];);this.fire("clicked",{idx:o})}}),L.functionButtons=function(t,e){return new L.FunctionButtons(t,e)},L.FunctionButton=L.FunctionButtons.extend({initialize:function(t,e){e.title&&(e.titles=[e.title]),L.FunctionButtons.prototype.initialize.call(this,[t],e)},setContent:function(t){L.FunctionButtons.prototype.setContent.call(this,0,t)},setTitle:function(t){L.FunctionButtons.prototype.setTitle.call(this,0,t)}}),L.functionButton=function(t,e){return new L.FunctionButton(t,e)},t.MapBBCode.buttonsImage="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAE4AAAAaCAYAAAAZtWr8AAAABmJLR0QA/wD/AP+gvaeTAAAF/klEQVRYhe2ZX2xcRxWHvzPXf7Zu1o6zDiFxhasWCSIaSljxsE6BqNm9d41x1aitkFopRFRFPCBUOYKmCVYnNIB4gj4EkVQQFFALSqhqmzS71060qoRTEcVQUoGQShU1ChJkZTW1Cd6Ndw4PNrDe2LteOyFIySfdh7nzm3Pmnjs6d85cuM1t/pdIeSOZTPZ6nrehUCi8nMvlppZrtLe3975isbjz6tWr+3O53Hsrn+b/H/MC5/v+RWADMAOMASPOucHR0dFz1YwkEok7WltbtwMpVU0BnXNd28MwfPUGzPumY8obqpoF3gfyqvou8KSIPFrLSDQaNar6Q1W9S1XfAkpzXWOLjYnH441BEOyKx+ON9U46CIL1vu9/01praqtvDA3lDWPMuKqmgcvAR4D7JiYmirWMhGH4j3g8vnbNmjVPiMiPReSIqvaEYfj3xcZ0dHR0qereWCz2CWBHT09PtFQqbWlrawuPHj1aKtf6vv8BEflUPp8POzs7I9PT078GGsfHx18AJpfz4CuloaL9JrBeRHqAYVX9ZTQafXgphtrb2x8UkUPAc6r6IRH5fTV9Npt9O51OB865U77vH1DVF4DXpqamPgb8sUL+oKoejsViHdPT08NA1PO8LUNDQ3UHzVobAfYD0SqyZ6y1VXPzvKXe0NDwFnBhrvk5EdnS1NR0mIpcWEkymdxsjDmqqgfDMNwPOOC3tR4ik8mcUdUvAE+p6iPAlZmZmfsrdSKyyRjzJ1X9CbDR87yeEydOXKplfyGstdPGmGFgB/DlRa6WWnaqBiQIgrSq/soYk8hkMn9YTOf7/jERWZXP5/vOnj17dakPkUwmNwEbjDGdwIsi8i7wUjab3Vsxj0Hn3IdFpMsY87hzbq0x5mQmkzm/VF+VWGsfAl4BvAW6O621f602vmpyzWazmVKpdE+1oAE0NzfvKBQKj9YTNAARedgYcwI4AJxX1S5VTVbqVPUBEdkIvOecGwR+UCqVNtfjawFeB84vd3BljruGkydP/q2WZnh4+MpynI+MjDzv+/5BVd0GpERknap2LCBtmluNR4CRfD7/Rr0vqZy5PPcacO9ybdQM3I1m7sv78tz1pUU01RL5cngWSKzEwE3bB90srLUtwNcqbl8AvgvoUu3ccoETkQSwuuxW3vO8lLV2D/AVZncENbnlAgfcVd4QETswMPBnAGvtIeAJZkvOqtz0HNfX19dSLBY/w2yduxO4FIbhR8s1vu9PiUie6/BxUNXLZc2Cqr5Y3m+t/cVS7NRccdu2bVtXS9PX19eydevWVUtxWI7v+18vFAoTqnpcVR8H2oGJBaRXnHNdqvqUqr4ei8UmUqnU9nr9ATQ1Nf2G/66oC9bamiXlQlQNXCqV8j3PeyedTn+8mq5QKBxpbm4+Vm/BbozJATtVdQBYC7wD5Cp1InKa2XIwpqo7gKc9z/tdPb7+zZ49ey4xu3IBuqy1db9wqAhcb29vu+/7f0kmk5vS6XRCRF4FDtXaAIvIblXdHIvFfmatNb7v/ygIgm/Vcp7JZM4YY4oi8ryIPM1s/lnI15siIqp6UEQOOOfGV1I1RCKRfuAc0Ag8sxwb8wJXKpXuB+4plUotqjoEHO/u7t5Vy0g2m31bRPqAz4+NjX1PZ6m5T0qlUluccz9X1e8bY04BzZ7nXRM459w5YOPq1au/AYwaY46n0+m7l/iM17B79+7LkUjk08Ax4Nl9+/btokb5Wck8cRAEX3XODYjIFHCxWCz6k5OTpaUk4ng83hiLxdLM1n+DwANhGH5wMX06nb7bOfcGMNbW1vbY1NTUnc65VD6fH6r0t8CxUg5ojEQiyzohKcda+0ngi8AqYLC1tXWkv7//n7XGzQtcKpU6LCKPqWpeRHLAZ1X1yMjIyHPVjPi+fydwETijqu8D20VEgHWLncklEok7otHo3snJyW+fPn265kTLCYJgvao+2d3d/R1r7ZL2XdebBY/ORWRGVVd8dO6ce2R0dPSVGzX5m0nlPq5fRNYWCoWf1vOzZm7FvDR3/ednzczMzKnrONfb3OYW5l/jv4lWsW647QAAAABJRU5ErkJggg==",t.MapBBCode.include({_layerToObject:function(t){var e={};return t instanceof L.Marker?e.coords=[t.getLatLng()]:(e.coords=t.getLatLngs(),t instanceof L.Polygon&&e.coords.push(e.coords[0])),t.inputField&&(e.text=t.inputField.value.replace(/\\n/g,"\n").replace(/\\\n/g,"\\n")),e.params=t._objParams||[],t._colorName&&(e.params=this.options.lineColors[t._colorName]!==this.options.lineColors.def?[t._colorName]:[]),e},_makeEditable:function(o,i){var n=e.createElement("div");n.style.textAlign="center",n.style.clear="both";var a=e.createElement("input");if(a.type="button",a.value=this.strings.close,a.onclick=function(){o.closePopup()},n.appendChild(a),i){var s=e.createElement("input");s.type="button",s.value=this.strings.remove,s.onclick=function(){o.closePopup(),i.removeLayer(o)},n.appendChild(s)}var r=e.createElement("div");if(o.options.clickable=!0,o instanceof L.Marker){var l=e.createElement("div"),p=e.createTextNode(this.strings.title+": "),d=e.createElement("input");d.type="text",d.size=20,o._text&&(d.value=o._text.replace(/\\n/g,"\\\\n").replace(/[\r\n]+/g,"\\n")),l.appendChild(p),l.appendChild(d),l.style.marginBottom="8px",r.appendChild(l),o.inputField=d,o.options.draggable=!0,o.defaultIcon=new L.Icon.Default,d.onkeypress=function(e){var i=t.event?(e||t.event).which:e.keyCode;return 27==i||13==i?(o.closePopup(),e.preventDefault(),!1):void 0},o.on("popupopen",function(){d.focus()}),o.on("popupclose",function(){var t=o.inputField.value;L.LetterIcon&&this.options.letterIcons&&t.length>0&&t.length<=2?o.setIcon(new L.LetterIcon(t)):o.setIcon(o.defaultIcon)},this)}else{var c=e.createElement("div"),h=Object.getOwnPropertyNames(this.options.lineColors).sort();c.style.width=10+20*h.length+"px",c.textAlign="center";for(var u=function(t){var e=t.target.style;if("white"==e.borderColor){o.setStyle({color:e.backgroundColor,fillColor:e.backgroundColor}),o._colorName=t.target._colorName;for(var i=c.childNodes,n=0;n<i.length;n++)i[n].style.borderColor="white";e.borderColor="#aaa"}},g=0;g<h.length;g++)if("def"!==h[g]){var m=e.createElement("div");m._colorName=h[g],m.style.width="16px",m.style.height="16px",m.style.cssFloat="left",m.style.styleFloat="left",m.style.marginRight="3px",m.style.marginBottom="5px",m.style.cursor="pointer";var f=this.options.lineColors[h[g]];m.style.backgroundColor=f,m.style.borderWidth="3px",m.style.borderStyle="solid",m.style.borderColor=f==o.options.color?"#aaa":"white",m.onclick=u,c.appendChild(m)}r.appendChild(c),o.editing.enable()}return r.appendChild(n),o.bindPopup(r),o},_findMapInTextArea:function(e){var o=e.selectionStart,i=e.value;if(o>=i.length||i.length<10||i.indexOf("[/map]")<0)return"";var n=i.lastIndexOf("[map",o);if(n>=0){var a=i.indexOf("[/map]",n);if(a+5>=o){var s=i.substring(n,a+6);if(t.MapBBCodeProcessor.isValid(s))return s}}return""},_updateMapInTextArea:function(t,e,o){var i=t.selectionStart,n=t.value;t.value=e.length&&n.indexOf(e)>=0?n.replace(e,o):i>=n.length?n+o:n.substring(0,i)+o+n.substring(i)},editor:function(o,i,n,a){var s="string"==typeof o?e.getElementById(o):o;if(s){for(;s.firstChild;)s.removeChild(s.firstChild);var r=s.ownerDocument.createElement("div");r.style.height=this.options.editorHeight,s.appendChild(r);var l=L.map(r,L.extend({},{zoomControl:!1},this.options.leafletOptions));l.addControl(new L.Control.Zoom({zoomInTitle:this.strings.zoomInTitle,zoomOutTitle:this.strings.zoomOutTitle})),this._addLayers(l);var p=new L.FeatureGroup;p.addTo(l);var d;"string"!=typeof i&&(d=i,i=this._findMapInTextArea(d));for(var c=t.MapBBCodeProcessor.stringToObjects(i),h=c.objs,u=0;u<h.length;u++)this._makeEditable(this._objectToLayer(h[u]).addTo(p),p);this._zoomToLayer(l,p,{zoom:c.zoom,pos:c.pos},!0),L.drawLocal.draw.toolbar.actions.text=this.strings.cancel,L.drawLocal.draw.toolbar.actions.title=this.strings.drawCancelTitle,L.drawLocal.draw.toolbar.buttons.polyline=this.strings.polylineTitle,L.drawLocal.draw.toolbar.buttons.marker=this.strings.markerTitle,L.drawLocal.draw.handlers.marker.tooltip.start=this.strings.markerTooltip,L.drawLocal.draw.handlers.polyline.tooltip.start=this.strings.polylineStartTooltip,L.drawLocal.draw.handlers.polyline.tooltip.cont=this.strings.polylineContinueTooltip,L.drawLocal.draw.handlers.polyline.tooltip.end=this.strings.polylineEndTooltip,L.drawLocal.draw.handlers.polygon.tooltip.start=this.strings.polygonStartTooltip,L.drawLocal.draw.handlers.polygon.tooltip.cont=this.strings.polygonContinueTooltip,L.drawLocal.draw.handlers.polygon.tooltip.end=this.strings.polygonEndTooltip;var g=new L.Control.Draw({position:"topleft",draw:{marker:!0,polyline:{showLength:!1,guidelineDistance:10,shapeOptions:{color:this.options.lineColors.def,weight:5,opacity:.7}},polygon:this.options.enablePolygons?{showArea:!1,guidelineDistance:10,shapeOptions:{color:this.options.lineColors.def,weight:3,opacity:.7,fillOpacity:this.options.polygonOpacity}}:!1,rectangle:!1,circle:!1},edit:{featureGroup:p,edit:!1,remove:!1}});l.addControl(g),l.on("draw:created",function(t){var e=t.layer;this._makeEditable(e,p),p.addLayer(e),"marker"===t.layerType&&e.openPopup()},this);var m=L.functionButton("<b>"+this.strings.apply+"</b>",{position:"topleft",title:this.strings.applyTitle});m.on("clicked",function(){var e=[];p.eachLayer(function(t){e.push(this._layerToObject(t))},this),s.removeChild(s.firstChild);var o=t.MapBBCodeProcessor.objectsToString({objs:e,zoom:e.length?0:l.getZoom(),pos:e.length?0:l.getCenter()});d&&this._updateMapInTextArea(d,i,o),n&&n.call(a,o)},this),l.addControl(m);var f=L.functionButton(this.strings.cancel,{position:"topright",title:this.strings.cancelTitle});if(f.on("clicked",function(){s.removeChild(s.firstChild),n&&n.call(a,null)},this),l.addControl(f),this.options.showHelp){var y=L.functionButton('<span style="font-size: 18px; font-weight: bold;">?</span>',{position:"topright",title:this.strings.helpTitle});y.on("clicked",function(){for(var e="",o=this.strings.helpContents,i="resizable,status,dialog,scrollbars,height="+(this.options.windowHeight||this.options.fullViewHeight)+",width="+(this.options.windowWidht||this.options.viewWidth),n=t.open("","mapbbcode_help",i),a=0;a<o.length;a++)e+=a?"#"===o[a].substr(0,1)?"<h2>"+o[a].replace(/^#\s*/,"")+"</h2>":"<p>"+o[a]+"</p>":"<h1>"+o[0]+"</h1>";e+='<div id="close"><input type="button" value="'+this.strings.close+'" onclick="javascript:window.close();"></div>';var s="<style>body { font-family: sans-serif; font-size: 12pt; } p { line-height: 1.5; } h1 { text-align: center; font-size: 18pt; } h2 { font-size: 14pt; } #close { text-align: center; margin-top: 1em; }</style>";n.document.open(),n.document.write(s),n.document.write(e),n.document.close()},this),l.addControl(y)}}},editorWindow:function(e,o,i){t.storedMapBB={bbcode:e,callback:o,context:i,caller:this};var n=this.options.windowFeatures,a="height="+(this.options.windowHeight||this.options.editorHeight)+",width="+(this.options.windowWidth||this.options.viewWidth),s=location.href.match(/^(.+\/)([^\/]+)?$/)[1],r=s+this.options.libPath,l=t.open(this.options.usePreparedWindow?r+"mapbbcode-window.html":"","mapbbcode_editor",n+","+a);if(!this.options.usePreparedWindow){var p='<script src="'+r+'leaflet.js"></script>';p+='<script src="'+r+'leaflet.draw.js"></script>',p+='<script src="'+r+'mapbbcode.js"></script>',p+='<script src="'+r+'mapbbcode-config.js"></script>',p+='<link rel="stylesheet" href="'+r+'leaflet.css" />',p+='<link rel="stylesheet" href="'+r+'leaflet.draw.css" />',p+='<div id="edit"></div>',p+="<script>opener.storedMapBB.caller.editorWindowCallback.call(opener.storedMapBB.caller, window, opener.storedMapBB);</script>",l.document.open(),l.document.write(p),l.document.close()}},editorWindowCallback:function(t,e){t.document.body.style.margin=0;var o=new t.MapBBCode(this.options);o.setStrings(this.strings),o.options.editorHeight="100%",o.editor("edit",e.bbcode,function(o){t.close(),e.callback&&e.callback.call(e.context,o),this.storedMapBB=null},this)}}),L.LetterIcon=L.Icon.extend({options:{className:"leaflet-div-icon",color:"black",radius:11},initialize:function(t,e){this._letter=t,L.Icon.prototype.initialize(this,e)},createIcon:function(){var t=this.options.radius,o=2*t+1,i=e.createElement("div");return i.innerHTML=this._letter,i.className="leaflet-marker-icon",i.style.marginLeft=-t+"px",i.style.marginTop=-t+"px",i.style.width=o+"px",i.style.height=o+"px",i.style.borderRadius=t+2+"px",i.style.borderWidth="2px",i.style.borderColor="white",i.style.fontSize="10px",i.style.fontFamily="sans-serif",i.style.fontWeight="bold",i.style.textAlign="center",i.style.lineHeight=o+"px",i.style.color="white",i.style.backgroundColor=this.options.color,this._setIconStyles(i,"icon"),i},createShadow:function(){return null}}),t.MapBBCode.include({strings:{close:"Close",remove:"Delete",apply:"Apply",cancel:"Cancel",title:"Title",bing:"Bing",zoomInTitle:"Zoom in",zoomOutTitle:"Zoom out",applyTitle:"Apply changes",cancelTitle:"Cancel changes",fullScreenTitle:"Enlarge or shrink map panel",helpTitle:"Open help window",outerTitle:"Show this place on an external map",polylineTitle:"Draw a path",markerTitle:"Add a marker",drawCancelTitle:"Cancel drawing",markerTooltip:"Click map to place marker",polylineStartTooltip:"Click to start drawing a line",polylineContinueTooltip:"Click to continue drawing line",polylineEndTooltip:"Click the last point to finish line",polygonStartTooltip:"Click to start drawing a polygon",polygonContinueTooltip:"Click to continue drawing polygon",polygonEndTooltip:"Click the last point to close this polygon",helpContents:["Map BBCode Editor",'You have opened this help window from inside the map editor. It is activated with "Map" button. When the cursor in the textarea is inside [map] sequence, the editor will edit that bbcode, otherwise it will create new bbcode and insert it at cursor position after clicking "Apply".',"# BBCode","Map BBCode is placed inside <tt>[map]...[/map]</tt> tags. Opening tag may contain zoom with optional position in latitude,longitude format: <tt>[map=10]</tt> or <tt>[map=15,60.1,30.05]</tt>. Decimal separator is always a full stop.",'The tag contains a semicolon-separated list of features: markers and paths. They differ only by a number of space-separated coordinates: markers have one, and paths have more. There can be optional title in brackets after the list: <tt>12.3,-5.1(Popup)</tt> (only for markers in the editor). Title is HTML and can contain any characters, but "(" should be replaced with "\\(", and only a limited set of HTML tags is allowed.','Paths can have different colours, which are stated in <i>parameters</i>: part of a title followed by "|" character. For example, <tt>12.3,-5.1 12.5,-5 12,0 (red|)</tt> will produce a red path.',"# Map Viewer",'Plus and minus buttons on the map change its zoom. Other buttons are optional. A button with four arrows ("fullscreen") expands map view to maximum width and around twice the height. If a map has many layers, there is a layer switcher in the top right corner. There also might be a button with a curved arrow, that opens an external site (usually www.openstreetmap.org) at a position shown on the map.',"You can drag the map to pan around, press zoom buttons while holding Shift key to change zoom quickly, or drag the map with Shift pressed to zoom to an area. Scroll-wheel zoom is disabled in viewer to not interfere with page scrolling, but in works in map editor.","# Editor Buttons",'"Apply" saves map features (or map state if there are none) to a post body, "Cancel" just closes the editor panel. And you have already figured out what the button with a question mark does. Two buttons underneath zoom controls add features on the map.','To draw a path, press the button with a diagonal line and click somewhere on the map. Then click again, and again, until you\'ve got a nice polyline. Do not worry if you got some points wrong: you can fix it later. Click on the final point to finish drawing. Then you may fix points and add intermediate nodes by dragging small square or circular handlers. To delete a path (or a marker), click on it, and in the popup window press "Delete" button.',"Markers are easier to place: click on the marker button, then click on the map. In a popup window for a marker you can type a title: if it is 1 or 2 characters long, the text would appear right on the marker. Otherwise map viewers would have to click on a marker to read the title. A title may contain URLs and line feeds.","# Plugin",'Map BBCode Editor is an open source product, available at <a href="https://github.com/MapBBCode/mapbbcode">github</a>. You will also find there plugins for some of popular forum engines. All issues and suggestions can be placed in the github issue tracker.']}})}(window,document);