---
layout: post
title: 스위프트 - 문자열 입력받기
date: 2020-12-14
tags: [swift, ps]
---

스위프트 언어로 알고리즘 문제를 풀 때, 문자열을 입력받는 방법에 대해 정리했다.

## 기본 문자열 입력받기

```swift
// stdin01.swift

var inputData = readLine()!

// print
print(inputData)
print("type of inputData: \(type(of: inputData))")

// result
// $ swift stdin01.swift
// Hello, Swift!
// Hello, Swift!
// type of inputData: String
```

문자열을 입력받을 때는 `readLine()`을 활용한다. 입력받은 문자는 `String`이 아니라 `Optional<String>` 타입으로 변수에 담긴다. 그렇기 때문에 위의 예제처럼 입력받는 시점에 느낌표(`!`)를 붙여 강제언래핑해주거나, 아니면 변수를 사용할 때 언래핑을 해줘야 한다.

```swift
// code A
var inputValue01 = readLine()!
print(inputValue01);

// code B
var inputValue02 = readLine()
print(inputValue02!);

// $ swift temp.swift
// Hello
// Hello
// Swift
// Swift
```

A 형태로 사용하거나, B 형태로 사용하면 된다. A를 선택한 이유는 문자열 입력과 관련없는 로직에서 강제언래핑을 하지 않기 위해서다.

Swift 언어를 사용해 어플리캐이션을 제작하는 경우, 아무리 의도치 않은 값이 들어오지 않을 것이라고 확신한다 해도, 강제언래핑보다는 `guard` ~ `let` 구문을 활용해 예기치 못한 오류를 방지한다. 알고리즘 문제풀이나 코딩 테스트 준비에 있어서는 예기치 못한 값이 입력에 들어오는 경우를 별도로 처리하지 않으므로 강제언래핑을 사용하는 게 일반적인 듯 하다. 그래서 나도 코드에 강제언래핑을 사용하기로 했다. 그런데, 만약 입력에서 `!`를 붙이지 않으면, 그 이후에 변수를 쓸 때마다 언래핑해서 사용해야만 한다. 이 옵셔널 타입으로 인한 오염(?)을 넓은 범위에 전파시키고 싶지 않아서 입력받을 때 강제언래핑을 하는 방법을 선택했다.

## 입력값을 숫자로 활용하기

```swift
// stdin02.swift
var inputData = Int(readLine()!)!

// print
print(inputData)
print("type of inputData: \(type(of: inputData))")

// result
// $ swift stdin02.swift
// -0123456789
// -123456789
// type of inputData: Int
```

앞서 `readLine()`을 언래핑한 것과 마찬가지의 이유로 입력값을 숫자로 변환하는 경우에도 `!`를 이용해 `Optional<Int>`를 `Int`로 변경해준다. 역시 유효하지 않은 입력값에 대해서는 무시한다.

## 입력값을 공백으로 구분하기

```swift
// stdin03.swift
var inputData = (readLine()!.split(separator: " ")).map{ String($0) }

// print
print(inputData)
print(type(of:inputData))

// result
// $ swift stdin03.swift
// Hello Swift
// ["Hello", "Swift"]
// Array<String>
```

여기서도 `readLine()`으로 입력받은 값은 `Optional<String>`이기 때문에 강제언래핑을 해줬다. 그리고 `split(separator:)`를 이용해 공백 문자("` `")를 기준으로 각 요소를 나누어 배열로 바꿔준다. 이 때, `split(separator:)`의 반환값은 `Array<Substring>`이다. `Substring`은 말 그대로 문자열(`String`)의 일부분을 담고 있는 자료형으로 메모리의 일부를 재사용하여 효율성을 높여준다. 하지만 이 효율성을 위해 `Substring` 자료형의 데이터는 원래 문자열 데이터에 대한 참조를 갖고 있으므로, `String`으로 변환하여 사용해야 한다. 따라서 `map()`을 이용해 문자열 자료형으로 변환하여 사용한다. 자료형 출력 결과(12번째 행)를 보면 `Array<String>`으로 변환한 것을 확인할 수 있다. 만약 정수형 데이터로 변환하려 한다면 아래처럼 해야 한다.

```swift
var inputData = (readLine()!.split(separator: " ")).map{ Int($0)! }
```

`map()` 함수에서 `Int()`의 반환값을 강제언래핑해야 하는 것에 주의해야 한다. `Int()`는 형 변환에 실패할 수 있기 때문에 옵셔널 자료형을 반환한다.

`split()`과 `map()`을 활용하는 방법 외에도, Foundation 프레임워크의 `components(separatedBy:)`를 이용할 수도 있다. 이 경우에는 Foundation 프레임워크를 가져와야 하기 때문에 소스코드의 크기가 커진다.

```swift
// stdin04.swift
import Foundation

var inputData = readLine()!.components(separatedBy: " ")

// print
print(inputData)
print(type(of:inputData))

// result
// $ swift stdin04.swift
// Hello Swift
// ["Hello", "Swift"]
// Array<String>
```

만약 한 줄에 입력받은 데이터를 각각 다른 변수에 담고자 한다면? 현재 내가 알고 있는 방법으로는 아래 방법이 최선이다.

```swift
// stdin05.swift
var inputData = (readLine()!.split(separator: " ")).map{ String($0) }

var greeting: String
var name: String
(greeting, name) = (inputData[0], inputData[1])

// print
print("\(greeting), \(name)")

// result
// $ swift stdin05.swift
// Hello Swift
// Hello, Swift
```
