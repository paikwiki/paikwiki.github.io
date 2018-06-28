---
layout: post
title: Node.js와 npm 실행시 icu4c 관련 오류 해결하기
date: 2018-06-27
---

Homebrew를 이용해 Node.js와 npm을 업데이트한 후 icu4c 라이브러리를 불러오지 못하는 오류가 발생했다. 결론부터 이야기하자면, Node.js에서 쓰는 icu4c의 버전(61.1)과, 내 컴퓨터의 icu4c 버전(62.1)이 일치하지 않아서 발생한 문제였고, 61.1 버전을 사용하도록 심볼릭 링크를 수정하여 해결했다. 지난 번에도 겪었던 문제였기에 이번 기회에 해결 방법을 정리해봤다.

## 문제 상황

````sh
$ node -v
dyld: Library not loaded: /usr/local/opt/icu4c/lib/libicui18n.61.dylib
  Referenced from: /usr/local/bin/node
  Reason: image not found
Abort trap: 6
````

예전에 npm 업데이트했을 때도 이와 비슷한 오류가 발생해서 애를 먹었는데, 그때 어떻게 해결했는지 기억이 나질 않는다. 아마 업데이트를 포기하고 이전 버전을 그냥 사용했던 것 같다. npm을 계속 이전 버전으로 사용하고 싶진 않으니 이번에는 문제의 원인을 알아보고, 업데이트를 마무리하기로 했다. 우선 불러오지 못하고 있는 라이브러리가 무엇인지 알아봤다.

## icu4c 라이브러리

