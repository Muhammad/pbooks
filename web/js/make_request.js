function makeRequest(url,entry_id) {
    var httpRequest;

    if (window.XMLHttpRequest) { // Mozilla, Safari, ...
        httpRequest = new XMLHttpRequest();
        if (httpRequest.overrideMimeType) {
            httpRequest.overrideMimeType('text/xml');
            // See note below about this line
        }
    } 
    else if (window.ActiveXObject) { // IE
        try {
            httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
            } 
            catch (e) {
                       try {
                            httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
                           } 
                         catch (e) {}
                      }
                                   }

    if (!httpRequest) {
        alert('Giving up :( Cannot create an XMLHTTP instance');
        return false;
    }
    httpRequest.open('GET', url, true);
    httpRequest.send(null);
    document.getElementById(entry_id).innerHTML="";
}