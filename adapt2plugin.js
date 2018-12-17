/* 
 * some function to make a dynamic day selector from
 * Day Schedule Selector plugin from artsy
 *
 * cvt2plugin : adapt calendar.pl format to format required by this plugin
 * calendar_get : read calendar.txt and convert it
 *
 */
function cvt2plugin (cal)
{
var on_regexp = /(\d):\s*(\d\d:\d\d)\s*=>\s*On\s*\1:\s*(\d\d:\d\d)\s*=>\s*Off/g;
var timetable = [];
var answer = [];
   for (ark=0 ; ark<7 ; ark++)   timetable[ark] = [];
   match_on = on_regexp.exec (cal);
   while (match_on!==null)
   {
        console.log ( "On: " + match_on[1] +"\t"  + match_on[2] + "->" + match_on[3]  );
        timetable[match_on[1]].push ('["' + match_on[2] + '", "' + match_on[3] + '"]');
        match_on = on_regexp.exec (cal);
   }
   for (ark=0 ; ark<timetable.length  ; ark++)
        answer.push ('"' + ark + '":   ' + '[' + timetable[ark] + ']');
   return answer.join(",\n");
}

// get calendar : be sure to be synchronous !!
// and add a timestamp to defeat caching!
function calendar_get(url)
{
   var xmlHttp = new XMLHttpRequest();
   xmlHttp.open ("GET", 
                  url + ((/\?/).test(url) ? "&" : "?") + (new Date()).getTime(),
                  false);  // false mandatory
   xmlHttp.send (null);
   console.log (xmlHttp.responseText);
   return '{ ' + cvt2plugin(xmlHttp.responseText) + '  }';
}

