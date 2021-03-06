---
layout: post
title: 번역 - 마크다운에 빠져봅시다
date: 2020-03-31
tags: [translation, markdown, john-gruber]
---

> 이 글은 [존 그루버(John Gruber)](https://daringfireball.net/)가 마크다운의 철학과 제작 동기를 밝힌 블로그 포스트, "[Dive Into Markdown](https://daringfireball.net/2004/03/dive_into_markdown)"을 원저자의 허락을 얻어 번역한 글입니다.
>
> 그는 HTML 코드 조각(snippets)을 이용해 블로그 포스트를 작성하던 당시의 상황에 대해 문제를 제기합니다. 그 문제의 해결책으로써 글을 작성하는데 있어 집중을 방해하는 태그와 같은 요소를 제거하고, 글을 작성하는 도중에도 내용을 쉽게 읽을 수 있도록 해주는 도구인 마크다운을 제안하고 소개합니다.
>
> "마크업(Mark**up**)" 언어와 대비되는 "마크다운(Mark**down**)"이라는 재치있는 이름의 이 도구를 통해, 존 그루버는 마크업 언어가 갖고 있는 ― 하지만 누구나 아무렇지 않게 여기고 있는 ― 불편함을 해결하고자 했습니다.
> 이 과정에서 그가 강조하는 두 가지 포인트는 일상 속에서 미처 깨닫지 못 하고 지나쳐버릴 수 있는, 새로운 도구를 만들어 낼 기회를 포착해내는, *통찰력*에 대한 단서이기도 합니다.
>
> 이 포스트에 앞서, 존 그루버는 "[마크다운을 소개합니다(Introducing Markdown)](https://daringfireball.net/2004/03/introducing_markdown)"라는 짧막한 포스트를 통해 마크다운의 출시를 알립니다. ["마크다운을 소개합니다"의 번역](/2020/03/introducing-markdown-ko)도 함께 포스팅하였으니 이 글과 함께 보시길 권합니다.

<span style="color: #aaa">2004년 3월 19일, 금요일</span>

> "진실은 때때로 그에 대한 사고가 아니라 그에 대한 감정이다." - 스탠리 큐브릭

## 첫번째 포인트

질문을 하나 해보겠습니다. 논쟁에 기초해 마음을 바꾼 마지막 시점이 언제입니까? 여러분이 그에 대해 생각을 적게 한 탓이 아니라, 문제의 논점에 대해 깊이 생각해보기 전에 이미 당신의 입장은 확고했을 것입니다(역주: 이미 여러분이 확고한 고정관념을 갖고 있어서 문제의 논점에 대해 깊이 생각해봐도 입장이 쉽게 바뀌지 않았을 것입니다).

질문을 바꿔보면  여러분이 주장하는 바가 완전히 틀렸음을 깨달았던 마지막 시점은 언제입니까?

만약 여러분의 대답이 "전혀 없다", 혹은 "매우 오래전에"라면, 항상 옳은 주장을 했기 때문일까요?

제 사례를 하나 이야기해보겠습니다.

지난 1월(역주: 2004년 1월), ([RSS](https://blogs.law.harvard.edu/tech/rss)와 [Atom](http://www.atomenabled.org/)과 같은 형식의) XML 피드(XML syndicated feeds)를 파싱하는 소프트웨어에 포스텔의 법칙([Postel's Law](http://www.ibiblio.org/pub/docs/rfc/rfc793.txt))의 적용하는 것에 대한 논의가 있었습니다. 포스텔의 법칙을 요약하면 다음과 같습니다: "여러분이 하는 일은 엄격하게, 다른 이로부터 받아들이는 것은 관대하게(역주: TCP 전송시, 발신 기능은 정확한 데이터를 보내도록 구현하고, 수신 기능은 최악의 상황을 염두에 두고 구현하라)". 하지만 [XML 사양](https://www.w3.org/TR/2004/REC-xml-20040204/#dt-fatal)에는 이렇게 명시되어 있습니다: "치명적인 오류가 감지되면, 프로세서는 처리를 계속해서는 안 된다(MUST NOT)(예를 들면, 오류를 감지했을 경우 문자 데이터와 문서의 논리 구조에 대한 정보를 정상적인 방식으로 애플리케이션에 계속 전달해서는 안된다).

그럼 XML 피드를 파싱하는 소프트웨어는 어떻게 해야할까요? 포스텔의 법칙을 따라, 피드의 에러에 대해 관대해야할까요, 아니면 XML 사양에 따라 치명적인 오류가 발생한 시점에서 피드에 대한 처리를 중지해야할까요?

[브렌트 시몬스](http://inessential.com/?comments=1&postid=2770)(Brent Simmons, 최고의 Mac OS 뉴스리더인 넷뉴스와이어(NetNewsWire)의 개발자)와 [닉 브래드버리](http://nick.typepad.com/blog/2004/01/feeddemon_and_w_1.html)(Nick Bradbury, 최고의 Windows 뉴스리더인 피드데몬(FeedDemon)의 개발자)는 Atom XML 피드를 파싱할 때 소프트웨어가 엄격하게 동작해야한다고 결정했습니다. 다른 많은 똑똑한 사람들도 그들과 같은 생각이었습니다.

"클라이언트 소프트웨어가 엄격해야 한다"는 주장은 다음과 같이 요약할 수 있습니다.

1. 유효하고, 바른 형식의 XML이 유효하지 않은 XML보다 낫다.
1. 유효하고, 바른 형식의 XML을 생성하는 소프트웨어를 만드는 건 그리 어렵지 않다([팀 브레이(Tim Bray)의 말](https://www.tbray.org/ongoing/When/200x/2004/01/11/PostelPilgrim)을 빌리자면, "형식을 잘 갖춘 XML 피드를 만들 수 없는 사람은 무능한 바보다").
1. XML 피드를 *소비하는* 최고의 클라이언트 애플리케이션이, 유효하고 바른 형식의 XML을 강제하는(required) 건, 피드를 생성하는 애플리케이션이 잘못된 XML을 생성하지 않도록 압력을 가하는 셈이다.

저는 이 세 가지 사항에 모두 동의하기에, "클라이언트 소프트웨어는 엄격하게 파싱해야한다"고 주장하는 그룹에 확고히 머물렀습니다.

그 후, 저는 [마크 필그림(Mark Pilgrim)의 "사고 실험(Thought Experiment)"](https://web.archive.org/web/20060420051806/http://diveintomark.org/archives/2004/01/14/thought_experiment)을 읽었습니다. 필그림은 피드를 파싱할 때 관대한 기준을 적용하자는 그룹의 지지자일 뿐만아니라, 그의 주장에 부합하는 [유니버설 피드 파서(Universal Feed Parser)](https://pypi.python.org/pypi/feedparser)라는 매우 잘 알려진 오픈소스 프로그램의 작성자입니다.

제가 봤을 때, 필그림의 핵심 요점은 다음과 같습니다: 여러분이 XML 피드를 소비하는 프로그램을 만들고, 그 파서가 어느 정도 관대하게 동작하지 않는다면, 여러분의 사용자는 잘못된 피드를 맞닥들였을 때 어려움을 겪을 것입니다. 이 경우에 대한 책임은 피드를 잘못 만든 프로그램에 있겠지만, 클라이언트 측의 엄격함으로 인해 고통을 겪는 건 여러분이 만든 소프트웨어의 사용자*일 것입니다*.

이 글을 읽고, 저는 그의 사고 실험에 참여해봤고(역주: 그의 사고에 따라 생각을 전개해봤고), 제가 완전히 틀렸으며, 그가 옳다는 걸 깨달았습니다. (시몬스 역시 그의 생각을 바꿨습니다. [이 글](http://inessential.com/2004/01/16/compromise_on_atom_and_xml)과 [이 글](http://inessential.com/2004/01/16/why_the_compromise)에서 이후 전개를 살펴보세요.)

"[사고 실험](https://web.archive.org/web/20060420051806/http://diveintomark.org/archives/2004/01/14/thought_experiment)"에서 그의 주장에 근거하여, 필그림은 제가 틀렸다는 것을 납득시켰습니다. 그런데 흥미로운 것은 *그는 제가 최초에 "엄격해야 한다"는 그룹의 편을 들게 했던 세 가지 요점 중 단 하나도 반박하지 않았다는 점입니다.*

첫번째 포인트: 제가 어떤 주장에 대해 생각을 바꿨을 때는, 제가 사실을 잘못 알고 있었기 때문이 *아니었습니다*. 잘못된 사실(the wrong facts)을 보고 있었기 때문입니다.

## 두번째 포인트

돌이켜보면, 모든 블로그 소프트웨어(weblog software)의 배경이 되는 기본적인 아이디어는 간단해 보입니다. 웹사이트를 *페이지(pages)*의 모음으로써 관리하기 보다는, *포스트(posts)*의 모음으로 관리하고, 블로그(weblog) 소프트웨어가 포스트를 웹페이지로 변환해주는 것입니다.

너드가 아닌 이들을 위한(for non-nerds) 블로그 소프트웨어의 장점은 확실합니다. 그 소프트웨어가 없었다면, 그들은 스스로의 웹사이트를 출판할(publish) 수 없었을 것입니다.

그러나 너드들을 위한, 즉 HTML 파일로 직접 코딩할 수 있는 능력을 충분히 갖춘 HTML 전문가와 같은 너드들에게 있어 블로그 소프트웨어의 장점은 무엇일까요? 물론, 모든 페이지를 직접 코딩하는 소수의 [비타협주의자들](http://zeldman.com/)도 있긴 하지만, 세계적으로 [유명하고](http://stopdesign.com/) [지식이 풍부한](http://simplebits.com/) 웹 개발자들도 블로깅 소프트웨어 패키지를 사용합니다(또는 스스로 출판용 소프트웨어를 만들어서 사용합니다).

해답은 편리함과 유연함입니다. 블로그 소프트웨어는 웹사이트 업데이트 과정에서의 엄청난 지루한 작업(monotony)를 제거해줍니다. 고백하자면, 저는 개인적으로 [Daring Fireball](https://daringfireball.net/)(역주: 저자의 블로그. 이 글의 출처)을 시작하기 불과 몇달 전인 2002년까지도 이 사실을 깨닫지 못 했습니다. 저는 모든 웹사이트를 직접 코딩할 수 있었고, ― 사실상 직접 코딩하는 게 *쉬웠기에* ― 이 과정에 엄청나게 반복적인, 미련한 코드 작업(an awful lot of repetitive monkey work)을 하고 있다는 사실을 깨닫지 못 했습니다.

[Daring Fireball](https://daringfireball.net/)에 새 포스트를 작성할 때마다 다음과 같은 과정을 따릅니다.

1. 메인 페이지(home page)의 상단에 새로운 포스트를 노출합니다(메인 페이지의 가장 오래된 게시물은 제거합니다).
1. 새 포스트에는 그 자신의 페이지에 홈으로 가는 링크가 있습니다(The new post gets a permanent home on a page by itself).
1. RSS 피드를 새 포스트와 함께 업데이트합니다.
1. 제목과 새 페이지에 대한 링크는 [아카이브 페이지](https://daringfireball.net/archives)에 추가됩니다.
1. 제목과 새 페이지에 대한 링크는 이전 페이지에 "다음 글"을 가리키도록 추가됩니다.

단 하나의 ― 새 포스트 작성이라는 ― 행동을 하면, [무버블 타입(Movable Type)](https://www.movabletype.org/)에서 하나의 새 파일을 만든 후, 4개의 다른 파일을 업데이트합니다. 이 작업 중 어떤 것도 직접 코딩하기에 *어려운* 건 없습니다. 대부분, 복사/붙여넣기 작업입니다. 그러나 이건 분명히 지루한 작업이고, 고된 작업이 아니라 해도 여전히 실수할 가능성이 높습니다. 지루한 반복적인 일을 컴퓨터는 확실하게 잘 처리하고, 인간은 잘하지 못 합니다.

게다가, 캡슐화(encapsulation)를 하는 게 자연스럽습니다. 새 포스트를 작성하는 것은 ― 또는 기존 포스트를 변경하는 것은 ― 단일 작업(one task)이어야 한다고 *느꼈습니다.* 제가 수정하고 싶은 건 하나의 포스트일뿐, 그것을 노출하는 각각의 개별 페이지가 아닙니다.

두번째 포인트: 그러므로, 어떤 작업이 어렵지 않다는 것이 반드시 그 방법을 따라야한다는 의미는 아닙니다.

## 마크다운의 근거 확립을 위해, 첫번째 포인트와 두번째 포인트를 결속시켜보기 위한 장

한걸음 뒤로 물러서 봅시다. 저는 앞에서, 블로그 소프트웨어가 웹페이지의 묶음 대신 포스트의 묶음으로써 웹사이트를 관리할 수 있게 해준다고 적었습니다.

그런데, *포스트*란 무엇일까요?

상식적으로 보면, 포스트는 HTML 코드 조각입니다. 모든 HTML 문서가 아니고, (형식을 갖춘 텍스트인) HTML 코드 조각일 뿐입니다. 블로그 소프트웨어가 전체 HTML(그리고/또는 XML) 문서를 작성합니다. 여러분의 블로그 템플릿에는 ― `<html>`, `<head>`, `<body>` 등 ― 문서 구조와 관련한 모든 태그가 있으며, 포스트를 출력할 공간(slots)도 있습니다. 여러분이 웹페이지를 출판하면, 블로그 소프트웨어는 HTML 코드 조각인 포스트를 HTML 템플릿에 결합합니다.

2002년 8월부터 작년 8월경(역주: 2003년 8월경)까지, [Daring Fireball](https://daringfireball.net/)을 오픈한 첫해동안, 저는 이 "HTML 코드 조각으로써의 포스트(post-as-snippet-of-HTML)" 개념을 사들여서(buy) 매우 기뻤습니다. 저는 어떤 대안도 생각해본 적이 없었습니다. 제가 [Daring Fireball](https://daringfireball.net/)에 쓴 모든 글은, HTML 양식에 맞춰 작성했습니다(정확히는 *XHTML*, 하지만 이 차이는 그리 중요하지 않습니다).

물론, HTML은 *문서* 형식이기 때문에 HTML *코드 조각*은 유효한 형식일 수 없습니다. 여러분은 ― 모든 태그를 잘 닫고, 앰퍼센드(`&`)와 꺽쇠 괄호 이스케이핑 처리를 잘 하여 ― *훌륭하게 구성한* HTML 코드 조각을 작성할 수 있습니다. 그러나 그 HTML 코드 조각은 [W3C HTML Validator](http://validator.w3.org/)에 통과하지 못할 것이며, BBEdit의 HTML 구문 확인 도구도 통과하지 못할 것입니다.

저는 이러한 워크플로우를 의도했습니다:

1. BBEdit에서 쓰고 편집하고, 고칩니다.
1. 다 작성했으면, 무버블 타입의 웹사이트에서 로그인하여 포스트를 붙여넣기한 후, 출판합니다.

하지만 저의 실제 워크플로우는 아래와 같습니다:

1. BBEdit에서 작성합니다.
1. 브라우저에서 미리보기합니다.
1. 수정하기 위해 BBEdit로 돌아갑니다.
1. 작성이 완료될 때까지 반복합니다.
1. 무버블 타입 웹사이트에서 로그인하여, 포스트를 붙여넣기 한 후, 출판합니다.

결국, 저는 이게 *미친 짓이라는* 생각이 들었습니다. 글쓰기에 있어 컴퓨터를 사용하는 가장 큰 장점은 즉시 수정할 수 있다는 겁니다. 쓰고, 읽고, 고치는 작업을 모두 같은 창에서, 같은 모드로 말입니다.

HTML 문법 그대로(raw) 텍스트를 작성하는 것*에 대한*  ― 제가 스스로 수년간 해왔던 ― 논쟁의 쟁점은, HTML이 어렵지 않다는 점입니다. *저는 여전히 이에 동의합니다.* HTML은 배우기 매우 쉽고, 한번 배우고 나면, 쉽게 적용할 수 있습니다. 본격적인 웹 개발 작업이라면? 그건 어렵습니다. 하지만 ― HTML 문법 그대로 블로그 글을 구성하기에 충분한 ― HTML 기본 태그와 문법이라면, 그건 쉽습니다.

그러나 [Lynx](http://lynx.browser.org/)와 같은 평문 형태의 텍스트(일반 텍스트, plain text) 브라우저가 HTML 문서의 소스 코드를 그대로 보여주지 않는 데에는 이유가 있습니다. 그것(HTML 문법 그대로 출력한 문서)은 쉽게 읽을 수 있는 형식이 아니기 때문입니다. 읽을 수 없는 형식으로 글을 쓴다는 게 이상하지 않나요? 이건 좀 아니라는 생각이 갑자기 들었습니다.

첫번째 포인트 적용: HTML을 직접 작성하는 게 어렵다고 주장하는 게 아닙니다. 쉽다는 것에 동의합니다. 저는 약간 다른 관점(an orthogonal point)을 주장합니다. 쉽다고 말하고 있는 게 글(산문, prose)을 읽으며 작성하는 문서가 *아니라*, 마크업을 이용해 태그를 쓰고 있는 문서라는 겁니다.

두번째 포인트 적용: HTML로 텍스트를 작성하는 게 쉽다고 주장한다 해도, 성가신 작업이 아닌가요? "`AT&T`"대신 "`AT&amp;T`"라고 작성하는 게 지긋지긋하지 않습니까? (URL 내의 `&` 인코딩은 말할 필요도 없겠죠?)

2004년입니다. 여러분의 컴퓨터에서 단락과 부제목을 어디에 썼는지 확인할 수 있어야 하지 않을까요?

그리고, 무버블 타입의 "줄바꿈 변환(Convert Line Breaks)" 기능이 여러분에게 유용하다고 이야기하지 마세요. 무버블 타입 2.661 버전의 "줄바꿈 변환"은 입력받은 이 두 행을 변환합니다.

```html
<h2>This is a header.</h2>

This is a paragraph.
```

아래처럼 말이죠.

```html
<p><h2>This is a header.</h2></p>

<p>This is a paragraph.</p>
```

어리석은 짓입니다. [타입패드(TypePad)](https://www.typepad.com/)는 분명 블록 레벨의 HTML 태그 주위에 가짜 `<p>`태그를 감싸지 않을 정도로 똑똑하지만 ― 그러니 무버블 타입 3.0도 아마 그렇게 되겠죠 ― 그럼에도 여전히 HTML 코드의 시각적 혼란이나, 다른 성가심을 해결하지 못합니다.

데스크톱 블로그 에디터가 왜 "미리보기(preview)" 모드를 제공해야 할까요? 여러분은 이메일을 보내기 전에 "미리보기"를 필요로 하지 않습니다. 그 자리에서 쓰고, 읽어본 후, 수정하죠.

솔직히, 저는 이메일 쓰는 걸 좋아합니다. 이메일은 제가 가장 좋아하는 글쓰기 매체입니다. 지난 5년동안 저는 16,000통이 넘는 메일을 보냈습니다. 일반 텍스트 형식의 이메일 규칙을 따르면 어떠한 방해 요소도 없이 분명하고 정확하게 글을 작성할(express) 수 있습니다.

그래서, 웹을 위한 이메일-스타일의 글쓰기, 마크다운을 소개합니다(Thus, Markdown. Email-style writing for the web).

텍스트를 HTML로 변환해주는(text-to-HTML) 대부분의 필터는 HTML 태그가 어렵다는 전제를 깔고 있다보니, HTML 태그를 자체적인 태그로 변경하려 하지만, 결국 HTML에 비해 "쉽거나" 가독성이 좋아지는 건 아닙니다. 또한 그 도구들은 직접 조작하는 것을 어렵게 만들고(making it hard to drop into manual), 여러분이 정말로 필요하다고 느낄 때는 그냥 HTML 문법을 그대로 사용하게 만듭니다.

다른 필터들은 HTML을 대체하고자 합니다. 마크다운은 다른 지점을 목표로 합니다. 그 목표 지점은 여러분이 실제 HTML 코드를 사용하기 쉽게 해주는 것과, 일반 텍스트로 작성하는 게 합리적이고 명확한 상황에서 여러분이 그렇게 할 수 있도록 해주는 것 사이의 적절하고도, 달콤한 장소(sweet spot)입니다.

대부분의 블로그 앱들이 제공하는 ― 기울임체, 볼드체, 링크, 단락, 인용블록과 같은 ― 태그들은 애초에 "태깅(tagging)"에 대해 걱정할 필요가 없는 태그입니다(역주: 사용이 어렵지 않다는 뜻). 이 태그들을 쉽게 삽입할 수 있도록 하는 게 글쓰기를 더 쉽게 해주는 건 아니며, 오히려 여러분의 작품(composition)을 읽기 어렵게 만든다는 겁니다.

하지만, 여러분이 ― 커스텀 클래스 속성을 사용하는, 특정 서식을 지정한, 순서가 있는 목록처럼 ― HTML 문법 그대로를 글 안에서(inline) 사용할 필요가 있을 경우에는, HTML을 바로 넣을 수 있어야 합니다. 마크다운은 HTML을 위한 프리프로세서(pre-processor)이므로, 마크다운에서 이스케이프 모드나 특수 모드 전환을 위한 마커가 없는 경우, HTML 코드를 바로 사용할 수 있습니다.

(여러분이 마크다운 형식의 문서를 HTML 형식이 아닌 어떤 형식으로 변환하고 싶다면, 먼저 HTML 형식으로 변환한 후에, 이미 존재하는 HTML을-원하는-언어로-변경해주는(HTML-to-whatever) 필터를 사용하면 됩니다.)

제가 HTML이 쉽다고 생각하고 있음에도 불구하고, 그리 어렵진 않지만 꽤 까다로운 부분이 있습니다: HTML 마크업을 이용해 HTML 마크업에 대해서 쓰는 건 가장 큰 고통입니다. 여러분이 코드에 대해 마크다운으로 글을 쓸 때는, `<` 와 `&`를 `&lt;`와 `&amp;`로 매번 이스케이프 처리할 필요 없이, 예제 코드 그 자체에 대해서만 고민하면 됩니다.

문서에서 글 안에 HTML 태그를 쉽게 포함시킬 수 있을 뿐 아니라, 코드 문자열(span)과 코드 블록 내에 HTML 형식의 *예제* 태그를 쉽게 포함시킬 수 있습니다.

## 감정 VS. 사고

일반 텍스트의 ― 단일한 서체 모양, 단일한 서체 크기, 기울임꼴이나 볼드체가 없는 ― 서체상 제약조건들(typographic constraints)은 타자기의 제약 조건과 매우 유사합니다. 여러분에게 선물을 사줄만한 멋진 누군가를 떠올려 보세요: 선물은 고전 소설의 타자 원고 원본(original typewritten manuscript)입니다. 이걸 피츠제럴드의 "위대한 개츠비"라고 칩시다. 여러분은 이 원고를 들고 자리에 앉아 읽기 시작합니다. 막힘 없이, 훌륭하게 제본하여 조판해둔 책을 읽을 때와 똑같은 독서 경험을 가질 수 있을 것입니다. 그렇습니다. 그것은 기울임꼴 같은 것 대신에 밑줄이 그어져 있고, 타자기의 거친 고정폭 스타일(쿠리에 스타일, Courier-esque)의 서체로 구성되어 있습니다. 그러나 이야기는 여전히 피츠제럴드가 전하고자 했던 대로 매끄럽게, 원고에서 마음으로 흐를 것입니다.

글 전반부에 인용한 스탠리 큐브릭의 문구는 제가 가장 좋아하는 것 중 하나입니다. 여러분이 HTML 태그로 작성한(mark-up with HTML tags) 텍스트를 쓰고 읽을 때는, *그 텍스트에 대한 사고*에 집중하도록 강요받습니다. 마크다운 형식의 텍스트로 전달하고자하는 것은 *그 텍스트에 대한 감정*입니다.
