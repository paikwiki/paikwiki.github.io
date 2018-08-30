---
layout: post
title: 뉴스보트(Newsboat)에서 Vim 스타일로 탐색하기
date: 2018-08-30
---

터미널을 쓰다보면 가끔 CLI 환경에서도 뭔가 딴짓이 하고 싶어진다. 지금까지 해본 '커맨드라인을 떠나지 않고 할만한 딴짓'이 몇 가지 있다. 대표적인 걸 생각해보자면 프롬프트 표시를 변경한다거나, git-radar 같은 도구 설정하기, 터미널에서 실행하는 웹브라우저 쓰기와 같은 것들이었다. Emacs나 VIM 연습과 설정도 꽤 재밌다. 그러던 중 발견한 [뉴스보트(Newsboat)](https://newsboat.org/)는 터미널에서 RSS 피드를 받아볼 수 있는 툴이다. RSS 피드가 널리 쓰이지 않아서 피드를 제공하지 않는 블로그도 꽤 많다. 나는 주로 개발자 블로그의 피드를 받아보고 있는데 대부분의 블로그에서 피드를 제공해서 꽤 만족하며 사용하고 있다. 꼭 받아보고 싶은 블로그 두 군데에서 RSS 피드를 제공하고 있지 않았다. 어쩔 수 없이 가끔 따로 방문하는 수밖에.

그런데 좀 사용하다 보니 사소하지만 내게는 치명적인 불편함이 있었다. 피드 목록을 탐색하거나 포스트를 읽어 내려갈 때 `hjkl` 방향키를 지원하지 않는다는 점이다. 터미널에서는 주로 명령행을 입력해 사용하다 보니 방향키를 사용할 일이 자주 없다. 그러다보니 뉴스보트를 실행한 후 새 피드가 있는 블로그로 커서를 이동하려고 하면 VIM 쓰던 습관 때문에 나도 모르게 아래 방향키 대신 `j`를 입력하고 있는 경우가 많았다.

검색을 해보니 [관련 이슈](https://github.com/newsboat/newsboat/issues/36)가 등록돼 있었다. 그중 [설정을 통해 키바인딩을 변경할 수 있다는 답변](https://github.com/newsboat/newsboat/issues/36#issuecomment-350974335)을 찾았다.

````sh
unbind-key h
unbind-key j
unbind-key k
unbind-key l

bind-key h quit
bind-key j down
bind-key k up
bind-key l open
````

뉴스보트의 설정파일을 찾아 적용해주면 키맵을 변경할 수 있었다. [공식 문서](https://newsboat.org/releases/2.12/docs/newsboat.html)에서 확인해보니 설정파일은 `~/.newsboat/config`였다.

> Several aspects of newsboat’s behaviour can be configured via a configuration file, by default $HOME/.newsboat/config. This configuration file contains lines in the form <config-command> <arg1> .... The configuration file can also contain comments, which start with the # character and go as far as the end of line.

설정을 적용하고 나니 `hjkl` 방향키가 잘 동작했다. 같은 이슈의 답변 중 [목록의 처음과 끝으로 이동하는 키를 매핑하는 답변](https://github.com/newsboat/newsboat/issues/36#issuecomment-339421200)이 있어 해당 내용도 설정에 적용했다. 하지만 아직은 받아보는 블로그가 10여 개뿐이라 이 키는 잘 활용하지 않는다.

뉴스보트는 터미널에서 읽을거리를 접할 수 있게 해준다는 점에서 매우 매력적인 도구다. 나는 고용된 노동자가 아니기 때문에 남몰래, 일하는 척하면서 딴짓을 해야할 필요가 없다. 남의 눈을 피해 터미널에서 딴짓을 한다기 보다는 커맨드라인으로 할 수 있는 능력치를 끌어올리고 싶은 딱히 공감받기 힘든 개인적 욕망 때문에 불필요한 노력을 쏟아붓는 편이다. 이런 노력이라는 게 남에게 권할만한 건 아니지만, 그렇다고 그만둬야 할만큼 무의미하진 않다고 생각한다. 이 딴짓들이 모여서 커맨드라인에 더욱 친숙해질 수 있게 만들어주기 때문이다. 물론 일하면서 익숙해지면 더할 나위가 없겠지만. 하여튼 딴짓을 하다보니 뉴스보트도 알게 되고, 뉴스보트의 리스트에서 `hjkl`도 쓸 수 있는 게 아니겠는가. 그런데 오늘은 막상 60% 사이즈의 키보드로 이 글을 쓰다보니 `hjkl`가 아니라 `fn`키와 함께 사용하는 방향키를 쓰게 된다. 난 뭐든지 그냥 하던대로 하지 않고, 다르게 해보고 싶은 마음에 이것저것 해보는 게 아닌가 싶다.

---

뉴스보트에 매력을 느끼는 트위터를 유저라면 [레인보우스트림(RainbowStream)](https://github.com/orakaro/rainbowstream)도 추천한다. 터미널에 새탭을 열어 레인보우스트림을 실행하면 트위터 피드를 받아볼 수 있다. 이렇게 하면 실시간 코딩 방송을 하는 기분이 든다. 채팅창에 내 코딩에는 1도 관심이 없는 이들이 모여서 코드와 전혀 무관한, 각자의 혼잣말을 쏟아붓는 그런 느낌.
