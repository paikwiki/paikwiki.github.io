---
layout: post
title: 번역 - 마크다운을 소개합니다
date: 2020-03-30
tags: [translation, markdown, john-gruber]
---

> 이 글은 [존 그루버(John Gruber)](https://daringfireball.net/)가 마크다운을 공개한 후, 작성한 블로그 포스트, "[Introducing Markdown](https://daringfireball.net/2004/03/introducing_markdown)"을 원저자의 허락을 얻어 번역한 글입니다.
>
> 존 그루버는 이 포스트를 작성한 나흘 뒤, 또다른 포스트인 "[마크다운에 빠져봅시다(Dive into Markdown)](https://daringfireball.net/2004/03/dive_into_markdown)"에서 마크다운의 철학과 제작 동기를 밝히고 있습니다. ["마크다운에 빠져봅시다"의 번역](/2020/03/dive-into-markdown-ko)도 함께 포스팅하였으니 이 글과 함께 보시길 권합니다.

<span style="color: #aaa">2004년 3월 15일, 월요일.</span>

저는 일반 텍스트를 HTML 형식으로 변환해주는 [마크다운(Markdown)](https://daringfireball.net/projects/markdown/)이라는 도구를 개발했습니다. 이 도구는 현재 다운로드해서 사용할 수 있습니다. 마크다운은 웹 제작자가 간단하면서 가독성이 좋은, 일반 텍스트(plain text) 형식의 문법을 이용해 텍스트를 작성할 수 있도록 해줍니다. 마크다운은 여러분이 작성한 글을 유효한 XHTML(혹은 HTML) 문서로 변환해줍니다.

네, 그렇습니다. 질문을 받기에 앞서 말씀드리면, 마크다운은 일종의 [텍스타일(Textile)](http://textism.com/tools/textile/) 같은 겁니다. 둘이 다르다는 것만 제외한다면 말입니다(Except that it’s different).

마크다운은 [무버블 타입(Movable Type)](https://www.movabletype.org/)과 [블로썸(Blosxom weblogs)](http://blosxom.sourceforge.net/)을 위한 플러그인으로 사용할 수 있으며, ([비비에디트(BBEdit)](https://www.barebones.com/products/bbedit/)의 텍스트 필터로도 사용할 수 있는) 독립적인 펄(Perl) 스크립트이기도 합니다. GPL 라이선스로 사용 가능합니다.

만약 관심이 생긴다면, 이 도구를 다운로드하여, [마크다운 프로젝트 페이지](https://daringfireball.net/projects/markdown/)에서 마크다운 문법의 모든 세부 사항을 배울 수 있습니다(또는 [온라인 데모 앱](https://daringfireball.net/projects/markdown/dingus)에서 직접 사용해 볼수도 있습니다).

만약 관심이 생기지 *않는다면*, 제가 여러분이 마음을 바꿀 수 있도록 노력해보겠습니다.
