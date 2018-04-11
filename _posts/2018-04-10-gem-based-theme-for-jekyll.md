---
layout: post
title: 젬 기반의 지킬 테마 적용하기
date: 2018-04-10
---

## 들어가며

깃허브(Github)에서 만든 [지킬(Jekyll)](https://jekyllrb.com/)은 깃허브 페이지(Github Pages)에서 사용할 수 있는 루비(Ruby) 기반의 정적 사이트 제너레이터(Static Site Generator)다. 2008년 톰 프레스톤 베르너(Tom Preston Werner)가 블로그를 이용하는 데 있어, 블로그 운영자가 콘텐츠에 집중할 수 있게 돕는다는 취지로 만들었다. 지킬은 오랜 역사를 가진 만큼 많은 플러그인이 있으며, 검색을 통해 다양한 정보를 얻을 수 있다. 또한, 지킬은 깃허브 저장소(Repository)에 몇 가지 규칙을 적용한 후, 저장소에 소스코드를 푸시(Push)하면 깃허브에서 빌드 작업을 수행해주는 깃허브 페이지(Github Pages)의 공식 지원 도구이다.

[깃허브 페이지에서 지원하는 젬 기반의 지킬 테마(Gem-based themes)](https://pages.github.com/themes/)를 적용하면, 설정 파일에 해당 테마의 젬을 포함하기만 해도 해당 테마를 블로그에 적용할 수 있다. 이번 포스트에서는 기본 테마([미니마 테마(Minima theme)](https://github.com/jekyll/minima))를 사용하는 블로그를 생성한 후, 다른 테마([어썸 테마(Awesome theme)](https://github.com/pawelgrzybek/jekyll-theme-awesome/))로 변경하는 과정을 진행해본다.

## 지킬 블로그 생성하기

새로운 지킬 블로그를 생성하는 명령어는 `jekyll new {blogName}`이다.

```sh
[jekyll-themes]$  jekyll new test-gbt
Running bundle install in /Users/chPaik/Sites/jekyll-themes/test-gbt...
  Bundler: The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
  Bundler: Fetching gem metadata from https://rubygems.org/...............
  Bundler: Fetching gem metadata from https://rubygems.org/..
  Bundler: Resolving dependencies...
  Bundler: Using public_suffix 3.0.2
  Bundler: Using addressable 2.5.2
  Bundler: Using bundler 1.16.1
  Bundler: Using colorator 1.1.0
  .
  .
  .
  Bundler: Using jekyll 3.7.3
  Bundler: Using jekyll-feed 0.9.3
  Bundler: Using jekyll-seo-tag 2.4.0
  Bundler: Using minima 2.4.1
  Bundler: Bundle complete! 4 Gemfile dependencies, 29 gems now installed.
  Bundler: Use `bundle info [gemname]` to see where a bundled gem is installed.
New jekyll site installed in /Users/chPaik/Sites/jekyll-themes/test-gbt.
```

이렇게 새로운 블로그를 생성하면 미니마 테마가 세팅된다. 폴더로 이동해 로컬 서버에서 실행한다.

```sh
[jekyll-themes]$  cd test-gbt/
[test-gbt]$  jekyll serve
WARN: Unresolved specs during Gem::Specification.reset:
      listen (~> 3.0)
      rouge (< 4, >= 1.7)
      rb-fsevent (>= 0.9.4, ~> 0.9)
      ffi (< 2, >= 0.5.0)
WARN: Clearing out unresolved specs.
Please report a bug if this causes problems.
Configuration file: /Users/chPaik/Sites/jekyll-themes/test-gbt/_config.yml
            Source: /Users/chPaik/Sites/jekyll-themes/test-gbt
       Destination: /Users/chPaik/Sites/jekyll-themes/test-gbt/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
                    done in 0.572 seconds.
 Auto-regeneration: enabled for '/Users/chPaik/Sites/jekyll-themes/test-gbt'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

웹브라우저로 블로그에 접속하면 아래와 같은 화면을 볼 수 있다.

![미니마 테마 메인페이지 캡처 이미지](/assets/images/2018/jekyll-gem-based-theme-1.jpg)
[그림]미니마 테마 메인페이지 캡처 이미지

![미니마 테마 페이지 캡처 이미지](/assets/images/2018/jekyll-gem-based-theme-3.jpg)
[그림]미니마 테마 페이지 캡처 이미지

![미니마 테마 포스트 캡처 이미지](/assets/images/2018/jekyll-gem-based-theme-2.jpg)
[그림]미니마 테마 포스트 캡처 이미지

## 다른 테마로 변경하기

먼저 `Gemfile`을 열어 미니마 테마 대신 다른 테마를 프로젝트에 추가한다. `"minima", "~> 2.0"`을 지우고 `"jekyll-theme-awesome"`을 입력한다.

```sh
# ./Gemfile
gem "jekyll-theme-awesome"
```

`_config.yml`을 수정하기 전에 `bundle` 명령어로 젬의 변경사항을 적용한다.

```sh
[test-gbt]$ bundle
The dependency tzinfo-data (>= 0) will be unused by any of the platforms Bundler is installing for. Bundler is installing for ruby but the dependency is only for x86-mingw32, x86-mswin32, x64-mingw32, java. To add those platforms to the bundle, run `bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java`.
Fetching gem metadata from https://rubygems.org/............
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
Using public_suffix 3.0.2
Using addressable 2.5.2
Using bundler 1.16.1
.
.
.
Using jekyll-theme-awesome 0.1.0
Bundle complete! 4 Gemfile dependencies, 28 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

`_config.yml`의 `theme`를 어썸 테마로 변경한다. 필요에 따라 `Gemfile`에 여러 개의 테마를 지정해둘 수 있지만 `_config.yml`에는 반드시 하나의 테마만 지정해야 한다. 따라서 `Gemfile`에 굳이 하나 이상의 테마를 추가할 필요는 없다.

```sh
# ./_config.yml
theme: jekyll-theme-awesome
```

이렇게 테마를 변경한 후, 다시 `jekyll serve`를 실행하여 웹브라우저로 접속해보면 아무 컨텐츠도 나오지 않는다. 미니마 테마와 어썸 테마의 레이아웃이 다르기 때문이다. 미니마 테마는 첫 화면에서 포스트의 목록을 보여주기 위해 `home` 레이아웃을 갖고 있다. 하지만 어썸 테마는 `home` 레이아웃이 없다. `jekyll serve`를 실행했을 때, 이와 관련한 에러 메시지를 발견할 수 있다.

```sh
[test-gbt]$ jekyll serve
WARN: Unresolved specs during Gem::Specification.reset:
      listen (~> 3.0)
      rouge (< 4, >= 1.7)
      rb-fsevent (>= 0.9.4, ~> 0.9)
      ffi (< 2, >= 0.5.0)
WARN: Clearing out unresolved specs.
Please report a bug if this causes problems.
Configuration file: /Users/chPaik/Sites/jekyll-themes/test-gbt/_config.yml
            Source: /Users/chPaik/Sites/jekyll-themes/test-gbt
       Destination: /Users/chPaik/Sites/jekyll-themes/test-gbt/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
     Build Warning: Layout 'home' requested in index.md does not exist.
                    done in 0.54 seconds.
 Auto-regeneration: enabled for '/Users/chPaik/Sites/jekyll-themes/test-gbt'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

`jekyll new {blogName}`으로 생성한 블로그의 `index.md`에는 프런트매터(Front-matter)만 있어서 `page`나 `post` 레이아웃을 적용해도 콘텐츠의 출력 부분은 빈 상태로 출력된다. 어썸 테마가 잘 작동하는지 확인하려면 미니마 테마에서 기본 제공하는 예제 페이지와 예제 포스트에 접속해야 한다.

- 예제 페이지: http://127.0.0.1:4000/about
- 예제 포스트: http://127.0.0.1:4000/jekyll/update/{YYYY}/{MM}/{DD}/welcome-to-jekyll

![어썸 테마 페이지 캡처이미지](/assets/images/2018/jekyll-gem-based-theme-4.jpg)
[그림]어썸 테마 페이지 캡처이미지

![어썸 테마 포스트 캡처이미지](/assets/images/2018/jekyll-gem-based-theme-5.jpg)
[그림]어썸 테마 포스트 캡처이미지

## 깃허브 페이지의 제한적 젬-기반의-테마 지원

젬 기반의 테마를 활용하면 프로젝트 디렉토리 내에서 테마 관련 소스를 직접 관리하지 않아도 된다. 만약 수정이 필요하다면 그에 해당하는 부분만 오버라이딩해서 사용할 수 있기 때문에, 블로그 운영자는 테마에 관한 많은 부분을 외부에 위임하고 콘텐츠에 집중할 수 있다. 하지만 블로그를 운영하겠다고 마음 먹은 사용자 중 기본 테마나 이미 만들어진 젬 기반 테마를 그대로 활용하고 싶은 이는 없을 것이다. 결국 어느 정도의 커스터마이징 작업이 필요하며, 이 과정에서 "콘텐츠에 집중"하겠다는 첫 목표와는 점점 멀어지기 마련이다. 완벽하게 마음에 드는 테마를 찾기란 쉽지 않은 일이다. 게다가 젬 기반의 테마 중 마음에 드는 것을 찾았다 해도 문제가 완전히 해결되진 않는다. 깃허브 페이지가 지원하는 젬 기반의 테마가 한정적이기 때문이다. 지킬의 기본 테마인 미니마를 제거하고 원하는 젬 기반의 테마를 세팅한다 해도, 깃허브 페이지가 변경한 테마를 지원하지 않으면 결국 번거로운 빌드 작업을 직접 진행해야 한다. 지킬이 강력한 도구인 이유는 깃허브 페이지와의 호환성이 뒷받침해주기 때문인데, 이 장점을 이용할 수 없게 되는 셈이다.

또 하나의 문제는 깃허브 페이지에서 사용할 수 있는 젬 기반의 테마 대부분이 페이지와 포스트를 위한 레이아웃만 갖고 있다는 점이다. 누군가는 최소한의 레이아웃만 제공해도 만족스럽게 사용하겠지만, 나는 미니마 테마처럼 테마에 포스트 목록을 위한 레이아웃이 기본으로 포함된 편이 훨씬 좋았다. 지킬 테마 제작자를 위한 권고안이 있으면 좋겠다. 테마 제작시 `post`, `page` 레이아웃과 함께 포스트의 목록을 보여주는 `posts` 레이아웃도 함께 제공하도록 권하고, 테마에 기본으로 포함해야 하는 플러그인 목록도 정리해서 가이드라인으로 제시하면 어떨까? 해볼 만한 프로젝트라고 생각한다.

## 마치며

이렇게 해서 새로운 지킬 블로그를 생성해서 젬 기반의 테마로 변경해보는 과정을 간단하게 살펴봤다. 현재 깃허브 페이지에서 사용 가능한 젬 기반의 테마는 미니마를 제외하고 모두 `0.1.0` 버전인 상태이다. 따라서 깃허브 페이지에서 지원하는 테마를 블로그에 적용하려면, 아직 정식 버전이 아닌 상태의 테마 중 하나를 선택해야만 하는 상황이다. 따라서 블로그를 오픈해서 이 중 하나의 테마를 커스터마이징 없이 사용하는 건 아직은 어렵다.

아주 방법이 없는 건 아니다.  만약 젬 기반의 테마 중 사용하고 싶은 테마가 있는데 깃허브 페이지에서 지원하지 않는 젬 기반의 테마일 경우, [Jekyll-remote-theme 플러그인](https://github.com/benbalter/jekyll-remote-theme)을 사용하길 추천한다. 이 플러그인을 사용하면 '깃허브 저장소에서 호스팅하는 테마'를 깃허브 페이지에 적용할 수 있다.
