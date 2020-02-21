---
layout: post
title: 지킬(Jekyll) 4.x에서 달라진 점
date: 2020-02-21
---

지킬(Jekyll) 4.0이 발표된 지 어느덧 여섯 달이 지났다. 관심을 갖고 있는 프로젝트인데 이제서야 무엇이 달라졌는지 살펴보는 게 너무 늦은 감이 있지만... 지금 하지 않으면 결국 더 늦을테니, 시작해 봅시다.

먼저 지킬과 번들러(Bundler)를 최신 버전으로 업그레이드 하기 위해 재설치했다. 

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

현재까지 알아본 바로는 `relative_url` 필터를 내장한 `link` 태그와 `post_url` 태그 외에는 당연히 바뀔 것이라 기대했던 부분들을 바꾼 정도의 변화가 아니었나 싶다. 이 외에도 지킬 사용에 관련한 수정 외에도 더 강력해진 `SASS` 컴파일 기능과, 속도 개선을 위한 캐시 기능도 적용됐다고 한다. 이와 관련한 내용은 앞으로 지킬 4.x를 직접 사용해가면서 포스트 내용을 더 추가하겠다.