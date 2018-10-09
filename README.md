# purescript-smsapi

Set of arbitrarily chosen bindings to NPM's smsapi package, which itself is a Node's client to smsapi.pl (https://www.smsapi.pl/)


## Installation

Install library's npm dependency in your Purescript project:

```
npm i smsapi
```

Then simply add Purescript bindings as dependency in your Purescript project:

```
bower install purescript-smsapi
```

## Usage

```purescript

main = launchAff_ do
  let to = +48123456789
      acessToken = -- oauth access token from smsapi.pl --
      message = "Hello World!"
  sendSms { msgType: Eco, to, message} =<< liftEffect (authenticateOAuth { accessToken })

```

## Library status & contribution

Currently library supports only very small subset of npm's client API.
If you're interested in unavailable yet features, please file an issue of considering creating a pull request.
The library is simple and readable.

## Credits

Library is co-created and funded by [`λ-terms`](https://github.com/lambdaterms/)

## Module documentation

Module documentation is [published on Pursuit](http://pursuit.purescript.org/packages/purescript-smsapi).

## License & copyrights

See LICENSE file.
