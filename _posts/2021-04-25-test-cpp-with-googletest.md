---
layout: post
title: Bazel과 GoogleTest로 C++ 유닛 테스트 시작하기
date: 2021-04-25
tags: [cpp, unit-test, bazel, googletest]
---

## 들어가며

42서울 C++ Modules 과제를 하며 C++ 언어를 조금씩 알아가고 있다. C++ Modules 과제는 총 9개의 모듈로 구성돼 있는데, 몇몇 과제들, 특히 초반의 과제들에서는 꽤 많은 클래스를 만들어야 했다. 그래봤자 5-6개 정도긴 했지만, 클래스간 상속을 적용하기 시작하니, 객체가 잘 동작하는지 알기 위해 매번 값을 출력해봐야하는 번거로움이 있었다. 그래서 오랜만에 객체 지향 패러다임의 세계로 돌아왔으니, 클래스마다 단위 테스트를 적용해보기로 했다.

## 테스트 환경 구축 시도

처음에는 CppUnit을 사용하려 했다. "xUnit" 형태의 이름을 가진 테스트 프레임워크인만큼 보편적으로 사용할 것 같았기 때문이다. 그런데 막상 자료를 찾아보니, 뭔가 IDE 레벨에서 설정해줘야 하는 부분이 많아 보였고, 어떻게 해야 손쉽게 프로젝트에 테스트를 붙일 수 있는지 파악하기 어려웠다. Boost 라는 프레임워크도 많이 사용하는 것 같았으나, 42서울 C++ 모듈 과제에서는 Boost를 사용해선 안 된다고 서브젝트 문서에 나와 있었다. 물론 테스트에 사용하는 걸 금지하는 건 아니었지만, 그래도 괜히 그렇게 써 있으니 지금 단계에서 Boost를 학습해보고 싶지 않았다. 그래서 여러 시도를 해보다 실패한 후, 테스트 적용을 포기했다.

다음 날, 다른 동료에게 어제 시도해본 테스트 프레임워크와 적용 실패담을 공유했다. 동료는 내 얘기를 듣고는 어쨌든 좋은 시도였고, 앞으로 과제를 수행하는 데에도 필요할 수 있겠다고 말했다. 그리고는 직접 검색을 해보더니 Bazel과 GoogleTest를 조합한 테스트가 괜찮아 보인다며 한번 해보고 나에게도 공유해주겠다고 말했다. 며칠 뒤, 그 동료가 Bazel과 GoogleTest를 이용한 간단한 테스트 예제를 담은 깃헙 비공개 저장소를 공유해줬다.

## 첫 테스트 환경 구축 성공

"이게 된다고...?"하는 마음으로 작업실에 도착하자마자 시도해봤다. Bazel과 GoogleTest를 설치하고, 실행해보니, 잘 됐다. 드디어 내가 쓸 수 있는 테스트 환경을 구축할 수 있게 된 것이다. 이 행복한 이야기의 결말부터 먼저 이야기하자면, 코로나로 인해 임시적으로 운영했던 원격 동료평가가 본격적으로 오프라인 동료평가로 변경되면서, 좀더 서둘러 과제를 끝내야만 했다. 그래서 모듈의 딱 한 문제의, 하나의 클래스에만 단위테스트를 작성해볼 수 있었다.

그래도 테스트 환경을 구성하고, 적용까지 해볼 수 있었다는 게 너무 즐거웠다. 모듈을 모두 마친 지금 시점에서(물론 아직 두 개의 모듈에 대한 평가를 마쳐야 하는 상황이긴 하지만), 어떻게 환경을 구성했는가에 대해, 그리고 아주 기본적인 사용법에 대해 기록을 해두고자 한다.

## Bazel 설치

MacOS에서 Homebrew를 사용하고 있다면 Bazel과 GoogleTest를 Homebrew로 설치할 수 있다. 환경이 다르다면 아래 사이트에서 설치방법을 찾아 설치하면 된다.