icu4c 라이브러리는 무얼 하는 라이브러리길래 npm 실행에서 필요한 걸까? 검색을 통해 [ICU 공식 웹사이트](http://site.icu-project.org/)를 찾을 수 있었다. ICU는 "International Components for Unicode"의 줄임말이었다. [IBM Knowledge Center의 ICU4C 문서](https://www.ibm.com/support/knowledgecenter/ko/ssw_aix_71/com.ibm.aix.nlsgdrf/icu4c_lib.htm)를 참고해, 번역도구의 도움을 받아 ICU 라이브러리의 소개글을 번역했다.

````txt
ICU는 소프트웨어 어플리케이션에 유니코드 및 전역화를 지원하는, 널리 사용되는 훌륭한 C / C ++ 과 Java 라이브러리 세트입니다. ICU는 이식성이 뛰어나며, C/C++ 소프트웨어 및 Java 소프트웨어 간 동일한 결과를 제공합니다.
ICU는 상업용 소프트웨어 및 기타 오픈 소스 또는 무료 소프트웨어와 함께 사용하기에 적합한 제한없는 오픈 소스 라이선스에 따라 배포됩니다.

 ICU is a mature, widely used set of C/C++ and Java libraries providing Unicode and Globalization support for software applications. ICU is widely portable and gives applications the same results on all platforms and between C/C++ and Java software.
ICU is released under a nonrestrictive open source license that is suitable for use with both commercial software and with other open source or free software.
````

icu4c에 대한 소개글은 다음과 같다.

````txt
C와 C++ 언어 및 많은 운영 체제 환경은 유니코드와 표준 텍스트 처리 서비스를 완벽하게 지원하지 않습니다. 일부 플랫폼에서는 좋은 유니 코드 텍스트 처리 서비스를 제공하지만 이식 가능한 어플리케이션 코드는 이를 사용할 수 없습니다. ICU4C 라이브러리는 이러한 틈을 채워줍니다. ICU4C는 어플리케이션이 소프트웨어 전역화에 사용할 수있는 개방적이고 유연한 이식할 수 있는 기반을 제공합니다. ICU4C는 유니 코드 및 CLDR (Common Locale Data Repository)를 포함한 업계 표준을 엄격히 따릅니다.

The C and C++ languages and many operating system environments do not provide full support for Unicode and standards-compliant text handling services. Even though some platforms do provide good Unicode text handling services, portable application code can not make use of them. The ICU4C libraries fills in this gap. ICU4C provides an open, flexible, portable foundation for applications to use for their software globalization requirements. ICU4C closely tracks industry standards, including Unicode and CLDR (Common Locale Data Repository).
````

요약하자면, ICU 라이브러리는 유니코드를 처리하기 위한 공용 구성요소이며, icu4c는 C/C++을 위한, icu4j는 Java를 위한 라이브러리였다.

## 진단

`brew list icu4c` 명령어로 찾아보니 `icu4c`가 있었다. `icu4c` 디렉토리를 살펴보기로 했다.

````sh
$ ll /usr/local/Cellar/icu4c/
total 0
drwxr-xr-x   4 chPaik  admin   136  6 27 15:14 ./
drwxr-xr-x  92 chPaik  admin  3128  6 21 16:53 ../
drwxr-xr-x  12 chPaik  admin   408  6 27 16:27 61.1/
drwxr-xr-x  12 chPaik  admin   408  6 27 15:14 62.1/
````

> `ll`은 `ls -al`의 별칭(alias)이다.

디렉토리를 보니 두 버전의 icu4c 가 있었다. 오류 메시지에서는 `libicui18n.61.dylib` 파일을 찾지 못하고 있었는데, 내 개발환경에서는 `libicui18n.62.dylib`를 쓰고 있는 상황이었다. 이 상황을 해결하기 위해 `libicui18n.62.dylib` 대신 `libicui18n.61.dylib`를 사용하기로 했다.

## 해결

변경할 방법을 찾기 위해 icu4c 라이브러리를 불러오는 경로를 확인했다.

````sh
$ vi ~/.bash_profile
.
.
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
.
.
.
````

환경변수를 보고 해당 경로로 이동해 무엇이 들어있는지 확인했다.

````sh
$ ll /usr/local/opt
.
.
lrwxr-xr-x    1 chPaik  admin    20  6 27 16:26 icu4c@ -> ../Cellar/icu4c/62.1
.
.
.
````

`icu4c`가 62.1 버전을 가리키고 있다. 61.1버전을 사용하도록 변경하기 위해 기존의 심볼릭 링크를 삭제하고 61.1 버전으로 다시 연결해줬다.

````sh
$ rm icu4c
remove icu4c? y
$ ln -s ../Cellar/icu4c/61.1 icu4c
````

터미널 재실행 후 확인.

````sh
$ node -v
v8.11.1
$ npm -v
5.6.0
````

정상적으로 실행된다.

## 정리

커맨드라인 어플리케이션을 실행했을 때, 어떤 작업이 이루어지는지 속속들이 알고 싶은 게 사람 마음이랬나(아닐지도 모르겠다)... Node.js가 왜 62.1 버전이 아닌 61.1 버전의 icu4c를 사용하는지 면밀하게 뜯어보지 않고 icu4c 라이브러리를 다운그레이드해서 Node.js 업그레이드를 마무리했다. 무사히 업그레이드를 마쳤으나, [icu4c 라이브러리 61.1 버전에서 62 버전으로 변경되면서 무엇이 바뀌었는지](https://sourceforge.net/p/icu/mailman/message/36348365/), 그리고 Node.js는 무언가가 개선된 62.1 버전을 사용하지 않는 건지 궁금증을 모두 해소하진 못 했다. 62.1 버전의 릴리즈가 불과 일주일 전이었기 때문이 아닐까 추측해보긴 하지만, 그저 추측일 뿐이다.

6월 21일에, 어떤 필요에 의해 icu4c 62.1 버전이 내 컴퓨터에 설치된 건지도 궁금하다. 심볼릭 링크를 저렇게 변경하는 게 다른 어플리케이션에 혹시 영향을 주는 건 아닐지 걱정도 된다. 하지만 내일 해결해야 할 과제가 아침과 함께 무더기로 찾아올테니 이 문제는 이렇게 정리해보는 걸로 마무리했다. 결국 야심차게 시작했고, 목표를 달성했음에도 속이 후련할 정도로 멋진 해결책을 찾진 못 했다. 정말 개발환경이라는 건 캐도 캐도 계속 캘 게 많은 광산이다.

## 부록: 오늘의 사건

오늘은 2018 러시아월드컵 F조 마지막 예선 경기가 열렸다. 예선 내내 부진했던 한국이 독일을 상대로 2:0 승리를 거머줬다. 탈락이 거의 확정된 상황에서 귀국 동반자로 독일을 선택한 셈이다. 본문과는 관련이 없지만, 세상일이라는 게 참 묘하다는 걸 느끼게 해준 사건이라 기록해 둔다.
