var SMSAPI = require('smsapi');


exports.authenticateSimpleImpl = function (creds){
  const api = new SMSAPI();
  api.authentication.login(creds.user, creds.password);

  return function(onError, onSuccess){
    api
      .then(function(r){onSuccess(api);})
      .catch(function(e){onError(e);});
    return function (cancelError, cancelerError, cancelerSuccess) {
      cancelError();
    };
  };
};

exports.authenticateSimpleHashedImpl = function (creds){
  const api = new SMSAPI();
  api.authentication.loginHashed(creds.user, creds.md5password);

  return function(onError, onSuccess){
    api
      .then(function(r){onSuccess(api);})
      .catch(function(e){onError(e);});
    return function (cancelError, cancelerError, cancelerSuccess) {
      cancelError();
    };
  };
};

exports.sendSmsImpl = function (api){
  return function(inp){
    return function(onError, onSuccess){
      api.message.sms().from(inp.from).to(inp.to).message(inp.message).execute()
        .then(onSuccess())
        .catch(function(e){onError(e);});
      return function (cancelError, cancelerError, cancelerSuccess) {
        cancelError();
      };
    };
  };
};


exports.authenticateOAuth = function (token){
  return function(){
    return new SMSAPI({oauth:{accessToken: token.accessToken}});
  };
};
