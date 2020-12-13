---
layout: post
title: 기하 평균
date: 2020-12-13
tags: [math]
---

n개의 양수 값을 모두 곱한 것의 n제곱근

## 정의

> 기하 평균(幾何平均, geometric mean)은 n개의 양수 값을 모두 곱한 것의 n제곱근이다.

(출처 - [기하 평균 - 위키백과 한국어판(2020.11.13)](https://ko.wikipedia.org/w/index.php?title=%EA%B8%B0%ED%95%98_%ED%8F%89%EA%B7%A0&oldid=28021451))

## 설명

우리가 익히 "평균값"이라고 하면 떠올리는 평균은 산술 평균이다. 산술 평균은 n개의 수를 모두 더해서 n으로 나누었을 때의 값이다. 이에 비해, 기하 평균은 n개의 수를 모두 곱한 후, 그 수의 n제곱근 값이다. "n제곱근값"이라는 건, "n번 곱해서 해당 값을 만들 수 있는 수"를 의미한다. 예를 들어, 16의 제곱근(두 제곱근)은 4이고, 27의 세 제곱근은 3이다.

산술 평균과 비교해서 기하 평균을 이해하는 게 이해를 돕는데 도움이 되므로, 다시 한번 비교를 해보겠다.

배열 `[1, 5, 3, 2, 1]`의 요소에 대한 산술 평균은 3($$= \frac{1 + 5 + 3 + 2 + 1}{5}$$)이다. 3을 배열 요소의 개수만큼 더한 값은, 모든 요소를 더한 값과 같다.

$$1 + 5 + 3 + 2 + 1 \quad=\quad 3 + 3 + 3 + 3 + 3 \quad=\quad 15$$

배열 `[4, 9]`의 요소에 대한 산술 평균은 6($$= \sqrt{4 \times 9}$$)이다. 6을 배열 요소의 개수만큼 곱한 값은 모든 요소를 곱한 값과 같다.

$$4 \times 9 \quad=\quad 6 \times 6 \quad=\quad 36$$

산술 평균값이 요소의 총합과 요소의 개수로 도출되는 반면, 기하 평균 값는 요소의 총곱과 요소의 개수로 도출이 된다. "총곱"이라는 말이 있는지 모르겠는데, 만약 없다면 "모든 값을 곱한 값"이라고 치자.