var coimCallback = (function() {
    function cb()  {
        cb.prototype.success = function(obj) {
            console.log("proto success: " + obj['message']);
        };
        cb.prototype.fail = function(str)  {
            console.log("proto fail: " + str);
        };
        cb.prototype.invalid = function()  {
            console.log("proto invalid");
        };
        cb.prototype.progress = function(prog)  {
            console.log("proto progress: " + prog);
        };
    };
    return cb;
})();

var callbackMapping = function(success, fail, invalid, progress, response){
    if(success instanceof coimCallback) {
        if(response['type'] === "success") {
            success.success(response['result']);
        }
        else if(response['type'] === "fail") {
            success.fail(response['result']);
        }
        else if(response['type'] === "invalid") {
            success.invalid();
        }
        else if(response['type'] === "progress") {
            success.progress(response['result']);
        }
    }
    else {
        
        if(response['type'] === "success") {
            success(response['result']);
        }
        else if(response['type'] === "fail") {
            fail(response['result']);
        }
        else if(response['type'] === "invalid" && (invalid !== undefined && invalid !== null)) {
            invalid();
        }
        else if(response['type'] === "progress" && (progress !== undefined && progress !== null)) {
            progress(response['result']);
        }
    }
}

var coimPlugin = {
    callback: coimCallback,
    getToken: function(success) {
        cordova.exec(
            function(token) {
                console.log(token['result']);
                if(token['type'] === "token") {
                    if(token['result'] === "")
                        success(null);
                    
                    else
                        success(token['result']);
                }
                else
                    success(null);
            },
            function(error) {
                success(null);
            },
            "coimPlugin",
            "getToken",
            []);
    },
    send: function(relativeURL, params, success, fail, invalid){
        var args = arguments,
            _url = args[0],
            _params = undefined,
            _success = undefined,
            _fail = undefined,
            _invalid = undefined;
        
        if(!(typeof _url === "string")) {
            alert("(coim plugin) lack of relative url string.");
            return;
        }
        
        if(typeof args[1] === "function") {
            _params = {};
            _success = args[1];
            _fail = args[2];
            _invalid = args[3];
        }
        else if (args[1] instanceof coimCallback) {
            _params = {};
            _success = args[1];
        }
        else {
            if(typeof args[1] === "object" && args[1] !== null) {
                _params = args[1];
                _success = args[2];
                _fail = args[3];
                _invalid = args[4];
            }
            else if(args[1] === null) {
                _params = {};
                _success = args[2];
                _fail = args[3];
                _invalid = args[4];
            }
            else {
                alert("(coim plugin) params must be object.");
                return;
            }
        }
        

        cordova.exec(
            function(winParam) {
                callbackMapping(_success, _fail, _invalid, null, winParam);
            },
            function(error) {
                if(_fail !== undefined)
                     _fail(error);
                else
                     _success.fail(error);
            },
            "coimPlugin",
            "send", 
            [{"relativeURL":_url, "param":_params}]);
    },
    
    login: function(relativeURL, params, success, fail){
        var args = arguments,
            _url = args[0],
            _params = args[1],
            _success = undefined,
            _fail = undefined;
        
        if(!(typeof _url === "string")) {
            alert("(coim plugin) lack of relative url string.");
            return;
        }
        
        if(_params instanceof coimCallback || typeof _params === "function") {
            alert("(coim plugin) login requires params.");
            return;
        }
        
        if(typeof args[2] === "function") {
            _success = args[2];
            _fail = args[3];
        }
        else if (args[2] instanceof coimCallback) {
            _success = args[2];
        }
        
        cordova.exec(
            function(winParam) {
                callbackMapping(_success, _fail, null, null, winParam);
            },
             function(error) {
                if(_fail !== undefined)
                     _fail(error);
                else
                     _success.fail(error);
             },
            "coimPlugin",
            "login",
            [{"relativeURL":_url, "param":_params}]);
    },
    
    register: function(params, success, fail){
        var args = arguments,
        _params = args[0],
        _success = undefined,
        _fail = undefined;
        
        if(_params instanceof coimCallback || typeof _params === "function") {
            alert("(coim plugin) register requires params.");
            return;
        }
        
        if(typeof args[1] === "function") {
            _success = args[1];
            _fail = args[2];
        }
        else if (args[1] instanceof coimCallback) {
            _success = args[1];
        }
        
        cordova.exec(
                function(winParam) {
                    callbackMapping(_success, _fail, null, null, winParam);
                },
                function(error) {
                     if(_fail !== undefined)
                        _fail(error);
                     else
                        _success.fail(error);
                },
                "coimPlugin",
                "register", 
                [{"relativeURL":"", "param":_params}]);
    },
    
    updPasswd: function(params, success, fail){
        var args = arguments,
        _params = args[0],
        _success = undefined,
        _fail = undefined;
        
        if(_params instanceof coimCallback || typeof _params === "function") {
            alert("(coim plugin) updPasswd requires params.");
            return;
        }
        
        if(typeof args[1] === "function") {
            _success = args[1];
            _fail = args[2];
        }
        else if (args[1] instanceof coimCallback) {
            _success = args[1];
        }
        
        cordova.exec(
                function(winParam) {
                    callbackMapping(_success, _fail, null, null, winParam);
                },
                function(error) {
                     if(_fail !== undefined)
                        _fail(error);
                     else
                        _success.fail(error);
                },
                "coimPlugin",
                "updPasswd", 
                [{"relativeURL":"", "param":_params}]);
    },
    
    logout: function(success, fail){
        var args = arguments,
        _success = undefined,
        _fail = undefined;
        
        if(typeof args[0] === "function") {
            _success = args[0];
            _fail = args[1];
        }
        else if (args[0] instanceof coimCallback) {
            _success = args[0];
        }
        
        cordova.exec(
                function(winParam) {
                    callbackMapping(_success, _fail, null, null, winParam);
                },
                function(error) {
                     if(_fail !== undefined)
                        _fail(error);
                     else
                        _success.fail(error);
                },
                "coimPlugin",
                "logout", 
                [{"relativeURL":"", "param":{}}]);
    },
    
    attach: function(relativeURL, params, files, success, fail, progress){
        
        var args = arguments,
        _url = args[0],
        _params = args[1],
        _files = args[2]
        _success = undefined,
        _fail = undefined,
        _progress = undefined;
        
        if(!(typeof _url === "string")) {
            alert("(coim plugin) lack of relative url string.");
            return;
        }
        
        if(_params instanceof coimCallback || (typeof _params === "function") ||
           _files instanceof coimCallback || (typeof _files === "function")) {
            alert("(coim plugin) attach requires params and files.");
            return;
        }
        
        if(typeof args[3] === "function") {
            _success = args[3];
            _fail = args[4];
            _progress = args[5];
        }
        else if (args[3] instanceof coimCallback) {
            _success = args[3];
        }
        
        cordova.exec(
                function(winParam) {
                    callbackMapping(_success, _fail, null, _progress, winParam);
                },
                function(error) {
                     if(_fail !== undefined)
                        _fail(error);
                     else
                        _success.fail(error);
                },
                "coimPlugin",
                "attach", 
                [{"relativeURL":relativeURL, "param":params, "files": files}]);
    }
}
var coim = coimPlugin;
module.exports = coimPlugin;
