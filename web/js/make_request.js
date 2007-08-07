  function makeRequest(url,entry_id,method,parameters,doublecheck,next) {
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
    if(doublecheck!=='false') { 
        var makesure = confirm(doublecheck);
        if(makesure) { 
            
            httpRequest.open(method, url, true);  
            httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            httpRequest.send(parameters);
            mytbl = document.getElementById("accounts_table");
            if(next=="reload") { 
                setTimeout('window.location.reload()',200);
            } else { 
                if(mytbl.rows.length > 0) { 
                    mytbl.deleteRow(entry_id);
                } else {
                    document.getElementById(entry_id).innerHTML="";
                }
                return true;
            }
        } else { 
            return false;
        }
    
    
    } else { 

        httpRequest.open(method, url, true);  
        httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        httpRequest.send(parameters);
            if(next=="reload") { 
                setTimeout('window.location.reload()',200);
            } else { 
                if(entry_id!==0) { 
                    document.getElementById(entry_id).innerHTML="";
                    return true;
                }
            }
    }
    
    
    
    
}