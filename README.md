# macOS에서 Emacs로 클로저 개발하기

macOS에서 Emacs로 클로저 개발하기 위한 기본 준비 과정입니다. 아직 부족한 내용으로 정리되어 있지만
읽으시는 분들의 의견을 듣고 점점 필요한 자료를 보강해나갈 계획입니다.

따라해보시다가 잘 안되는 것이나 틀린것 궁금한 점이 있으면 이슈에 남겨주세요. :)

## 이 문서에서 표기법

Emacs는 보통 누르는 키를 아래 처럼 표시합니다.

```
C-x
```

라고 표시된 것은 `컨트롤`키와 `x`키를 함께 누르라는 표시입니다.

```
M-x
```

라고 표시된 것은 `메타`키(macOS에서는 주로 option/alt 키)와 `x`키를 함께 누르라는 표시입니다.

```
C-x f
```

라고 표시된 것은 `컨트롤`키와 `x`키를 누른 다음에(손을 때고) `f`키를 누르라는 표시 입니다.

```
C-x C-f
```

라고 표시된 것은 `컨트롤`키와 `x`키를 누른 다음(손을 때고) `컨트롤`키와 `f`키를 누르라는 표시입니다.

```
M-x package-list-packages
```

라고 표시된 것은 `M-x`를 입력하고 나면 그 옆에 명령어를 입력할 수 있는데 옆에 `package-list-packages`를
입력하고 엔터를 치라는 표시입니다.

## Emacs 준비하기

### Emacs 설치하기

