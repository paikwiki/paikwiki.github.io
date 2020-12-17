---
layout: post
title: 42서울 교육과정 3서클 minishell 학습 노트
date: 2020-12-14
tags: [42seoul, forty-two, 42cursus, minishell]
---

42서울 본과정의 세 번째 서클에 포함된 프로젝트, minishell을 작성중인 메모입니다. 아래는 과제를 위한 비공개 저장소의 URL입니다. minishell은 팀 프로젝트로, seoh님과 함께 프로젝트를 진행하고 있습니다.

- paikwiki/minishell(private): [https://github.com/paikwiki/minishell](https://github.com/paikwiki/minishell)

과제를 마칠 때까지 본 포스트는 계속 수정됩니다.

## 토큰

쉘에서 입력을 처리하기 위해서는 적절한 단위로 명령문을 나눠야 한다. 이때, 명령문을 나누는 최소 단위를 토큰(token)이라고 한다.

예를 들어, 아래와 같은 요소들이다.

- token_string: 따옴표, 큰따옴표 없이 등장하는 1개 이상의 문자로 구성된 문자열
- token_qoute_single: 따옴표로 시작해 따옴표로 끝나는 문자열
- token_qoute_double: 큰따옴표로 시작해 큰따옴표로 끝나는 문자열
- token_redirection: `<`, `>`. `>>` 등의 리디렉션
- token_semicolon: 명령을 종료하는 세미콜론(`;`)
- token_pipe: 명령문을 조합할 때 사용하는 파이프(`|`)
- token_space: 공백

문자열을 처음부터 끝까지 읽어가면서, 위 요소들에 맞춰 토큰을 추출할 수 있는 함수를 만들어보려 한다. 크게 네 가지로 나눈다.

1. 일반 문자열: 문자열을 쭉 따라가다가 공백이 등장하면 현재 위치의 이전 인덱스까지를 토큰으로 처리
1. 따옴표, 큰따옴표를 포함한 문자열: 문자열을 쭉 따라가다가 시작지점과 쌍이 맞는 따옴표/큰따옴표가 등장하면 현재 위치의 인덱스까지 토큰으로 처리
1. 리디렉션, 파이프, 세미콜론 : 각 토큰의 정해진 길이만큼 인덱스를 이동시킨 후, 해당 위치까지 토큰으로 처리. 한 글자일 경우엔 이동 없이 해당 문자만 토큰으로 처리
1. 공백: 연속된 공백만큼 인덱스를 이동한 후, 공백 한 칸만 토큰으로 처리

위 네 가지 경우를 처리하기 위해 `gen_token_space()`, `gen_token_qoutes()`, `gen_token_short()`, `gen_token_string()`, 이렇게 네 개의 함수를 만들었다. `gen_token_space()`를 제외하고 나머지 함수들은 함수 내부에서 데이터에 따라 각각의 타입에 맞게 토큰의 타입을 지정해줄 수 있도록 할 것이다.

토큰을 담는 구조체를 아래처럼 정의했다.

```c
typedef struct	s_token
{
	char	*data;
	int		type;
}				t_token;
```

42서울 본과정 첫 번째 과제로 작성한 Libft의 연결리스트를 이용해 가져온 토큰을 리스트에 저장했다.
## 테스트용 명령어

아래 명령어를 이용해 토큰 단위로 잘 쪼개지는지 확인했다.

```sh
echo "hello" world 'more "text"' <    test|cat -e   ; echo 'I have | in qoute' >> result.txt
```

이렇게 입력하면 총 25개의 토큰으로 나뉜다. 아래는 각 토큰의 문자열을 `$문자열$\n` 형태로 출력한 결과이다.

```txt
$echo$
$ $
$"hello"$
$ $
$world$
$ $
$'more "text"'$
$ $
$<$
$ $
$test$
$|$
$cat$
$ $
$-e$
$ $
$;$
$ $
$echo$
$ $
$'I have | in qoute'$
$ $
$>>$
$ $
$result.txt$
```
