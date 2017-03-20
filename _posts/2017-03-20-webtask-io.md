---
layout: post
title: webtask.io 소개
date:   2017-03-20
draft: true
---

## 들어가는 글
[webtask.io](https://webtask.io/)는 토큰 기반 인증 서비스(AaaS(Atuhentication as a service))를 운영하는 [Auth0]의 또다른 서비스입니다. 서버리스 아키텍쳐(Serverless architacture)로 api를 만들고 배포하는 과정을 간단하게 해주는 도구입니다. 며칠 전 지인과 함께 AWS 람다(Lambda)에 대해 이야기하던 중에 소개받은 서비스인데요, 이 글에서 webtask의 기능을 간단히 살펴보겠습니다.

## Webtask CLI로 시작하기
먼저 [Webtask CLI](https://webtask.io/cli) 소개 페이지의 설명에 따라 CLI를 설치합니다.

```shell
# -g 플래그와 함께 wt-cli를 설치
$ npm install wt-cli -g

# 설치가 잘 됐는지 확인
$ wt -v
4.0.6

# 이니셜라이징
$ wt init YOUR_EMAIL
Please enter the verification code we sent to YOUR_EMAIL below.
Verification code:
```

이메일로 전달받은 인증 코드를 입력해 줍니다. 그럼 설치와 이니셜라이징을 마쳤으니, 간단한 Webtask를 실행해 봅시다.

```shell
# 파일 생성
$ echo "module.exports = function (cb) {cb(null, 'Hello webtask');}" > hello.js

# Webtask 생성
$ wt create hello.js
Webtask created

You can access your webtask at the following url:

https://wt-HASH_VALUE.run.webtask.io/hello
```

브라우저를 이용해 터미널의 주소로 들어가보면 "Hello webtask"라는 문구를 확인할 수 있습니다.
