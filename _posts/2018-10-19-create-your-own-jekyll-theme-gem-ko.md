---
layout: post
title: 번역 - 나만의 지킬 테마 만들기
date: 2018-10-19
tags: [translation, ryan-brown, jekyll, jekyll-theme]
---

> 이 글은 [Ryan Brown](https://ryandevelops.com/)의 블로그 포스트, "[Create your own Jekyll theme gem](https://ryandevelops.com/collection/2018-10-07-create-your-own-jekyll-theme-gem)"을 원저자의 허락을 얻어 번역한 글입니다. 이 글은 지킬 테마를 만들어 배포하는 방법에 대해 쉽게 소개하고 있는 데다가, 직접 테마 젬을 만들어 보는 과정을 통해 여러 유익한 경험을 얻을 수 있다는 원문 작성자의 의견에 공감해 번역했습니다. 기초 튜토리얼인 만큼 원문 작성자의 의도를 해치지 않는 범위 내에서 읽기 쉽게 문장을 다듬었습니다. 원문에서는 "여러분 자신의 지킬 테마(your own Jekyll theme)"라고 표현하지만 번역글에서는 "여러분의 테마" 또는 "나만의 테마"로 문맥에 따라 선택적으로 번역했습니다.

![Dr. Jekyll reading in the laboratory](/assets/images/2018/dr-jekyll-reading-in-the-laboratory.jpg)

# 왜 나만의 테마 젬을 만들어야 할까요?

나만의 지킬 테마 젬(Jekyll theme gem)을 만든다는 건 여러 가지로 멋집니다.

- 지킬은 다른 사람들에게서 배울 수 있는 오픈 소스 플랫폼이며, 여러분의 작업이 다음 사람들에게 전달되어 그들만의 멋진 무언가를 만들도록 영감을 줄 수 있습니다.
- 진행 과정을 통해, 젬을 퍼블리싱하는 방법 등 많은 것을 배울 수 있습니다.
- 여러분의 테마를 원하는 대로 고치고, 만들 수 있습니다.
- 이 모든 과정이 여러분의 코드를 선보일 수 있는 좋은 방법이라는 것은 두말할 나위가 없습니다.

## 설계하기

여러분의 지킬 테마 젬을 만들기로 했으니 먼저 고려해야 할 사항을 떠올려 봅시다: 어떤 걸 해보고 싶은가요? 반드시 당장 결정할 필요는 없지만 완성하고 싶은 게 있다면 도움이 됩니다. 다른 지킬 테마를 많이 둘러보고 당신이 좋아하는 것과 그렇지 않은 것을 찾아보세요. 어쩌면 야생에서 만날 수 없는 새로운 아이디어를 얻을지도 모릅니다. 예를 들어, 저는 특정 태그 그룹에 대한 페이지네이션 기능이 없다는 점이 마음에 들지 않았고, 이 기능에 대한 예제도 그리 많지 않아서 직접 만들었습니다. 테마를 찾아볼 수 있는 좋은 사이트는 [awesome-jekyll-themes](https://github.com/planetjekyll/awesome-jekyll-themes) 깃허브 페이지와 [Jekyll Themes](http://jekyllthemes.org/)가 있습니다.

몇 가지 젬 기반의(gem-based) 테마를 다운로드해보면, 셋업과 설정이 얼마나 쉬운지 알 수 있습니다. 새로운 테마를 빠르게 시작하고 실행할 수 있다는 것은 중요한 사항입니다. 제가 만든 [콜라이더(jekyll-theme-collider) 테마](https://github.com/ryancolorcafe/jekyll-theme-collider)는 정말 멋지지만, 이를 실행하기 위해서는 몇 가지 단계가 필요합니다.

테마의 많은 부분이 컨벤션과 다른 폴더 구조를 필요로 하는 [jekyll-paginate-v2](https://github.com/sverrirs/jekyll-paginate-v2) 플러그인을 사용하고 있기 때문입니다. 저도 여기에 커스터마이징과 관련해 기여했습니다. 제가 사용한 페이지네이션 플러그인은 제 테마를 깃허브 페이지(GitHub Pages)에서 동작하지 않게 만들었습니다. 따라서 지킬의 컨벤션으로부터 멀어질수록 설정이   복잡해질 수 있음을 유념하세요. 대부분의 젬 기반의 테마에는 젬 안에 `assets`, `_layouts`, `_includes`, 그리고 `_sass` 디렉토리만을 포함합니다. 여러분이 다른 커스텀 파일이나 폴더를 추가한다면 테마를 설정하기가 어려워집니다. 아직 시작하지 않았다면 시작하기 전에 [테마에 대한 지킬 문서](https://jekyllrb.com/docs/themes/)를 잘 읽어 보세요.

이제 염두에 두어야 할 사항을 모두 살펴봤으니, 여러분의 테마를 만드는 핵심적인 방법을 살펴봅시다.

![실험실에서 담배를 피우는 지킬 박사](/assets/images/2018/dr-jekyll-smoking-in-the-laboratory.jpg)
<sub>_PS. 실험실에서 담배를 피우면 안 되겠죠..._</sub>

## 젬 기반의 테마 만들기

새로운 젬 기반의 지킬 테마 제작을 위한 기본 뼈대(scaffold)를 생성하려면, 아래의 명령어를 실행하세요.

&nbsp;&nbsp;&nbsp;&nbsp;`jekyll new-theme jekyll-theme-awesome`

명령을 실행하면 테마의 기반이 될 많은 파일과 폴더가 생성됩니다. 생성된 `jekyll-theme-awesome.gemspec` 파일은 여러분의 젬을 배포하는 데 매우 중요하므로, 필요한 모든 정보를 채워야 합니다. 최소한 `bundle exec jekyll serve --watch` 명령어를 성공적으로 실행하려면 `spec.summary`와 `spec.homepage`의 값은 꼭 수정해야 합니다.

`gemspec` 파일은 작성자 이름과 버전 정보, 젬이 의존하는 라이브러리(플러그인 등)처럼 여러분의 젬을 위한 중요한 모든 정보가 저장되는 곳입니다. `spec.files` 라인은 젬에 어떤 파일이 포함되어야 하는지 말해줍니다. 이 부분을 편집할 수는 있지만, 이 편집은 분명 지킬의 컨벤션에 위배되는 일입니다. 지킬의 컨벤션 생태계는 지킬을 사용하기 쉽게 만들기 때문에, 여러분이 이 부분을 수정하겠다면 이 사실을 잘 알고 있어야 합니다. 이 라인의 `assets`과 `_layouts`, `_includes`, `_sass` 폴더와 `LICENSE.txt`, `README.md` 파일은 여러분의 젬 안에 모두 포함됩니다.

여러분의 테마가 작동하는 데 플러그인이 필요하다면, 이 파일(gemspec)에 다음과 같이 각 플러그인을 추가해야 합니다.

&nbsp;&nbsp;&nbsp;&nbsp;`spec.add_runtime_dependency "jekyll-paginate-v2", "~> 1.7"`

## 파일 구조 살펴보기

아래는 명령어에 의해 생성된 다른 파일과 폴더입니다:

- `_includes`는 테마 전체에서 사용하길 원하는 재사용 가능한 코드 조각를 저장하는 폴더입니다.
- `_layouts`은 기본 포스트 레이아웃과 같은 메인 템플릿 파일들을 보관하기 위한 폴더입니다.
- `assets` 폴더는 여러분의 젬에 포함시키고 싶은 이미지, 그래픽 등을 담는 폴더입니다. Sass 파일도 이곳에서 임포트(import)합니다. 예를 들어,이 폴더 안에는 `main.scss`를 담은 `css`폴더가 있습니다. 이 파일에 아래처럼 작성해보세요:

````scss
---
---
@import "jekyll-theme-awesome";
````

- `_sass` 폴더에는 부분적인 스타일 코드가 들어 있습니다. 위와 같이 `assets` 폴더에 CSS를 설정했으면 이 폴더(`_sass`)에 `jekyll-theme-awesome.scss` 파일을 만들어, `jekyll-theme-awesome.scss`에 여러분이 원하는 다른 Sass 부분 코드를 임포트(import)합니다. 지킬이 Sass 파일을 어디서 가져와야 하는지 알 수 있도록 여러분의 `config.yml`에 아래와 같이 적어줍니다.

````yaml
sass:
    sass_dir: _sass
````

- `Gemfile`은 `.gemspec` 파일을 가리키며, 번들러(Bundler)가 여러분의 젬들을 관리하는 파일입니다.
- `README.md`는 젬에 대한 설치와 설정 방법을 포함한 테마를 위한 문서 파일입니다.
- `LICENSE.txt`에는 여러분의 테마가 어떤 라이선스를 따르는지에 대한 선언이 들어 있습니다. 기본적으로 [MIT 라이선스](https://opensource.org/licenses/MIT)가 설정됩니다.

## 테마 시작하기

다른 작업 없이 `.gemspec` 파일의 `spec.summary`와 `spec.homepage` 설정을 수정하기만 해도 `bundle exec jekyll serve --watch` 명령어를 입력하고 브라우저에서 `localhost:4000`으로 접속해볼 순 있으나, 그렇게 하면 여러분의 사이트 디렉토리 목록만 보일 것입니다. 좀 더 흥미로운 무언가를 보기 위해 루트 디렉토리에 `index.html` 파일을 추가해 아래의 내용처럼 입력해보세요:

````ruby
---
title: Home
layout: default
---
# Yello?
````

여러분은 이제부터 거침없이 여러분의 테마를 만들기 시작할 수 있습니다. `_layouts/post.html` 템플릿에 약간의 스타일을 적용하고, 많은 다양한 콘텐츠로 샘플 포스트를 만들어 여러분의 테마가 다양한 활용 형태에 쓰일 수 있도록 해보세요.[페이지네이션](https://jekyllrb.com/docs/pagination/)과 [태그](https://jekyllrb.com/docs/plugins/tags/)를 추가하고, 소개(about) 페이지를 만들어 보세요. 스타일을 많이 작성해보세요. 한 번 달려봅시다.

## 설정 파일 만들기

여러분이 반드시 해야할 또 하나의 작업은 `config.yml`의 예제 파일 생성입니다. 예제 파일은 여러분의 젬을 다운받은 사람들이 테마를 빠르고 쉽게 설정할 수 있도록 해줍니다. 아래는 제가 만든 젬을 위해 작성한 `config.yml`의 일부입니다:

````yaml
title: Rando Dev
email: example@example.com
description: >
  This is the Collider Jekyll Theme.
baseurl: ""
url: "https://jekyll-theme-collider.netlify.com"
hosted_url: ""
github_username: ""
linked_in_profile: ""
full_name: Rando Dev
user_description: Software Engineer
disqus:
  shortname: jekyll-theme-collider-netlify-com
````

여러분의 테마에서 이름을 출력하는 모든 부분을 추적하고 편집하는 대신에, 간단하게 `full_name` 라인을 수정할 수 있습니다. 이렇게 하면 여러분의 레이아웃에서 아래처럼 사용합니다:

````html
  <p>{{site.full_name}}</p>
````

`config.yml`의 어떤 변수든 `{% raw %}{{site.변수명}}{% endraw %}`을 이용해 사이트 전체에서 사용할 수 있습니다.

## 젬 퍼블리싱

여러분의 테마로 하려던 멋진 작업들을 모두 마치고 퍼블리싱할 준비가 됐다고 생각하면, [RubyGems.org](https://rubygems.org)에서 계정을 등록하세요.

계정을 등록했다면, 아래 명령으로 젬을 빌드할 수 있습니다.

&nbsp;&nbsp;&nbsp;&nbsp;`gem build jekyll-theme-awesome.gemspec`

명령을 실행하면 루트 디렉토리에 다음과 같은 파일이 생성됩니다.

&nbsp;&nbsp;&nbsp;&nbsp;`jekyll-theme-awesome-0.1.0.gem`.

여러분의 테마를 업로드하고 퍼블리싱하려면 아래의 명령어를 입력하세요:

&nbsp;&nbsp;&nbsp;&nbsp;`gem push my-theme-0.1.0.gem`

RubyGems.org 자격 증명을 사용해서 로그인하라는 메시지가 나타나고, 메시지에 따라 진행하면 젬이 퍼블리싱될 것입니다!

잘 하셨습니다. 여러분 스스로를 칭찬해주세요. 🎉

## 테스트와 문서화

이제 여러분의 젬을 테스트해볼 시간입니다. 새 지킬 프로젝트에 여러분의 테마를 다운로드해보세요. 세팅과 설정이 간편한가요? 막히는 곳이 있진 않나요? 테마를 구성하고 설치하는 각 단계를 수행하면서 메모를 작성하세요. 이 작업은 나의 다음 주제(잔소리입니다..)인 문서화로 이어집니다.

훌륭한 커뮤니케이션에 가치를 두고 있는 영어 전공자로서, 나는 이 부분을 중요하게 여깁니다. 사용법을 알려주지 않은 채 잠재적인 사용자를 외면한다면 끝내주는 테마를 만드는 모든 과정은 왜 필요할까요? 지킬 또는 코딩에 대해 거의 모르는 누군가의 관점에서 보세요(그렇게까지 상상할 필요가 없을지 모르지만, 아이디어를 얻을 수 있으니까요). 어떤 것도 당연하게 여겨서는 안됩니다. 사용자가 테마를 세팅하는동안 매번 가능한 문제에 빠질 수 있으며, 여러분 테마의 꽤나 괴팍한 기능들을 마법처럼 찾아내는 방법을 알지 못한다고 가정해야 합니다.

이제 여러분의 테마를 테스트하고 훌륭한 문서를 작성했습니다. 박수! 👏. 하지만, 여러분은 이 테마를 좀더 개발하고, 기능을 계속 추가하고 싶어질 것입니다.

## 새 버전의 젬 퍼블리싱

다음 버전을 만들어, 젬에 적용하고 싶다면 다음 단계를 따르세요:

- `.gemspec` 파일에 `spec.version` 설정을 변경하고 싶은 버전 번호로 변경합니다. 여러분의 버전 번호를 어떻게 해야할 지 알고 싶다면 RubyGems.org에서 [유의적 버전](https://guides.rubygems.org/patterns/#semantic-versioning) 문서를 살펴보세요.
- 그리고 나서 `gem build jekyll-theme-awesome.gemspec` 명령을 실행하여 다음 버전의 젬을 다시 빌드합니다.
- 새로운 젬 버전을 업로드하기 위해, 새로운 버전 번호와 함께 앞서 실행했던 명령을 다시 실행합니다:

&nbsp;&nbsp;&nbsp;&nbsp;`gem push my-theme-0.1.1.gem`

이제 모두 마쳤습니다.

그리고, 이 버전은 여러분이 퍼블리싱한 여러 젬 버전 중 첫번째 버전이 될 것이므로 매 릴리즈마다 무엇이 바뀌었는지 강조해주는 `CHANGELOG.md` 파일 작성을 권장합니다. 변경 로그에 대한 자세한 정보는 [Keepachangelog.com](https://keepachangelog.com)을 살펴보세요.

## 와우!🍾

짜잔! 여러분은 지금 여러분의 스스로 지킬 젬 테마를 만들었습니다. 오픈 소스에 기여하고, 여러분이 만든 코드 묶음을 갖게 되고, 이로 인해 누군가가 도움을 받을 수도 있다는 건 멋진 기분을 느끼게 해줍니다. 이 글에 대한 어떤 질문이나, 젬 테마를 만드는 방법에 대해 궁금한 점이 있다면 [저에게 연락](https://ryandevelops.com/contact)하거나 코멘트를 남겨주세요. 기꺼이 도와드릴게요!
