---
layout: post
title: 지킬(Jekyll) 4.x에서 달라진 점
date: 2020-02-21
tags: [jekyll]
---

지킬(Jekyll) 4.0이 발표된 지 어느덧 여섯 달이 지났다. 관심을 갖고 있는 프로젝트인데 이제서야 무엇이 달라졌는지 살펴보는 게 너무 늦은 감이 있지만... 지금 하지 않으면 결국 더 늦을테니, 시작해 봅시다.


## 지킬과 번들러(Bundler) 업그레이드

먼저 지킬과 번들러를 최신 버전으로 업그레이드 하기 위해 재설치했다.

````sh
$ gem install bundler jekyll
Fetching bundler-2.1.4.gem
Successfully installed bundler-2.1.4
.
.
.
Parsing documentation for jekyll-4.0.0
Installing ri documentation for jekyll-4.0.0
Done installing documentation for sassc, jekyll-sass-converter, jekyll after 4 seconds
4 gems installed
````

지킬과 번들러에, `sassc-2.2.1`와 `jekyll-sass-converter-2.1.0`까지 총 4개의 젬(Gem)을 업그레이드했다. 이 과정에서 Jekyll 4.0 업그레이드에 대한 내용이 터미널에 출력됐다.

````sh
-----------------------------------------------------------------
Jekyll 4.0 comes with some major changes, notably:

  * Our `link` tag now comes with the `relative_url` filter
    incorporated into it.
    You should no longer prepend `{{"{{ site.baseurl " }}}}` to
    `{{"{% link foo.md %"}}}`
    For further details:
    https://github.com/jekyll/jekyll/pull/6727

  * Our `post_url` tag now comes with the `relative_url` filter
    incorporated into it.
    You shouldn't prepend `{{"{{ site.baseurl " }}}}` to
    `{{"{% post_url 2019-03-27-hello %"}}}`
    For further details:
    https://github.com/jekyll/jekyll/pull/7589

  * Support for deprecated configuration options has been
    removed. We will no longer output a warning and gracefully
    assign their values to the newer counterparts internally.
-----------------------------------------------------------------
Successfully installed jekyll-4.0.0
````

친절하다. 하나씩 번역해서 읽어보자.

## `link` 태그와 `post_url` 태그

> Our `link` tag now comes with the `relative_url` filter incorporated into it.
>
> `link` 태그는 `relative_url` 필터를 자체 내장합니다.

바로 아래의 문장도 비슷한 의미인 것 같으니 일단 번역해보면,

> Our `post_url` tag now comes with the `relative_url` filter incorporated into it.
>
> `post_url` 태그는 `relative_url` 필터를 자체 내장합니다.

결국 `link` 태그와 `post_url` 태그가 `relative_url`이라는 필터를 내장하도록 변경됐다는 게 변경사항의 주요 내용이었다.

3.x 버전에서는 지킬을 루트 디렉토리에 설치하지 않고 `/blog` 디렉토리에 설치했을 때, 생성된 사이트가 루트 디렉토리를 기본 디렉토리인 `/`가 아니라 `/blog`로 인식할 수 있도록 링크에 `prepend`를 설정해야했다.

