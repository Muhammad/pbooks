// Courtesy of Joey 
// Public Domain Code
// http://joey.kitenet.net/blog/entry/relative_dates_in_html/

var dateElements;
window.onload = getDates;

function getDates() {
    dateElements = getElementsByClass('date');
    for (var i = 0; i < dateElements.length; i++) {
        var elt = dateElements[i];
        var title = elt.attributes.title;
        var d = new Date(title ? title.value : elt.innerHTML);
        if (! isNaN(d)) {
            dateElements[i].date=d;
            elt.title=elt.innerHTML;
        }
    }

    showDates();
}

function showDates() {
    for (var i = 0; i < dateElements.length; i++) {
        var elt = dateElements[i];
        var d = elt.date;
        if (! isNaN(d)) {
            elt.innerHTML=relativeDate(d);
        }
    }
    setTimeout(showDates,30000); // keep updating every 30s
}

function getElementsByClass(cls, node, tag) {
        if (document.getElementsByClass)
                return document.getElementsByClass(cls, node, tag);
        if (! node) node = document;
        if (! tag) tag = '*';
        var ret = new Array();
        var pattern = new RegExp("(^|\\s)"+cls+"(\\s|$)");
        var els = node.getElementsByTagName(tag);
        for (i = 0; i < els.length; i++) {
                if ( pattern.test(els[i].className) ) {
                        ret.push(els[i]);
                }
        }
        return ret;
}

var timeUnits = new Array;
timeUnits['minute'] = 60;
timeUnits['hour'] = timeUnits['minute'] * 60;
timeUnits['day'] = timeUnits['hour'] * 24;
timeUnits['month'] = timeUnits['day'] * 30;
timeUnits['year'] = timeUnits['day'] * 364;
var timeUnitOrder = ['year', 'month', 'day', 'hour', 'minute'];

function relativeDate(date) {
    var now = new Date();
    var offset = date.getTime() - now.getTime();
    var seconds = Math.round(Math.abs(offset) / 1000);

    var ret = "";
    var shown = 0;
    for (i = 0; i < timeUnitOrder.length; i++) {
        var unit = timeUnitOrder[i];
        if (seconds >= timeUnits[unit]) {
            var num = Math.floor(seconds / timeUnits[unit]);
            seconds -= num * timeUnits[unit];
            if (ret)
                ret += "and ";
            ret += num + " " + unit + (num > 1 ? "s" : "") + " ";

            if (++shown == 2)
                break;
        }
        else if (shown)
            break;
    }

    if (! ret)
        ret = "less than a minute "

    return ret + (offset < 0 ? "ago" : "from now");
}