- Bazel: [https://bazel.build](https://bazel.build)
- GoogleTest: [https://google.github.io/googletest/](https://google.github.io/googletest/)

설치 후, `bazel --version` 명령어로 설치가 잘 됐는지 확인했다.

```sh
paikwiki$ bazel --version
bazel 4.0.0-homebrew
```

GoogleTest는 터미널 명령어가 없으므로 `brew list googletest` 명령으로 설치여부를 확인할 수 있다.

```sh
$ brew list googletest
/usr/local/Cellar/googletest/1.10.0/include/gmock/ (23 files)
/usr/local/Cellar/googletest/1.10.0/include/googlemock/ (7 files)
/usr/local/Cellar/googletest/1.10.0/include/googletest/ (11 files)
/usr/local/Cellar/googletest/1.10.0/include/gtest/ (24 files)
/usr/local/Cellar/googletest/1.10.0/lib/cmake/ (4 files)
/usr/local/Cellar/googletest/1.10.0/lib/pkgconfig/ (4 files)
/usr/local/Cellar/googletest/1.10.0/lib/ (4 files)
```

## 테스트용 소스코드 준비

먼저 아래처럼 `srcs/` 폴더에 `Greeting` 클래스를 위한, `Greeting.hpp`, `Greeting.cpp` 파일을 만든다. 이 파일에는 우선 뼈대가 되는 코드들만 작성한다.

```txt
root/
└── srcs/
    ├── Greeting.hpp
    └── Greeting.cpp
```

```cpp
// Greeting.hpp
#ifndef GREETING_H
#define GREETING_H

#include <iostream>

using namespace std;

class Greeting {
 public:
  Greeting();
  Greeting(Greeting const &greeting);

  ~Greeting();

  Greeting &operator=(Greeting const &rhs);
};

ostream &operator<<(ostream &out, Greeting const &rhs);

#endif
```

```cpp
// Greeting.cpp

#include "Greeting.hpp"

Greeting::Greeting() {}
Greeting::Greeting(Greeting const &greeting) {}

Greeting::~Greeting() {}

Greeting &Greeting::operator=(Greeting const &rhs) {}

ostream &operator<<(ostream &out, Greeting const &rhs) {}
```

그럼 이제 테스트 코드를 작성하기 전에, Bazel을 위한 설정을 해보겠다.

## Bazel 빌드 설정하기

먼저 프로젝트의 루트 디렉토리에 `WORKSPACE`라는 이름의 파일을 생성한 후 아래처럼 작성한다.

```sh
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
  name = "googletest",
  remote = "https://github.com/google/googletest",
  tag = "release-1.10.0",
)
```

무슨 언어인지 궁금해서 찾아보니 Starlark라는 언어로, Bazel의 빌드 시스템을 위해 고안한 설정파일 언어라고 한다. 더 알고 싶다면 [Starlark 깃헙 저장소](https://github.com/bazelbuild/starlark/)를 참고하기로 하고 넘어간다.

`git.bzl` 파일로부터 `git_repository`라는 심볼을 불러오고, 그 불러온 심볼을 이용해 테스트에 사용할 의존성 정보를 작성해주는 코드이다. `git_repository` 심볼은 첫 라인의 `load(...)`로부터 가져오는 과정이 필요하다. 이와 관련한 내용은 [Bazel의 공식 문서 중 "Workspace Rules#git_repository"](https://docs.bazel.build/versions/0.19.1/be/workspace.html#git_repository) 참고.

이 `WORKSPACE` 파일은 Bazel에게 프로젝트의 루트 디렉토리를 알려주는 파일이기도 하므로, 빈 파일로라도 생성해둬야 한다.

다음으로 `./srcs/BUILD` 파일을 생성하고 아래처럼 작성한다.

```sh
# ./srcs/BUILD

cc_library(
  name = "greeting",
  srcs = ["Greeting.cpp"],
  hdrs = ["Greeting.hpp"],
  visibility = ["//visibility:public"]
)
```

이 설정파일은 크게 설명할 내용이 없다. 만약 폴더 내의 모든 `.cpp`파일을 포함하려면 `srcs = glob(["**/*.cc"]),` 이런 식으로 작성할 수 있다. 여기까지 하면 프로젝트의 폴더 및 파일의 구조는 아래처럼 된다.

```txt
root/
├── WORKSPACE
└── srcs/
    ├── BUILD
    ├── Greeting.hpp
    └── Greeting.cpp
```

여기까지 하면, Bazel을 이용해 프로젝트 빌드가 가능하다. 지금 이 상태에서 빌드를 한다한들 무엇을 할 수 있는지는 모르겠으나, 일단 빌드를 해보자.

```sh
$ bazel build //srcs:greeting
INFO: Analyzed target //srcs:greeting (16 packages loaded, 134 targets configured).
INFO: Found 1 target...
INFO: From Compiling srcs/Greeting.cpp:
srcs/Greeting.cpp:8:53: warning: non-void function does not return a value [-Wreturn-type]
Greeting &Greeting::operator=(Greeting const &rhs) {}
                                                    ^
srcs/Greeting.cpp:10:57: warning: non-void function does not return a value [-Wreturn-type]
ostream &operator<<(ostream &out, Greeting const &rhs) {}
                                                        ^
2 warnings generated.
Target //srcs:greeting up-to-date:
  bazel-bin/srcs/libgreeting.a
  bazel-bin/srcs/libgreeting.so
INFO: Elapsed time: 39.418s, Critical Path: 2.14s
INFO: 6 processes: 3 internal, 3 darwin-sandbox.
INFO: Build completed successfully, 6 total actions
```

두 개의 오류를 만났다. void 함수가 아닌데 반환값이 없어서 생긴 오류이므로, `./srcs/Greeting.cpp` 파일을 열어 수정해보기로 하자. 단, 빌드가 될만큼만, 최소한으로 수정을 해두겠다.

```cpp
// Greeting.cpp

#include "Greeting.hpp"

Greeting::Greeting() {}
Greeting::Greeting(Greeting const &greeting) {}

Greeting::~Greeting() {}

Greeting &Greeting::operator=(Greeting const &rhs) { return (*this); }
//                                                   ^
ostream &operator<<(ostream &out, Greeting const &rhs) { return (out); }
//                                                       ^
```

주석으로 `^` 표시해둔 부분에 리턴 값을 추가했다.

다시 한번 빌드를 시도해보면 빌드가 되는 것을 확인할 수 있다.

```sh
$ bazel build //srcs:greeting
INFO: Analyzed target //srcs:greeting (0 packages loaded, 0 targets configured).
INFO: Found 1 target...
Target //srcs:greeting up-to-date:
  bazel-bin/srcs/libgreeting.a
  bazel-bin/srcs/libgreeting.so
INFO: Elapsed time: 0.983s, Critical Path: 0.78s
INFO: 4 processes: 1 internal, 3 darwin-sandbox.
INFO: Build completed successfully, 4 total actions
```

빌드 세팅이 됐으니 이제 본격적으로 테스트를 작성해보자. 참, 빌드에 성공하면 프로젝트 루트 디렉토리에 `bazel-*` 형태의 이름을 가진 폴더가 4개 생성된다. 이 폴더들은 일단 신경쓰지 말고 넘어가기로 한다.

## 테스트 작성하기

`./tests` 폴더를 만들고 폴더 안에 `BUILD`와 `Greeting_test.cpp` 파일을 생성한다.

```sh
# ./tests/BUILD

cc_test(
  name = "greeting_test",
  srcs = ["Greeting_test.cpp"],
  deps = [
    "//srcs:greeting",
    "@googletest//:gtest_main"
  ]
)
```

`deps`의 마지막 라인에 의해 앞서 `WORKSPACE`에 선언한 `googletest` 깃헙 저장소로부터 `gtest_main`을 가져온다. `Greeting_test.cpp`도 마저 작성한다.

```cpp
// ./tests/Greeting_test.cpp

#include "../srcs/Greeting.hpp"
#include "gtest/gtest.h"

TEST(GreetingShould, ReturnHi)
{
  Greeting greeting;
  std::string actual = greeting.sayHi();
  std::string expected = "Hi";
  EXPECT_EQ(expected, actual);
}
```

`Greeting`은 아직 `sayHi()` 멤버 함수가 없으나, 일단 기대하는 바를 테스트로 작성한 후 테스트를 실행해보자.

```sh
$ bazel test tests:greeting_test
DEBUG: Rule 'googletest' indicated that a canonical reproducible form can be obtained by modifying arguments commit = "703bd9caab50b139428cea1aaff9974ebee5742e", shallow_since = "1570114335 -0400" and dropping ["tag"]
DEBUG: Repository googletest instantiated at:
  /Users/paikwiki/codes/bazel-googletest-sample/WORKSPACE:3:15: in <toplevel>
Repository rule git_repository defined at:
  /private/var/tmp/_bazel_paikwiki/cf8fc9229dc6622457ae441290c1c15f/external/bazel_tools/tools/build_defs/repo/git.bzl:199:33: in <toplevel>
INFO: Analyzed target //tests:greeting_test (1 packages loaded, 2 targets configured).
INFO: Found 1 test target...
ERROR: /Users/paikwiki/codes/bazel-googletest-sample/tests/BUILD:3:8: Compiling tests/Greeting_test.cpp failed: (Exit 1): wrapped_clang failed: error executing command external/local_config_cc/wrapped_clang '-D_FORTIFY_SOURCE=1' -fstack-protector -fcolor-diagnostics -Wall -Wthread-safety -Wself-assign -fno-omit-frame-pointer -O0 -DDEBUG '-std=c++11' ... (remaining 47 argument(s) skipped)

Use --sandbox_debug to see verbose messages from the sandbox wrapped_clang failed: error executing command external/local_config_cc/wrapped_clang '-D_FORTIFY_SOURCE=1' -fstack-protector -fcolor-diagnostics -Wall -Wthread-safety -Wself-assign -fno-omit-frame-pointer -O0 -DDEBUG '-std=c++11' ... (remaining 47 argument(s) skipped)

Use --sandbox_debug to see verbose messages from the sandbox
tests/Greeting_test.cpp:7:33: error: no member named 'sayHi' in 'Greeting'
  std::string actual = greeting.sayHi();
                       ~~~~~~~~ ^
1 error generated.
Target //tests:greeting_test failed to build
Use --verbose_failures to see the command lines of failed build steps.
INFO: Elapsed time: 1.346s, Critical Path: 1.17s
INFO: 5 processes: 5 internal.
FAILED: Build did NOT complete successfully
//tests:greeting_test                                           FAILED TO BUILD

FAILED: Build did NOT complete successfully
```

예상한대로 `sayHi()` 멤버 함수가 없어서 오류가 난 것을 볼 수 있다.

```sh
tests/Greeting_test.cpp:7:33: error: no member named 'sayHi' in 'Greeting'
  std::string actual = greeting.sayHi();
                       ~~~~~~~~ ^
1 error generated.
```

그럼 `./srcs/Greeting.cpp`과 헤더 파일을 열어 오류를 없앨 수 있을만큼의, 최소한의 수정을 해본다.

```cpp
// ./srcs/Greeting.hpp

#ifndef GREETING_H
#define GREETING_H

#include <iostream>

using namespace std;

class Greeting {
 public:
  Greeting();
  Greeting(Greeting const &greeting);

  ~Greeting();

  Greeting &operator=(Greeting const &rhs);

  std::string sayHi(void) const;
};

ostream &operator<<(ostream &out, Greeting const &rhs);

#endif
```

`Greeting.cpp`도 아래처럼 수정해준다.

```cpp
// ./srcs/Greeting.cpp

#include "Greeting.hpp"

Greeting::Greeting() {}
Greeting::Greeting(Greeting const &greeting) {}

Greeting::~Greeting() {}

Greeting &Greeting::operator=(Greeting const &rhs) { return (*this); }

std::string Greeting::sayHi() const { return (std::string("Hi")); }

ostream &operator<<(ostream &out, Greeting const &rhs) { return (out); }
```

다시 한번 `bazel test tests:greeting_test`로 테스트를 실행해보자.

```sh
$ bazel test tests:greeting_test
DEBUG: Rule 'googletest' indicated that a canonical reproducible form can be obtained by modifying arguments commit = "703bd9caab50b139428cea1aaff9974ebee5742e", shallow_since = "1570114335 -0400" and dropping ["tag"]
DEBUG: Repository googletest instantiated at:
  /Users/paikwiki/codes/bazel-googletest-sample/WORKSPACE:3:15: in <toplevel>
Repository rule git_repository defined at:
  /private/var/tmp/_bazel_paikwiki/cf8fc9229dc6622457ae441290c1c15f/external/bazel_tools/tools/build_defs/repo/git.bzl:199:33: in <toplevel>
INFO: Analyzed target //tests:greeting_test (0 packages loaded, 0 targets configured).
INFO: Found 1 test target...
Target //tests:greeting_test up-to-date:
  bazel-bin/tests/greeting_test
INFO: Elapsed time: 0.609s, Critical Path: 0.50s
INFO: 2 processes: 1 internal, 1 darwin-sandbox.
INFO: Build completed successfully, 2 total actions
//tests:greeting_test                                           (cached) PASSED in 0.7s

Executed 0 out of 1 test: 1 test passes.
There were tests whose specified size is too big. Use the --test_verbose_timeout_warnings command linINFO: Build completed successfully, 2 total actions
```

테스트를 통과했다. 테스트와 관련한 로그는 `./bazel-testlogs` 폴더에 저장된다. `./bazel-testlogs/test.log`를 열어보면 아래처럼 테스트에 대한 로그가 남아있다.

```sh
exec ${PAGER:-/usr/bin/less} "$0" || exit 1
Executing tests from //tests:greeting_test
-----------------------------------------------------------------------------
Running main() from gmock_main.cc
[==========] Running 1 test from 1 test suite.
[----------] Global test environment set-up.
[----------] 1 test from GreetingShould
[ RUN      ] GreetingShould.ReturnHi
[       OK ] GreetingShould.ReturnHi (0 ms)
[----------] 1 test from GreetingShould (0 ms total)

[----------] Global test environment tear-down
[==========] 1 test from 1 test suite ran. (0 ms total)
[  PASSED  ] 1 test.
```

자, 그럼 이제 녹색불이 켜졌으니 `Greeting` 클래스를 리팩토링해보자. 다음 토픽으로 넘어가기 전에, 현재의 폴더 및 파일 구조를 살펴보면 아래와 같다.

```txt
root/
├── WORKSPACE
├── srcs/
│   ├── BUILD
│   ├── Greeting.hpp
│   └── Greeting.cpp
└── tests/
    ├── BUILD
    └── Greeting_test.cpp
```

## `Greeting` 리팩토링

아직은 별다른 기능이 없어 리팩토링할 부분도 크게 없는 듯 하다. "Hi"를 `Greeting`의 멤버 변수로 변경해봤다.

```cpp
// ./srcs/Greeting.hpp
#ifndef GREETING_H
#define GREETING_H

#include <iostream>

using namespace std;

class Greeting {
 private:
  static string const greetingMessage;

 public:
  Greeting();
  Greeting(Greeting const &greeting);

  ~Greeting();

  Greeting &operator=(Greeting const &rhs);

  std::string sayHi(void) const;
};

ostream &operator<<(ostream &out, Greeting const &rhs);

#endif
```

```cpp
// ./srcs/Greeting.cpp
#include "Greeting.hpp"

Greeting::Greeting() {}
Greeting::Greeting(Greeting const &greeting) {}

Greeting::~Greeting() {}

Greeting &Greeting::operator=(Greeting const &rhs) { return (*this); }

string const Greeting::greetingMessage = "Hi";

std::string Greeting::sayHi() const {
  return (this->greetingMessage);
}

ostream &operator<<(ostream &out, Greeting const &rhs) { return (out); }
```

다시 테스트를 돌려보고 이상없이 통과하는 걸 확인했다. 이로써 간단한 리팩토링 작업 끝.

## 나가며

글을 써야겠다고 다짐했을 때는 TDD 사이클에 맞춰 3-4번 정도 소스코드를 업데이트 해보겠다는 마음이었는데 막상 쓰다보니, 세팅 방법에 대한 정리로는 이 정도로 충분하다 싶어 글을 마무리하기로 했다. 아직 테스트 코드 작성에 익숙하지 않다보니 테스트 코드와 함께 소스코드를 작성한다는 게 부담스럽긴 하지만, 앞으로 몇몇 클래스만이라도 테스트를 적용해보려 한다.

끝으로 몇 번의 환경구축 실패를 겪으며 나중에 다시 해보자 마음먹고 포기하려 할 때, 좋은 자료를 전달해준 sucho A.K.A. Philanthropist(@42Seoul)님께 고맙다는 말씀을 전한다.

포스트에서 작성한 코드는 깃헙 저장소, [paikwiki/bazel-googletest-sample](https://github.com/paikwiki/bazel-googletest-sample)에서 확인할 수 있다.

---

삽입연산자 오버로딩을 제대로 구현하지 않고 끝냈다는 걸 뒤늦게 깨달았다. 이왕 이렇게 된 거, Bazel+GoogleTest 맛보기용으로 남겨둔다.

## 참고자료

- [Bazel & Google Test in Visual Studio Code](https://www.youtube.com/watch?v=0wMNtl2xDT0)
- [GoogleTest](https://google.github.io/googletest/)
- [Bazel](https://www.bazel.build)
