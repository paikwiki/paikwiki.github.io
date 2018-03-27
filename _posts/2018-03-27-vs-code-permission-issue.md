---
layout: post
title: 권한 문제로 인한 비주얼 스튜디오 코드(VS Code) 업데이트 오류 해결하기
date: 2018-03-27
---

며칠 전부터 비주얼 스튜디오 코드(Visual Studio Code)의 "소스 제어", 즉 깃(Git)과 관련한 기능이 이상하게 작동했다. 터미널에서 커밋을 한 후, 에디터로 돌아와 보면 이미 스테이징 처리한 파일이 여전히 수정된(`modified`) 파일로 남아있고, 새로고침을 아무리 해도 변화가 없었다. 귀찮아서 며칠 그냥 뒀는데, 오늘 VS코드 업데이트에서도 에러가 발생하는 것을 발견했다.

> Could not create temporary directory: 권한 거부됨

이대로 계속 두는 게 좋지 않을 것 같아 구글링을 시작했다. 에러 메시지에서 밝힌 것처럼 권한 설정의 문제일 거로 생각하고 검색을 했다. 여러 웹페이지 중 "[I am unable to update to the latest version of Atom on macOS. How do I fix this?](https://discuss.atom.io/t/i-am-unable-to-update-to-the-latest-version-of-atom-on-macos-how-do-i-fix-this/40054)"라는 글에서 힌트를 찾았다. 아톰(Atom의) 오류에 대한 질문이지만 비슷한 상황이었다. 답변에는 세 가지 파일에 대한 권한을 확인하라고 했다.

- `/Applications/Atom.app/`
- `~/Library/Caches/com.github.atom.ShipIt`
- `~/Library/Application Support/com.github.atom.ShipIt`

첫 번째는 어플리케이션, 두 번째는 아톰 업데이트 관련 캐시, 마지막은 아톰 업데이트 지원용 리소스였다. 나의 경우에는 캐시 파일은 없었고, 업데이트를 위한 리소스의 접근 권한이 `root`로 설정돼 있었다.

```sh
$ stat -f "%Su" ~/Library/Caches/com.microsoft.VSCode.ShipIt/
root
```

권한을 변경했다.

```sh
sudo chown -R chPaik ~/Library/Caches/com.microsoft.VSCode.ShipIt/
```

이렇게 한 후, 앱을 다시 시작했다. 앱이 열리자마자 깃에 대한 제어 설정 확인창이 떴다. 업데이트 확인을 통해 `1.21.1` 버전으로 업데이트도 완료했다.

오류 메시지가 발생했을 때, 이를 무시하면 큰 낭패를 면치 못한다는 이야기가 있다. 현관 디지털도어락이 전자음으로 "따르릉따르릉 비켜나세요~"를 외칠 때, 배터리 교체를 차일피일 미루다가는 곧 도어락 버튼을 아무리 눌러도 반응이 없는 날이 온다. 결국, 사람을 불러 처리해야 하는 상황이 벌어지는 것이다. 오류를 만났다면, 지금 크게 불편하지 않더라도 절대 그냥 넘어가지 말자.

아래는 오늘 새롭게 알게 된 쉘 명령어 정리.

- `stat -f "%Su" {target}`: 디렉토리나 파일의 소유자 이름을 확인
- `sudo chown -R {username} {target}`: 디렉토리나 파일의 소유자를 변경

끝으로 `ShipIt`의 정체를 알기 위해 찾아봤던 레딧(Reddit)의 링크도 남겨둔다.

- [On a Mac, what is ~/Library/Application Support/com.github.Github.ShipIt/ShipIt_stderr.log?](https://www.reddit.com/r/github/comments/6mqehi/on_a_mac_what_is_libraryapplication/)