여러가지 버전이 있지만 간단히 [Homebrew](https://brew.sh/)로 설치합니다. 더 다양한 설치 방법은
[Emacs Wiki](https://www.emacswiki.org/emacs/EmacsForMacOS)를 읽어보세요.

```
brew install --with-cocoa --srgb emacs
```

### 파일 열어보기

```bash
$ touch hello

$ emacs hello
```

하다가 뭔가 잘 안되면 `C-g`를 누르면 입력한 것이 취소됩니다. `C-g`를 막 누르고 다시 해봅니다.

### 글 써보기

그냥 쓰면 됩니다.

### 실행 취소/되돌리기

실행 취소 하려면,

```
C-/
```

다시 되돌리려면

```
C-g
```

누르고 다시

```
C-/
```

### 저장하기

```
C-x C-s
```

### 창을 세로로 분할 하기

```
C-x 3
```

### 창 간에 이동하기

```
C-x o
```

### 커서가 있는 창 닫기

```
C-x 0
```

### 종료 해보기

```
C-x C-c
```

## 패키지 관리

Emacs는 다양한 공개 패키지가 있고 처음에는 이 패키지를 잘 설치해서 사용하면 불편함 없이 개발 환경을
만들 수 있습니다. Emacs 패키지는 설치하면 그냥 사용할 수 있는 `package.el`에 들어 있는 함수들로
관리할 수 있습니다. 어떤 패키지가 있는지 다음 명령어를 실행해 봅시다.

아래 키를 누릅니다.

```
M-x
```

그러면 Emacs 가장 아래 미니 버퍼라고 부르는 영역에 명령어를 입력할 수 있습니다.

```
M-x package-list-packages
```

설치할 수 있는 패키지들이 보입니다. 이 패키지는 [Elpa](https://elpa.gnu.org/)라는 아카이브에
있는 패키지 입니다. 보시면 패키지가 생각보다 많이 없는데 보통 공개 패키지들이 [MELPA](https://melpa.org/)나
다른 아카이브에 공개되기 때문입니다. 나중에 `MELPA` 아카이브를 추가해서 패키지를 설치할 겁니다.

이 화면에서 패키지를 설치할 수 도 있지만 관리하기 불편하기 때문에 보통 Emacs 사용자들은 설정 파일로
패키지를 관리합니다.

### 설정 파일

Emacs 설정 파일은 주로 `~/.emacs.d/init.el`을 사용합니다. 없으면 새로 만듭니다.

```bash
$ touch ~/.emacs.d/init.el
```

Emacs로 빈 설정파일을 열어 하나씩 추가해봅시다.

```bash
$ emacs ~/.emacs.d/init.el
```

### MELPA 아카이브 추가하기

설정 파일은 `elisp`이라는 언어로 작성합니다.

먼저 다양한 패키지를 사용하기 위해 `MELPA` 아카이브를 추가합니다.

```elisp
(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
```

그리고 시작할 때 패키지를 초기화하고 아카이브에 최신 목록을 업데이트 해주기 위해서 다음 줄에 아래 코드를
추가합니다.

```elisp
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
```

### use-package 패키지 설치하기

전에는 패키지 설치하고 설정하는 것을 한땀 한땀 코드로 작성해줘야 했는데 요즘은 `use-package`라는 패키지로
설정 파일을 더 간력하게 유지할 수 있게 되었습니다. 그래서 패키지를 관리할 때 `use-package`를 쓰겠습니다.

`use-package` 패키지가 없으면 설치하는 코드를 작성해 줍니다.

```elisp
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
```

그리고 `use-package`를 쓰기위해 `require`를 해줍니다.

```elisp
(require 'use-package)
```

지금까지 만든 설정파일은 Emacs가 실행될 때 적용됩니다. Emacs를 다시 실행하는 것은 번거롭기 때문에
아래 명령어를 입력해서 지금 설정을 적용합니다.

```
M-x eval-buffer
```

인터넷이 잘 연결되어 있다면 미니 버퍼에 뭔가 설치하는 것 같은 메시지가 나오고 기다리면 `Done`으로
시작하는 메시지가 표시됩니다.

## 클로저 문법 강조하기

클로저 코드를 열었을 때 구문 강조(Syntax highlighting)를 하려면 `clojure-mode`라는 패키지를
설치하면 됩니다. 설정 파일(`~/.emacs.d/init.el`)을 열어 아래 처럼 설정 합니다.

```elisp
(use-package clojure-mode
  :ensure t)
```

이렇게 입력하고 `M-x eval-buffer`하면 `clojure-mode` 패키지가 설치됩니다. `clojure-mode`
패키지는 클로저 확장자 파일을 열었을 때 Majore Mode라고 부르는 Emacs 주 편집 환경 Clojure로 바꿔
줍니다. `Clojure` 모드에서는 클로저 코드가 구문 강조 되서 보이구요.

### 중첩된 괄호를 다른 색으로 표시하기

클로저 같은 Lisp 언어들은 괄호가 많이 중첩되기 때문에 중첩된 괄호를 구분된 색으로 보면 좋습니다. :)
이런 기능이 있는 `rainbow-delimiters`라는 패키지를 설치해 봅시다.

```elisp
(use-package rainbow-delimiters
  :ensure t
  :hook (clojure-mode . rainbow-delimiters-mode))
```

Emacs는 패키지간 실행 순서 같은 것을 보장하기 위해 `hook`이라는 것을 많이 사용하고 있습니다.
`use-package`의 `:hook`은 `hook`을 사용하기 쉽게 해주는 기능입니다. 위 코드에서는
`clojure-mode`에서 `rainbow-delimiters-mode`가 실행되도록 했습니다.

## 괄호의 짝을 맞춰라

많은 개발자 유머에서 Lisp의 괄호는 웃음 거리로 사용됩니다. 괄호가 많고 짝을 맞추는 것이 힘들기 때문입니다.
하지만 실제 Lisp 개발자들은 괄호로 고통을 느끼지 않습니다. ㅋㅋㅋ 이유는 대부분의 에디터에서 괄호를 잘
다루고 있기 때문입니다. 가장 많이 사용하고 있는 패키지는 `paredit` 패키지 입니다. 한번 설치해 봅시다.

```elisp
(use-package paredit
  :ensure t
  :hook (clojure-mode . paredit-mode))
```

역시 `clojure-mode`에서 `paredit-mode`를 사용하도록 `hook` 설정을 해줬습니다. 이제 클로저 코드를
열고 괄호를 입력하면 닫는 괄호가 저절로 생기고 괄호 안에 내용을 모두 지우면 여는 괄호와 닫는 괄호가 함께
지워집니다. 이렇게 하면 괄호가 짝이 맞지 않는 일은 생기지 않습니다. 그리고 상위 괄호와 하위 괄호간에 코드
이동도 쉽습니다. 자세한 사용법은 [Paredit Reference Card](http://pub.gajendra.net/src/paredit-refcard.pdf)를
보시면 됩니다.

## Cider와 함께하는 인터렉티브한 클로저 개발

[Cider](https://github.com/clojure-emacs/cider)는 Emacs 클로저 관련 패키지 중에 가장 유용하고
기능이 많이 있는 패키지 입니다. 주요한 기능으로는 `REPL`, `코드 자동 완성`, `정의된 곳으로 따라가기`,
`브레이크 포인트를 걸어 쓸 수 있는 디버깅`이 있습니다. 자세한 기능은 [Cider 공식 문서](http://docs.cider.mx/en/latest/)를
보시면 됩니다.

### 설치하기

설정 파일에 다음과 같이 적습니다.

```elisp
(use-package cider
  :ensure t)
```

### 실행하기

Cider는 Clojure Mode에서 실행할 수 있습니다. 한번 실행해 놓으면 계속 사용할 수 있습니다.
클로저 모드에서 다음 명령어를 입력합니다. (물론 단축키도 있습니다)

```
M-x cider-jack-in
```

### REPL 사용하기

실행하는데 시간이 좀 걸리는데 기다리면 창이 분할되고 `REPL`이 보입니다. `REPL`에서 코드를 실행해 볼
수 있지만 Clojure Mode에 있는 코드를 바로 `Evaluation` 할 수 있습니다.

`Evaluation` 할 구문 괄호의 가장 뒤에 가서 `C-c C-e` 하면 뒤에 결과가 표시됩니다.

화면에 있는 모든 코드를 `Evaluation` 하려면 `C-c C-k`를 하면 됩니다.

### 정의된 곳으로 가기

Var가 정의된 곳으로 이동하려면 Var 심볼 위에서 `M-.`을 치면 이동합니다. 다시 돌아오려면 `M-,`를 치면
됩니다.

### 코드 자동 완성

Cider에는 코드 자동 완성 기능도 있습니다. 기본 자동 완성은 미니 버퍼에 출력 되기 때문에 사용성이 떨어집니다.
Emacs에서 많이 사용하는 자동 완성 패키지인 `company`를 설치하면 커서 옆에 자동 완성 내용이 보이고 선택 할
수 있습니다.

```elisp
(use-package company
  :ensure t
  :config
  (global-company-mode))
```

`use-package`에 `:config`는 패키지가 로드된 후에 실행되는 곳으로 보통 패키지 설정을 합니다.
`global-company-mode` 설정으로 어느 모드에서도 `company`가 실행되도록 합니다. 물론 `hook`으로
Clojure Mode에서만 사용하도록 설정 할 수 있습니다.

`company` 패키지가 추가된 상태로 Cider를 실행하면 Clojure Mode에서 자동 완성을 사용할 수 있습니다.

### 디버깅

Cider는 함수나 구문에 브레이크 포인트를 걸어 디버깅 할 수 있습니다. Cider를 실행 한 상태로 다음과 같이
해봅시다.

`defn`으로 정의한 함수 안(괄호)에서 `M-x cider-debug-defun-at-point`라고 쳐 봅니다. 이렇게 하면
Var에 네모 박스가 표시됩니다.

`REPL`이나 브레이크 포인트가 걸려있는 Var를 사용하는 코드를 `Evaluation`해보면 디버그 모드가 실행되는
것을 볼 수 있습니다.

단계별로 심볼에 할당 된 값과 평가된 값을 볼 수 있습니다. 다음 단계로 넘어가려면 `n`을 누르고 마치려면 `q`를
누르면 됩니다.

브레이크 포인트를 지우려면 브레이크 포인트가 걸려있는 함수를 다시 `Evaluation`(`C-c C-e` 또는 `C-c C-k`)
해주면 됩니다.

### 더 많은 기능

Cider는 더 많은 기능이 있는데 [Cider 공식 문서](http://docs.cider.mx/en/latest/)를 보고
하나씩 해보면 좋습니다.

## 리팩토링

요즘 IDE는 리팩토링이라는 기능으로 코드를 쉽고 안전하게 변경할 수 있는 기능을 제공 합니다. Emacs에서
이런 기능을 하는 패키지는 [clj-refactor](https://github.com/clojure-emacs/clj-refactor.el)입니다.

역시 `use-package`로 `clj-refactor` 패키지를 설치해봅시다.

```elisp
(use-package clj-refactor
  :ensure t
  :hook (clojure-mode . clj-refactor-mode))
```

역시 Clojure Mode에서 동작하도록 `hook`을 설정했습니다. `clj-refactor`는 몇 몇 기능은
`yasnippet`이라고 하는Emacs 코드 템플릿 패키지를 사용하기 때문에 Clojure Mode에서 `yasnippet`을
사용하도록 설정해줘야 합니다.

```elisp
(use-package yasnippet
  :hook (clojure-mode . yas-minor-mode))
```

`yasnippet`은 기본 패키지이기 때문에 `:ensure`키를 안줘도 됩니다.

`clj-refactor`는 일부 기능은 `Cider`와 연동해서 사용하고 있기 때문에 `Cider`를 실행한 상태에서
사용해야 모든 기능을 쓸 수 있습니다.

`clj-refactor`의 모든 기능은 예제와 함께 [위키](https://github.com/clojure-emacs/clj-refactor.el/wiki)에
잘 정리되 어 있습니다. 한가지 예를 들면 만약 `require`가 되어 있지 않은 심볼을 사용하고 있다면 심볼 위에서
`M-x cljr-add-missing-libspec`을 치면 됩니다. (물론 단축키도 있습니다)

## 그 밖에

### 테마 바꿔 보기

저는 요즘 `sanityinc-tomorrow-day`라는 이맥스 테마를 사용하고 있습니다.

```elisp
(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :config
  (load-theme 'sanityinc-tomorrow-day t))
```

툴바, 스크롤바는 없애고 폰트는 `Monaco`로 사용하고 실행할 때 항상 윈도우는 최대화 되도록 사용합니다.

```elisp
(when (display-graphic-p)
  (progn
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    (set-frame-font "Monaco 14")
    (toggle-frame-maximized)))
```

시작 할 때 뜨는 화면 도 없애구요.

```elisp
(setq inhibit-startup-screen t)
```

### 줄, 컬럼 번호 표시하기

줄, 컬럼 번호는 항상 표시합니다.

```elsip
(global-linum-mode 1)
(setq linum-format "%3d ")

(setq column-number-mode t)
```

### yes/no 물어 보는 것을 y/n으로 입력 하도록 하기

자질구레 하지만 yes/no 입력도 귀찮아서 y/n으로 하구요.

```elisp
(fset 'yes-or-no-p 'y-or-n-p)
```

지금까지 나온 내용을 정리한 [init.el](./init.el)입니다.
