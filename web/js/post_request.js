function postRequest(url,id) {
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
    var makesure = confirm("You sure you want to do this?");
    if(makesure) { 
    httpRequest.open('POST', url, true);      
    httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    var makethepostanarray = "blah1=blahblah&bla2=blahblah";
    httpRequest.send(makethepostanarray);
    // document.getElementById(id).innerHTML="";
    window.location=url;
    return true;
    } else { 
        return false;
    }
}