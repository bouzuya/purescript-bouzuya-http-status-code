# purescript-bouzuya-http-status-code

HTTP status code.

## Badge

[![Travis CI][travis-ci-badge]][travis-ci]
[![Bower][bower-badge]][bower]
[![Pursuit][pursuit-badge]][pursuit]

## Installation

```
bower install purescript-bouzuya-http-status-code
```

## Documentation

Module documentation is [published on Pursuit][pursuit].

## How to build

See: [`.travis.yml`](.travis.yml).

## How to publish

(first time)

```sh
$ $(npm bin)/bower login --token $GITHUB_TOKEN
$ $(npm bin)/bower register purescript-bouzuya-http-status-code https://github.com/bouzuya/purescript-bouzuya-http-status-code.git
```

```sh
$ npm run pulp:version [BUMP] # major or minor or patch
$ git push origin master
$ git push --tags
$ # npm run pulp:publish # run by Travis CI
```

[bower]: https://github.com/bouzuya/purescript-bouzuya-http-status-code
[bower-badge]: https://img.shields.io/bower/v/purescript-bouzuya-http-status-code.svg
[pursuit]: https://pursuit.purescript.org/packages/purescript-bouzuya-http-status-code
[pursuit-badge]: https://pursuit.purescript.org/packages/purescript-bouzuya-http-status-code/badge
[travis-ci]: https://travis-ci.org/bouzuya/purescript-bouzuya-http-status-code
[travis-ci-badge]: https://img.shields.io/travis/bouzuya/purescript-bouzuya-http-status-code.svg
