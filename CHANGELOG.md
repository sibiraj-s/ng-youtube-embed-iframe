# CHANGELOG

All notable changes to this project will be documented in this file.

> **Tags**
> - Features
> - Bug Fixes
> - Performance Improvements
> - Dependency Updates
> - Breaking Changes
> - Documentation
> - Internal

## Unreleased

#### Dependency Updates

* update devDependencies ([242acac](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/242acac))

#### Internal

* apply standardjs rules to eslint ([16c20af](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/16c20af))
* use two space identation instead of four for all files ([96a1669](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/96a1669))

## v1.2.8 (2018-07-27)

Just a Maintenance Patch

#### Internal

* run travis builds in trusty environment ([5a21abc](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/5a21abc))
* use eslint to lint javascript files ([5a21abc](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/5a21abc))
* replace grunt-coffeelint with grunt-coffeelintr ([5a21abc](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/5a21abc))
* remove commitizen and cz-conventional-changelog dependencies ([5a21abc](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/5a21abc))
* add prepublish script to prevent direct execution of `npm publish` ([5a21abc](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/5a21abc))

## v1.2.7 (2018-07-17)

Just a Maintenance Patch

#### Dependency Updates

* update devDependencies to remove dependencies with vulnerability ([998b499](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/998b499))

#### Internal

* update docs
* remove pullapprove
* migrate to travis-ci.com

## v1.2.6 (2018-07-10)

Just a Maintenance Release.

#### Dependency Updates

* update devDependencies and code maintenance ([2a45e71](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/2a45e71))

## v1.2.5 (2018-03-27)

#### Internal

* remove yarn ([f777016](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/f777016))
* remove devDependencies from package.json while publish ([4600aea](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/4600aea))

## v1.2.4 (2018-03-26)

#### Documentation

* fix broken links ([703f63f](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/703f63f))

## v1.2.3 (2018-03-26)

#### Internal

* update Gruntfile.coffee ([4e5a016](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/4e5a016))
* delete unused devDependencies ([7a0457d](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/7a0457d))
* add post-build actions ([0ffef32](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/0ffef32))

#### Dependency Updates

* update devDependencies ([a8c3c3e](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/a8c3c3e))

## v1.2.2 (2017-11-28)

#### Internal

* drop bower support
* publish only `dist/` folder to npm
* add angularjs as a peerDependency

#### Breaking Changes

* bower installations will not be supported anymore, use npm or yarn

## v1.2.1 (2017-11-09)

#### Bug Fixes

* fix player not created while routing ([7d120b3](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/7d120b3))

## v1.2.0 (2017-10-20)

#### Features

* allow multiple player to be created ([4a9047d](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/4a9047d))

#### Dependency Updates

* remove ng-sanitize as  dependency ([4a9047d](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/4a9047d))

#### Bug Fixes

* fix `ytPlayer` unable to access in controller ([4a9047d](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/4a9047d))

#### Breaking Changes

* every element must be provided with unique id

## v1.1.2 (2017-07-07)

#### Performance Improvements

* modular approach method to avoid unwanted errors  ([fea7a0b](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/fea7a0b))
* compatible with strict-di mode  ([fea7a0b](https://github.com/Sibiraj-S/ng-youtube-embed-iframe/commit/fea7a0b))

## v1.1.1 (2017-07-04)

#### Dependency Updates

* update angular.js to [v1.6.5](https://github.com/angular/angular.js/blob/master/CHANGELOG.md#165-toffee-salinization-2017-07-03)

## v1.1.0 (2017-06-21)

#### Performance Improvements

* code optimization
* destroy player on view change

#### Breaking Changes

* set/get player options via `youtubePlayerConfig` is removed

## v1.0.1 (2017-06-20)

#### Documentation

* update docs for the player

## v1.0.0 (2017-06-20)

Initial Release. An Angular directive for Youtube Iframe API
