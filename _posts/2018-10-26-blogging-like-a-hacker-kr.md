---
layout: post
title: 번역 - 해커처럼 블로깅하기
date: 2018-10-26
---

> 이 글은 [톰 프레스턴 베르너(Tom Preston-Werner)](http://tom.preston-werner.com)가 [지킬을 공개](https://jekyllrb.com/docs/history/#v0-1-0)한 후, 작성한 블로그 포스트, "[Blogging Like a Hacker](http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html)"를 원저작자의 허락을 얻어 번역한 글입니다.
>
> 톰 프레스턴 베르너는 약 10년 전인 2008년 11월 17일에 이 글을 포스팅했습니다. 현재 4.0 버전 릴리즈를 기다리고 있는 지킬의 코드와 사용법은 1.0 버전을 배포했던 이 포스트의 작성 당시와 비교했을 때, 많은 부분이 바뀌었습니다. 따라서 본문에는 사용법이 다르거나 더는 지원하지 않는 기능 및 코드가 포함되어 있습니다. 예를 들어, 현재 3.x 버전의 지킬은 [Textile을 지원하지 않으며](https://blog.github.com/2016-02-01-github-pages-now-faster-and-simpler-with-jekyll-3-0/), 사이트를 생성할 때 `jekyll build`라는 명령어를 사용합니다. 하지만 이 글은 지킬 튜토리얼이 아니기 때문에 굳이 코드를 수정할 필요는 없다고 판단했습니다. 지킬의 창시자가 지킬의 제작 동기와 핵심 컨셉을 소개하는 이 포스트는 오랜 시간이 지났음에도 불구하고 충분히 읽어볼 가치가 있습니다.

[Back in 2000, when I thought I was going to be a professional writer, I spent hours a day on LiveJournal doing writing practice with other aspiring poets and authors. Since then I’ve blogged at three different domains about web standards, print design, photography, Flash, illustration, information architecture, ColdFusion, package management, PHP, CSS, advertising, Ruby, Rails, and Erlang.]: #

제가 전업 작가가 되겠다고 생각했던 2000년을 돌이켜보면, 저는 매일 [라이브저널(LiveJournal)](https://www.livejournal.com/)에서 유망한 시인, 작가들과 함께 작문 연습을 하며 시간을 보냈습니다. 그 이후로 웹 표준, 편집 디자인, 사진, 플래시, 일러스트, 정보 설계, 콜드퓨전(ColdFusion), 패키지 관리, PHP, CSS, 광고, 루비(Ruby) 언어, 레일즈(Rails) 프레임워크, 얼랭(Erlang) 언어에 대해 세 가지 다른 주소로 블로그를 운영했습니다.

[I love writing. I get a kick out of sharing my thoughts with others. The act of transforming ideas into words is an amazingly efficient way to solidify and refine your thoughts about a given topic. But as much as I enjoy blogging, I seem to be stuck in a cycle of quitting and starting over. Before starting the current iteration, I resolved to do some introspection to determine the factors that were leading to this destructive pattern.]: #

저는 글쓰기를 좋아합니다. 저는 다른 이들과 제 생각을 공유하는 걸 즐깁니다. 아이디어를 문장으로 표현하는 것은 특정 주제에 대한 견해를 다듬어 명확하게 만드는 효과적인 방법입니다. 하지만 제가 즐거운 마음으로 블로깅(blogging)을 하면 할수록, 한 번 끝냈는데 또다시 시작하는, 반복적인 사이클에 갇힌 기분이었습니다. 이번 반복 작업에 착수하기 전에 저는 이 부정적인 패턴을 만드는 원인을 파악하기 위해 분석 작업을 했습니다.

[I already knew a lot about what I didn’t want. I was tired of complicated blogging engines like WordPress and Mephisto. I wanted to write great posts, not style a zillion template pages, moderate comments all day long, and constantly lag behind the latest software release. Something like Posterous looked attractive, but I wanted to style my blog, and it needed to be hosted at the domain of my choosing. For the same reason, other hosted sites (wordpress.com, blogger.com) were disqualified. There are a few people directly using GitHub as a blog (which is very cool), but that’s a bit too much of an impedance mismatch for my tastes.]: #

저는 제가 원치 않는 게 무엇인지 잘 알고 있었습니다. 저는 워드프레스나 메피스토(Mephisto) 같은 복잡한 블로그 엔진에 피로함을 느꼈습니다. 계속 최신 출시되는 소프트웨어 업데이트에 뒤처지지 않고 싶었고, 온종일 수많은 템플릿 페이지를 꾸미는 일이나, 코멘트를 관리하는 게 아니라, 멋진 포스트를 쓰고 싶었습니다. [포스터러스(Posterous)](http://www.posterous.com) 같은 서비스는 매력적으로 보이지만, 저는 블로그의 스타일을 직접 수정하고, 원하는 도메인을 연결하고 싶었습니다. 그래서 호스팅을 제공하는 다른 사이트들(wordpress.com, blogger.com)도 제외했습니다. (꽤 멋지게) 깃허브를 블로그로써 직접 사용하는 사람들도 있었습니다. 그러나 그 방식은 내 취향과는 너무 달랐습니다.

[On Sunday, October 19th, I sat down in my San Francisco apartment with a glass of apple cider and a clear mind. After a period of reflection, I had an idea. While I’m not specifically trained as an author of prose, I am trained as an author of code. What would happen if I approached blogging from a software development perspective? What would that look like?]: #

10월 19일 일요일, 저는 차분한 마음으로 사과 맛 탄산음료 한 컵을 들고 샌프란시스코의 제 아파트에 앉아 있었습니다. 숙고의 끝에, 아이디어가 떠올랐습니다. 저는 산문의 저자로서뿐만 아니라 코드의 작성자로서도 스스로 훈련해왔습니다. 제가 소프트웨어 개발자의 관점에서 블로깅을 본다면 어떤 일이 벌어질까요? 그건 어떤 형태를 띠게 될까요?

[First, all my writing would be stored in a Git repository. This would ensure that I could try out different ideas and explore a variety of posts all from the comfort of my preferred editor and the command line. I’d be able to publish a post via a simple deploy script or post-commit hook. Complexity would be kept to an absolute minimum, so a static site would be preferable to a dynamic site that required ongoing maintenance. My blog would need to be easily customizable; coming from a graphic design background means I’ll always be tweaking the site’s appearance and layout.]: #

먼저, 깃 저장소(Git repository)에 저의 모든 글을 저장할 겁니다. 이렇게 하면 제가 즐겨 쓰는 편집기와 커멘드라인을 이용해 편안하게 다양한 포스트를 탐색하고, 여러 아이디어를 시도할 수 있습니다. 간단한 배포 스크립트나 커밋 훅(post-commit hook)을 통해 포스팅할 수도 있습니다. 정적인 사이트는 복잡성이 매우 낮아서 지속적인 유지 관리가 필요한 동적 사이트보다 좋습니다. 제 블로그는 쉽게 커스터마이징 할 수 있었으면 합니다; 저는 그래픽 디자인 분야에서 활동했기 때문에 항상 사이트의 외관과 레이아웃을 수정할 것입니다(My blog would need to be easily customizable; coming from a graphic design background means I’ll always be tweaking the site’s appearance and layout).

[Over the last month I’ve brought these concepts to fruition and I’m pleased to announce Jekyll. Jekyll is a simple, blog aware, static site generator. It takes a template directory (representing the raw form of a website), runs it through Textile and Liquid converters, and spits out a complete, static website suitable for serving with Apache or your favorite web server. If you’re reading this on the website (http://tom.preston-werner.com), you’re seeing a Jekyll generated blog!]: #

지난 한 달 동안, 저는 이 구상의 결실을 보았으며, 기쁜 마음으로 지킬(Jekyll)을 발표합니다. 지킬은 간단하고, 블로그에 초점을 둔(blog aware), 정적 사이트 생성기입니다. 이는 (웹사이트의 원래 형태를 표현하는) 템플릿 디렉토리를 갖고 있습니다. 이 디렉토리를 텍스타일(Textile)과 리퀴드 변환기(Liquid Converters)로 실행하여, 아파치나 여러분이 선호하는 웹 서버로 서비스하기에 알맞은 완벽하고 정적인 웹사이트를 만듭니다. [이 글이 올라온 웹사이트](http://tom.preston-werner.com)를 보고 있다면, 여러분은 지킬로 생성한 블로그(Jekyll generated blog)를 보고 있는 것입니다(번역한 글을 올린 [이 블로그](https://paikwiki.github.io)도 지킬로 생성했습니다(역주))!

[To understand how this all works, open up my TPW repo in a new browser window. I’ll be referencing the code there.]: #

이 모든 작업 과정을 알고 싶다면, 브라우저 창을 열어 [TPW 저장소](https://github.com/mojombo/tpw)를 열어 보세요. 그곳에서 코드를 참조할 수 있도록 하겠습니다.

[Take a look at index.html. This file represents the homepage of the site. At the top of the file is a chunk of YAML that contains metadata about the file. This data tells Jekyll what layout to give the file, what the page’s title should be, etc. In this case, I specify that the “default” template should be used. You can find the layout files in the _layouts directory. If you open default.html you can see that the homepage is constructed by wrapping index.html with this layout.]: #

`index.html`을 살펴봅시다. 이 파일은 사이트의 메인페이지(homepage)를 나타냅니다. 파일의 가장 상단에 파일의 메타데이터를 담고 있는 YAML 파일 조각(현재는 프런트매터(frontmmatter)라고 부릅니다(역주))이 있습니다. 이 데이터는 지킬에게 어떤 레이아웃을 쓸 것이고, 페이지의 제목이 무엇인지 등을 알려줍니다. 지금의 파일은 "default" 템플릿을 사용하도록 정의했습니다. 여러분은 `_layouts` 디렉토리에서 레이아웃 파일을 볼 수 있습니다. `default.html`을 열어보면, 여러분은 이 레이아웃이 `index.html`을 감싸서 메인페이지를 구성했음을 알 수 있습니다.

[You’ll also notice Liquid templating code in these files. Liquid is a simple, extensible templating language that makes it easy to embed data in your templates. For my homepage I wanted to have a list of all my blog posts. Jekyll hands me a Hash containing various data about my site. A reverse chronological list of all my blog posts can be found in site.posts. Each post, in turn, contains various fields such as title and date.]: #

또한 여러분은 이 파일에서 리퀴드 템플릿 코드를 볼 수 있습니다. [리퀴드](https://shopify.github.io/liquid/)는 간단하고, 확장 가능한 템플릿 언어로, 손쉽게 여러분의 템플릿에 데이터를 삽입할 수 있게 해줍니다. 저는 메인페이지에 모든 포스트의 목록을 출력하고 싶었습니다. 지킬은 저는 사이트에 대한 다양한 데이터를 담은 해시(Hash)를 건네줍니다. `site.posts`에서 내 모든 블로그 포스트를 최신순으로 정리한 목록을 볼 수 있습니다. 각 포스트는 순서대로 `title`, `date`와 같은 다양한 필드값을 포함합니다.

[Jekyll gets the list of blog posts by parsing the files in the _posts directory. Each post’s filename contains the publishing date and slug (what shows up in the URL) that the final HTML file should have. Open up the file corresponding to this blog post: 2008-11-17-blogging-like-a-hacker.textile. GitHub renders textile files by default, so to better understand the file, click on the raw view to see the original file. Here I’ve specified the post layout. If you look at that file you’ll see an example of a nested layout. Layouts can contain other layouts allowing you a great deal of flexibility in how pages are assembled. In my case I use a nested layout in order to show related posts for each blog entry. The YAML also specifies the post’s title which is then embedded in the post’s body via Liquid.]: #

지킬은 `_posts` 디렉토리에 있는 파일을 파싱하여 블로그 포스트 목록을 만듭니다. 각 포스트의 파일명은 최종 생성된 HTML 파일에 포함될 (URL상에 나타날) 발행일과 슬러그를 포함합니다. 지금 읽고 있는 포스트에 대응하는 `2008-11-17-blogging-like-a-hacker.textile` 파일을 열어보세요.

[Posts are handled in a special way by Jekyll. The date you specify in the filename is used to construct the URL in the generated site. This post, for instance, ends up at http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html.]: #

포스트는 지킬의 특수한 방식에 의해 조작됩니다. 여러분이 파일명에 쓴 날짜는 최종 생성된(generated) 사이트에서 URL을 구성하는 데 쓰입니다. 예를 들어, 이 포스트의 URL은 `http://tom.preston-werner.com/2008/11/17/blogging-like-a-hacker.html`입니다.

[Files that do not reside in directories prefixed with an underscore are mirrored into a corresponding directory structure in the generated site. If a file does not have a YAML preface, it is not run through the Liquid interpreter. Binary files are copied over unmodified.]: #

밑줄(underscore)을 앞에 붙인 디렉토리 외부의 파일들은 해당 디렉토리 구조대로 최종 생성된 사이트에 복제됩니다. 파일에 YAML 서문(프런트매터)가 없다면, 리퀴드 인터프리터를 통해 실행되지 않습니다. 바이너리 파일은 수정하지 않고 그대로 복제합니다.

[In order to convert your raw site into the finished version, you simply run:]: #

최종 버전에서 여러분의 웹사이트를 변환(convert)하기 위해 아래 명령을 실행합니다.

```s
$ jekyll /path/to/raw/site
/path/to/place/generated/site
```

[Jekyll is still a very young project. I’ve only developed the exact functionality that I’ve needed. As time goes on I’d like to see the project mature and support additional features. If you end up using Jekyll for your own blog, drop me a line and let me know what you’d like to see in future versions. Better yet, fork the project over at GitHub and hack in the features yourself!]: #

지킬은 아직 초창기 단계의 프로젝트입니다. 저는 제가 필요로 하는 특정 기능만 개발했습니다. 앞으로 프로젝트가 성장하면서, 추가적인 기능이 지원되면 좋겠습니다. 여러분이 지킬을 이용해 블로그를 제작해본 후, 앞으로의 버전에서 기대하는 바를 저에게 알려주세요. 깃허브에서 [프로젝트](https://github.com/jekyll/jekyll)를 포크하여, 여러분 스스로 기능을 뜯어고친다면(hack) 더 좋겠습니다.

[I’ve been living with Jekyll for just over a month now. I love it. Driving the development of Jekyll based on the needs of my blog has been very rewarding. I can edit my posts in TextMate, giving me automatic and competent spell checking. I have immediate and first class access to the CSS and page templates. Everything is backed up on GitHub. I feel a lightness now when I’m writing a post. The system is simple enough that I can keep the entire conversion process in my head. The distance from my brain to my blog has shrunk, and, in the end, I think that will make me a better author.]: #

재가 지킬과 함께 한 시간은 한 달에 불과합니다. 매우 만족합니다. 제 블로그에 사용하기 위해서 지킬을 개발한 과정은 매우 의미 있는 시간이었습니다. 저는 자동화를 지원하는 뛰어난 맞춤법 검사 기능을 가진 [텍스트메이트(TextMate)](https://macromates.com/)로 포스트를 작성할 수 있습니다. 또한 CSS와 페이지 템플릿에 바로 접근할 수 있습니다. 이 모든 것을 깃허브에 백업합니다. 이제 저는 홀가분한 기분으로 포스트를 작성합니다. 시스템은 제 머릿속에서 모든 변환 과정을 기억할 수 있을 만큼 간단합니다. 제 뇌에서 블로그까지의 거리는 매우 좁혀졌으며, 이로써 저는 더 나은 저자가 될 수 있을 것입니다.
