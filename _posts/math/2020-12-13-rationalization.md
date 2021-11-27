---
layout: post
title: 분모의 유리화
date: 2020-12-13
tags: ["math", "mathematical-formula"]
---

분모에 근호가 있는 무리식이 있을 때, 분모의 근호를 제거하여 분모를 유리화

## 정리

$$
\begin{matrix}
(1) \quad \frac{a}{\sqrt{b}} = \frac{a\sqrt{b}}{\sqrt{b}\sqrt{b}} = \frac{ab}{\sqrt{b}} (단, b \ne 0) \\
\quad \\
(2) \quad \frac{c}{\sqrt{a} \pm \sqrt{b}}
= \frac{ c({\sqrt{a} \mp \sqrt{b}}) }{ (\sqrt{a} \pm \sqrt{b})(\sqrt{a} \mp \sqrt{b}) }
= \frac{ c(\sqrt{a} \mp \sqrt{b}) }{ a - b } (단, a \ne b)
\end{matrix}
$$

## 설명

분모의 유리화는 분모와 분자에 같은 값을 곱하여 분모의 근호를 제거하는 방법으로, 공식을 살펴보면 크게 어렵지 않다. 이해하기 어려운 부분은 두 번째 식에서, 분모와 분자에 곱하는 값에 "$$\pm$$"가 아니라 "$$\mp$$"가 사용됐다는 점이었다. 이는 분모에 아래 식을 대입하여, 유리화하기 위해서였다.

$$
(a + b)(a - b) = a^2 - b^2
$$
