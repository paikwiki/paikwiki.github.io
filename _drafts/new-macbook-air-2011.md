---
layout: post
title: New Macbook Air 2011
date:   2017-03-25
draft: true
---

CLI 친화적인 초기 환경 세팅법 확립을 위해 iTem2, Atom처럼 기본으로 사용하는 어플리케이션도 일단 설치
하지 않고 Homebrew 먼저 설치하기로 했습니다.

## 1. Homebrew 설치

```shell
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Xcode 커멘드라인 도구를 다운로드 받고 설치하는 시간이 꽤 걸립니다.

## 2. brewfile 작성

### 2.1. tap

tap은 Homebrew에 또다른 다른 저장소를 사용할 수 있도록 해줍니다. tap을 설정해주면 Homebrew를 통해
설치할 수 있는 툴이 늘어난다고 할 수 있습니다.

```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Taps
#-------------------------------------------------------------------------------

tap 'caskroom/cask'
tap 'caskroom/fonts'
tap 'caskroom/versions'
tap 'homebrew/dupes'
tap 'homebrew/php'
tap 'homebrew/services'
tap 'homebrew/versions'
```

[caskroom/cask](https://caskroom.github.io/)은 Chrome, iTerm2, Atom 등 다양한 어플리
케이션을 터미널에서 한 줄의 명령어로 설치할 수 있도록 해줍니다.
[caskroom/versions](https://github.com/caskroom/homebrew-versions)을 사용하면  beta,
nightly 버전 등 다양한 버전의 어플리케이션을 설치할 수 있습니다. [homebrew/versions]()는 어플리
케이션이 아닌 커멘드라인 툴의 다양한 버전을 설치할 수 있게 해줍니다. 저는 주로 최근 stable 버전을 사용하
는 편이지만 일단 설치해 두기로 했습니다.
bugfix 버전을 받기 위해 [homebrew/dupes](https://github.com/Homebrew/homebrew-dupes)
를 설치합니다. [homebrew/services](https://github.com/Homebrew/homebrew-services)는
deamon, agent를 관리하는 [luanchctl](https://ss64.com/osx/launchctl.html)을 편리하게
사용할 수 있도록 도와줍니다.

### 2.2. 어플리케이션 설치 경로 지정

다음으로 caskroom으로 설치할 어플리케이션의 설치 경로를 지정합니다. `Brewfile` 적용시 경로를 지정해주
지 않으면 어플리케이션이 `~/Applications` 폴더에 설치됩니다. 기본 설치 경로인 `/Applications`에
설치할 수 있도록 변경해 줍니다.

```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Make sure apps get installed in system Applications dir
#-------------------------------------------------------------------------------

cask_args appdir: '/Applications'
```

### 2.3. Bash 4
```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Install Bash 4
#-------------------------------------------------------------------------------

brew 'bash'
```

bash 4도 설치합니다. 기본으로 설치돼 있는 쉘은 3.2 버전이네요. [bash-hackers Wiki](http://wiki.bash-hackers.org)
의 [Bash 4 - a rough overview](http://wiki.bash-hackers.org/bash4)에서 두 버전 간의
차이를 볼 수 있습니다.

### 2.4. Binaries

```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Install Binaries
#-------------------------------------------------------------------------------

brew 'awscli'
brew 'git'
brew 'mackup'
brew 'node@6', args: ['with-full-icu', 'with-npm']
brew 'openssl'
brew 'pandoc'
brew 'wget'
```

필요한 바이너리를 설치합니다. [mackup](https://github.com/lra/mackup)은 맥OS 어플리케이션의
설정을 백업해 줍니다. 예전에 atom 설정파일을 백업하기 위해 [sync-settings](https://atom.io/packages/sync-settings)
를 세팅한 후 Mackup을 알고 허무했던 기억이 있는데요, Mackup은 2017년 3월 현재 Atom을 포함한 365
종의 어플리케이션 설정을 백업할 수 있습니다.

### 2.5. Programming languages

php를 설치합니다.

```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Development-PHP
# @see $ brew info php71, which reads...
# With the release of macOS Sierra the Apache module is now not built by default.
# If you want to build it on your system you have to install php with the
# --with-httpd24 option. See  brew options php71  for more details.
#-------------------------------------------------------------------------------

brew 'php71' #, args: ['without-apache']
brew 'php71-intl'
brew 'php71-mecab'
brew 'php71-redis'
brew 'php71-xdebug'
brew 'phpdocumentor'
brew 'composer'
brew 'phpunit'
brew 'php-cs-fixer'
```

다음은 Ruby와 Python 그리고 각종 데이터베이스를 설치합니다.

```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Development-Ruby
#-------------------------------------------------------------------------------

brew 'ruby'
brew 'rbenv'

#-------------------------------------------------------------------------------
# Development-Python (includes pip, easy_install)
#-------------------------------------------------------------------------------

brew 'python', args:['with-sphinx-doc']
brew 'python3', args:['with-sphinx-doc']
brew 'pyenv-virtualenv'

#-------------------------------------------------------------------------------
# Development-Database
#-------------------------------------------------------------------------------

# brew 'mariadb'
brew 'mysql'
brew 'sqlite'
brew 'mongodb'
```

### 2.6. Applications

이번엔 어플리케이션을 설치합니다.

```shell
# Brewfile(continued)

#-------------------------------------------------------------------------------
# Apps
#-------------------------------------------------------------------------------

cask 'atom'
cask 'bestres'
cask 'calibre'
cask 'clipmenu-alpha'
cask 'docker'
cask 'dropbox'
cask 'evernote'
cask 'firefox'
cask 'google-chrome'
cask 'google-drive'
cask 'intellij-idea'
cask 'iterm2'
cask 'keycastr'
cask 'moom'
cask 'phpstorm'
cask 'sequel-pro'
cask 'slack'
cask 'spectacle'
cask 'spotify'
cask 'telegram'
cask 'tunnelbear'
```

### 2.7. Font

폰트를 설치할 차례입니다. 폰트는 Adobe의 [Source Code Pro](https://github.com/adobe-fonts/source-code-pro)
를 설치합니다.

```shell
#-------------------------------------------------------------------------------
# Fonts
#-------------------------------------------------------------------------------

cask 'font-source-code-pro'
```

이제 `Brewfile`을 완성했습니다. Homebrew로 설치하지 못한 어플리케이션을 새로운 파일을 만들어 정리해 둡
니다. 맥북의 초기 세팅 작업을 할 때 이 파일을 참고하여 필요한 어플리케이션을 빠짐없이 설치할 수 있습니다.

## 3. Manual install applications

직접 설치해야 하는 어플리케이션을 기록한 파일의 이름은 `manual_install_applications`입니다.

```shell
# manual_install_applications

#-------------------------------------------------------------------------------
# List of applications that should be installed manually
#-------------------------------------------------------------------------------

Calendar 2
iA Writer
Pages
PhotoScape X
Numbers
Keynote
```

## 4. Bootstrap.sh 작성하기

## 5. 새 맥북 세팅하기

### 5.1. Xcode 설치
### 5.2. Xcode 커멘드 라인 도구 설치

```shell
$ sudo xcodebuild -license
$ xcode-select --install
```

참고문서: http://blog.appkr.kr/work-n-play/dotfiles/