````html
<link rel="stylesheet"
  href="{{"{{ 'css/style.css' | prepend: site.baseurl " }}}}" />
````

이렇게 하면 `/css/style.css`가 아니라, `/blog/css/style.css`를 불러오도록 경로를 설정해준다. 이 작업을 좀더 간단하게 할 수 있도록 해주는 게 `relative_url`이었다.

````html
<link rel="stylesheet"
  href="{{"{{ 'css/style.css' | relative_url " }}}}" />
````

이렇게 하면, 위와 동일한 경로에서 스타일시트를 불러온다. 물론 둘다 사전에 `config.yml`에 `baseurl` 값이 설정해야만 한다. 하여튼, 이 방식은 꽤나 번거로웠다. 최초에 테마를 만들 때는 이를 고려하지 않고 만들었다가, 서브디렉토리에 지킬을 설치한 후, 테마를 적용하고는 뭔가 잘못 동작한다는 걸 알아차릴 수 있었다. 결국 서브디렉토리에 설치하는 경우에 대비하기 위해서 사전에 해당 필터를 모두 설정해야만 했다.

이번 업그레이트를 통해 지킬 4.x에서는 이 불편함을 없앴다. `link` 태그와 `post_url` 태그를 사용하면, 굳이 필터를 적용하지 않아도 알아서 `baseurl`이 적용된 상대 경로를 지정해준다. 편리해졌군. 마음에 든다.

마지막 메세지를 살펴 볼까.

> Support for deprecated configuration options has been removed. We will no longer output a warning and gracefully assign their values to the newer counterparts internally.
>
> 사용하지 않는 설정 옵션에 대한 지원이 종료됩니다. 더이상 이에 대해 경고를 출력하지 않고, 해당 값을 내부적으로 새로운 옵션(newer counterparts)에 조용히(gracefully) 할당합니다.

음.. 그동안 3.x의 `config.yml`에 지원 종료 직전의 옵션을 사용하면 경고가 나왔는데, 이제는 경고 대신 말없이 대체제를 선택해준다는 의미인 듯 하다. 더이상 지원하지 않는 옵션이라 함은 [4.0 릴리즈 포스트](https://jekyllrb.com/news/2019/08/20/jekyll-4-0-0-released/)에서 언급한 `Pygments`, `RedCarpet`, `RDiscount` 등등이 아닐까 싶다. 다양한 문법 강조 도구나 파서를 지원하기 보다는 선택과 집중 노선을 타기로 했나 보다.

현재까지 알아본 바로는 `relative_url` 필터를 내장한 `link` 태그와 `post_url` 태그 외에는 당연히 바뀔 것이라 기대했던 부분들을 바꾼 정도의 변화가 아니었나 싶다. 지킬 사용에 관련한 수정사항 외에도 더 강력해진 `SASS` 컴파일 기능과, 속도 개선을 위한 캐시 기능도 적용됐다고 한다.

## 캐시 기능

어제 이 포스트를 업로드하고 난 후, 이 블로그를 `3.8.3` 버전에서 `~> 4.0`으로 업그레이드했다. 업그레이드를 위해서는 `Gemfile`에 `gme "jekyll", "~> 4.0"` 한 줄을 추가해줘야 했다. 그리고 언젠가 이 블로그 레이아웃이 쓸만해지면 테마로 뽑아내기 위해 작성해둔 `jekyll-theme-paikwiki.gemspec`의 런타임 의존성을 `3.8.3`에서 `~> 4.0`으로 변경해줬다. 업그레이드를 해도 특별히 문제가 될만한 플러그인이 없고, 내가 작성한 레이아웃에서도 크게 깨질만한 요소가 없는 것 같아 과감히 `bundle install`을 실행했다.

특별한 오류 없이 깔끔하게 업그레이드를 마쳤다. `bundle exec jekyll serve`를 실행해서 동작에 이상이 없는 것을 확인한 후 블로그의 변경사항을 깃헙에 적용하려 `git status`를 실행한 순간, 새로운 폴더가 눈에 띄었다.

````sh
$ git status
On branch jekyll4
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   Gemfile
	modified:   jekyll-theme-paikwiki.gemspec

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.jekyll-cache/
	Gemfile.lock.old
````

`.jekyll-cache/`는 없던 폴더인데 갑자기 생겼다. 내부를 들여다봤다.

````sh
$ pwd
~/codes/paikwiki.github.io/.jekyll-cache/Jekyll/Cache
$ ls -al
total 0
drwxr-xr-x   4 paikwiki  staff   128 Feb 22 15:46 ./
drwxr-xr-x   3 paikwiki  staff    96 Feb 22 15:46 ../
drwxr-xr-x   3 paikwiki  staff    96 Feb 22 15:45 Jekyll--Cache/
drwxr-xr-x  59 paikwiki  staff  1888 Feb 22 15:46 Jekyll--Converters--Markdown/
````

오오.. 캐시파일이 들어있다. `Jekyll--Cache`는 열어보지 않았지만 `Jekyll--Converters--Markdown/`를 열어보니 파싱된 HTML 문서들이 들어있었다. 오... 이제 변경된 문서만 생성(generating)한다더니 정말인가 보다. 이렇게 되면 로컬에서 작업할 때 변경사항이 있을 때마다 새로 생성하는데 들던 시간이 현저히 줄어들겠다.

포스팅을 위해 속도 차이를 비교해보고 싶으나... 그냥 직접 사용하면서 체감해보기로 했다.

## 마무리

최근 리액트(react)의 흥행과 함께, 개츠비(gatsby)가 인기있는 정적 사이트 제너레이터가 돼가고 있다. 잼 스택(JAM Stack)의 유행도 그렇고, 워낙 자바스크립트가 대세다 보니, 지킬의 인기가 점점 하락하고 있는 듯 하다. 구글 트랜즈를 봐도 개츠비의 꾸준한 상승세와 달리 지킬은 꾸준한 하향세다. 루비의 하향세도 한몫하고 있겠지.

오랜 역사를 가진, 훌륭한 도구들이 점점 사람들의 관심으로부터 멀어지는 걸 보면 괜히 아쉽다. 트랜드의 변화는 기술의 발전으로부터 비롯된다는 건 자명하다. 하지만 누구나 한번쯤은 직면할만한, 오래된 문제를 해결하는 데 있어 반드시 트랜디한 도구가 적합하지만은 않다. 상황에 적합한 도구와 새로운 기술을 반영한 도구, 이 두 가지를 두고 고민할 때마다 떠오르는 게 지킬과 개츠비다. 개츠비가 그래프QL(GraphQL)을 이용해 사이트 생성 과정에서 여러 리소스를 손쉽게 가져오는 걸 보며 감탄하면서도, 막상 사이트를 만들다보면 간편한 방식으로 사이트를 만들어내는 지킬을 쓰고 싶어진다.

괜히 마무리가 길어지니까 여기서 끊어야겠다. 하고 싶은 말은: 지킬은 블로그를 운영하는데 최적화된 도구이며, `4.0` 버전을 통해 더 나은 기능을 제공하기 시작했다는 것이다.
