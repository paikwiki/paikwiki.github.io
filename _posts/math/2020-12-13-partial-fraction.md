---
layout: post
title: 부분 분수
date: 2020-12-13
tags: ["math", "mathematical-formula"]
---

## 정리

$$
\begin{matrix}
1 \over AB &=& \frac{1}{B - A} (\frac{1}{A} - \frac{1}{B})
\end{matrix}
$$

## 설명

$$1 \over AB$$를 $${\frac{1}{A} - \frac{1}{B}}$$ 형태로 변환하고 싶다면 어떻게 하면 될까? 여기서부터 생각해보면 부분 분수의 공식을 도출할 수 있다.

$${\frac{1}{AB}} = x{(\frac{1}{A} - \frac{1}{B})}$$에서 $$x$$를 구하면 된다. $$x$$를 구하기 위해 $${\frac{1}{A} - \frac{1}{B}}$$의 분모를 $$AB$$가 되도록 바꿔보면,

$${\frac{1}{AB}} = x{(\frac{B}{AB} - \frac{A}{AB})} \\
\quad \\
\qquad  = x{(\frac{B - A}{AB})}$$

이렇게 바꿔놓고 보면, $$x$$가 $$1 \over B - A$$라는 걸 쉽게 알 수 있다.

## 응용

$$
\begin{matrix}
k \over AB &=& \frac{k}{B - A} (\frac{1}{A} - \frac{1}{B})
\end{matrix}
$$

$$
\begin{matrix}
k \over ABC &=& \frac{k}{C - A} (\frac{1}{AB} - \frac{1}{BC})
\end{matrix}
$$
