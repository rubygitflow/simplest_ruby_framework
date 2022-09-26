# SimplestRubyFramework

**SimplestRubyFramework** is a little web framework written in [Ruby](https://www.ruby-lang.org) language. It's compatible with [Rack](https://rack.github.io) interface and intended to **learn** how web frameworks work in general. This framework is forked from [Simpler](https://github.com/psylone/simpler).

It utilizes '.ERB' templating format for front pages, and offers **'.JRB'** templating format (i.e. **[JSON5](https://ru.wikipedia.org/wiki/JSON#JSON5)**) for RestApi.

## The application overview

SimplestRubyFramework application is a singleton instance of the `SimplestRubyFramework::Application` class. For convenience it can be obtained by calling `SimplestRubyFramework.application` method. This instance holds all the routes and responds to `call` method which is required by the Rack interface.

### Install SimplestRubyFramework app

```
$ cd path/to/the/simplest_ruby_framework/
$ bundle
```

### Run SimplestRubyFramework app

1. Launch the server
```
$ rackup
```

2.Send a request to the app
```
curl --url "http://localhost:9292" -v
curl --url "http://localhost:9292/tests" -v -X GET
curl --url "http://localhost:9292/tests" -v -X POST
curl --url "http://localhost:9292/tests/0" -v -X GET
curl --url "http://localhost:9292/api/v1/tests" -v -X GET
curl --url "http://localhost:9292/api/v1/health" -v -X GET
```
