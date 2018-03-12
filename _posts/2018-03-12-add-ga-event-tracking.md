---
layout: post
title: 구글 애널리틱스로 이벤트 추적하기
date: 2018-03-12
---

블로그를 개편하면서 도서의 기본 정보를 가져오기 위해 온라인 서점, [알라딘의 OpenAPI](http://blog.aladin.co.kr/openapi/6695306)를 적용했다. 도서의 표지나, 서지 정보를 제공해줄 뿐만 아니라, 블로그의 방문객이 포스트의 링크를 통해 알라딘에 접속한 후, 구매까지 이어지면 구매자에게는 구입 금액의 1%의 적립금을, 블로그의 운영자에게는 3%의 적립금을 지급하는 [Thanks To Blogger2](http://blog.aladin.co.kr/ttb/category/18642551)(이하 TTB2)라는 시스템도 한 번 사용해보고 싶었다. 판매가 이루어지는 경우에만 적립금을 지불하는 건 아니고, 클릭에 대해서도 일정 보상이 주어진다고 하여 적극적으로 도입해 봤는데, 클릭당 적립해주는 제도인 CPC는 광고를 클릭했을 때만 해당하기 때문에 내게는 아쉽게도 별 관련이 없었다. 그럼에도 불구하고, 이상하게도 알라딘 TTB2를 통해 얼마의 수익을 낼 수 있는지보다 얼마나 많은 사용자가 내 포스트를 읽고 알라딘 웹사이트로 이동해 책 정보를 조회하는지가 더 관심이 생겼다. 그래서 블로그에서 사람들이 얼마나 많이 링크를 클릭하는지 확인해보기로 했다.

이벤트 추적은 [구글 애널리틱스 가이드의 이벤트 트래킹](https://developers.google.com/analytics/devguides/collection/analyticsjs/events)을 참고했다.

구현 예제 중 `handleOutboundLinkClicks` 함수를 참고해, 내 블로그에 적용할 추적 코드를 먼저 작성해봤다.

```js
function clickABookLink(event) {
  ga('create', 'UA-XXXXX-Y', 'auto');

  ga('send', 'event', {
    eventCategory: 'Aladin TTB2',
    eventAction: 'click',
    eventLabel: document.title
  });
}
```

알라딘으로 이동하는 링크에 `eventLabel`을 위한 커스텀 데이터를 따로 지정해줄까 한참을 고민하다가 굳이 그럴 필요가 없겠다는 생각이 들어서, 이벤트가 발생한 위치의 `title`을 가져오기로 했다.

이제 알라딘으로 이동하는 링크에 `clickABookLink` 함수를 붙여주는 작업을 해야한다. 여기서 한 가지 문제가 있었다. 독서 후기 포스트만 책 표지 이미지를 노출하는 템플릿을 따로 제작해두긴 했지만 본문에도 알라딘으로 가는 링크를 포함하는 경우가 있어서, 템플릿에 간단히 `clickABookLink`를 붙일 수 없는 상황이다. 일단은 페이지의 모든 외부링크를 가져와 `ttbkey`라는 텍스트를 포함하는 링크를 찾아 `clickABookLink`를 적용하기로 했다. 별로 좋은 방법이 아닌 거 같긴 한데, 앞으로 천천히 고쳐가며 쓰면 되니까.

```js
function addABookTracker(link) {
  var url = link.getAttribute('href');
  if ( url.search('ttbkey') ) {
    link.addEventListener('click', function (e) {
      clickABookLink(e);
    });
  }
}

var links = document.querySelectorAll('a');

links.forEach(function(i) {
  addABookTracker(i);
});
```

그리고 마지막으로 `default` 레이아웃에 [analytics.js를 추가](https://developers.google.com/analytics/devguides/collection/analyticsjs/)했다.

지킬의 레이아웃에 적절히 코드 조각들을 삽입해주고, 작동이 되는 걸 확인한 후 작업 종료.
