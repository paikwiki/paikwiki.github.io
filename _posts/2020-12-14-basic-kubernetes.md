---
layout: post
title: 쿠버네티스 기초 개념 정리
date: 2020-12-14
tags: [kubernetes]
---

학습을 목적으로, 쿠버네티스 공식문서를 기반으로 하여 작성한 글입니다. 일부 설명을 추가한 것 외에는 대부분의 내용은 한국어판 공식문서와 동일합니다.

- [개념 - 쿠버네티스 공식 문서(한국어판)](https://kubernetes.io/ko/docs/concepts/overview/)

## 쿠버네티스 컴포넌트

```text
┌┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┐     Kubernetes cluster
┊  ╭───╮      ╭───╮      ┊                             ╭───────╮
┊  │╭───╮     │╭───╮     ┊                           ╭─╯ Cloud ╰─╮
┊  ╰│╭───╮    ╰│╭───╮    ┊                          ╭╯  provider ╰╮
┊   ╰│ 1 │     ╰│ 2 │────┼─────────────────────────▶│     API     │
┊    ╰───╯      ╰───╯    ┊                          ╰─────────────╯
┊      ▲          ▲      ┊
┊      │          ┆      ┊
┊      │       ╭───╮     ┊
┊      ╰───────│╭───╮ ◀──┼────────────────────────────────╮
┊              ╰│╭───╮◀──┼──────────────────────╮         │
┊      ╭─────── ╰│ 3 │◀──┼────────────╮╭──────╮ │╭──────╮ │╭──────╮
┊      │         ╰───╯   ┊            ││ Node │ ││ Node │ ││ Node │
┊      │          ┆      ┊            ││ ╭───╮│ ││ ╭───╮│ ││ ╭───╮│
┊      ▼          ▼      ┊            ├┼─│ 6 ││ ├┼─│ 6 ││ ├┼─│ 6 ││
┊    ╭───╮     ╭───╮     ┊            ││ ╰───╯│ ││ ╰───╯│ ││ ╰───╯│
┊    │ 4 │     │╭───╮    ┊            ││ ╭───╮│ ││ ╭───╮│ ││ ╭───╮│
┊    ╰───╯     ╰│╭───╮   ┊            ╰┼─│ 7 ││ ╰┼─│ 7 ││ ╰┼─│ 7 ││
┊               ╰│ 5 │   ┊             │ ╰───╯│  │ ╰───╯│  │ ╰───╯│
┊                ╰───╯   ┊             ╰──────╯  ╰──────╯  ╰──────╯
┊      Control Plane     ┊
└┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┘
                1. Controller manager           5. Scheduler
                2. Cloud controller manager     6. kubelet
                3. API server                   7. kube-proxy
                4. etcd(persistence store)
```

쿠버네티스 클러스터 다이어그램 (원본출처: [쿠버네티스 공식 문서](https://kubernetes.io/ko/docs/concepts/overview/components/))

쿠버네티스 클러스터: 컨테이너화된 애플리케이션을 실행하는 "노드"라고 하는 워커 머신의 집합. 모든 클러스터는 최소 한 개의 워커 노드를 가진다.

### 컨트롤 플레인 컴포넌트

컨트롤 플레인 컴포넌트: 클러스터에 관한 전반적인 결정(예를 들어, 스케줄링)을 수행하고 클러스터 이벤트를 감지하고 반응한다.

#### kube-apiserver

API 서버: 쿠버네티스 API를 노출하는 쿠버네티스 컨트롤 플레인 컴포넌트. 쿠버네티스 컨트롤 플레인의 프론트엔드.

kube-apiserver는 수평으로 확장 가능한 디자인이므로, 더 많은 인스턴스를 배포해서 확장할 수 있다.

#### etcd

etcd: 모든 클러스터 데이터를 담는 쿠버네티스 뒷단의 저장소. 일관성 있는 고가용성의 키-값 저장소(Consistent and highly-available key value store).

#### kube-scheduler

kube-scheduler: 노드가 배정되지 않은 새로 생성된 파드를 감지하고, 실행할 노드를 선택하는 컨트롤 플레인 컴포넌트.

스케줄링 결정을 위해서 고려되는 요소

- 리소스에 대한 개별 및 총체적 요구 사항
- 하드웨어/소프트웨어/정책적 제약, 어피니티(affinity) 및 안티-어피니티(anti-affinity) 명세
- 데이터 지역성
- 워크로드-간 간섭
- 데드라인

#### kube-controller-mannager

kube-controller-manager: 컨트롤러를 구동하는 마스터 상의 컴포넌트. 논리적으로는 각 컨트롤러가 개별 프로세스이지만, 복잡성 감소를 위해 모두 단일 바이너리로 컴파일되고, 단일 프로세스 내에서 실행

컨트롤러의 요소

- 노드 컨트롤러: 노드가 다운됐을 때 통지와 대응에 관한 책임을 가짐
- 레플리케이션 컨트롤러: 시스템의 모든 레플리케이션 컨트롤러 오브젝트에 대해 알맞은 수의 파드를 유지시켜주는 책임
- 엔드포인트 컨트롤러: 엔드포인트 오브젝트를 채운다(즉, 서비스와 파드를 연결시킨다).
- 서비스 어카운트 & 토큰 컨트롤러: 새로운 네임스페이스에 대한 기본 계정과 API 접근 토큰을 생성한다.

#### cloud-controller-manager

cloud-controller-manager: 클라우드별 컨트롤 로직을 포함하는 쿠버네티스 컨트롤 플레인 컴포넌트.

- 클러스터를 클라우드 공급자의 API에 연결하고, "해당 클라우드 플랫폼과 상호 작용하는 컴포넌트"와 "클러스터와 상호작용하는 컴포넌트와 상호 작용하는 컴포넌트"를 분리할 수 있다.
- cloud-controller-manager는 클라우드 제공자 전용 컨트롤러만 실행. PC 내부의 학습 환경에서 쿠버네티스를 실행하는 경우, 클러스터에는 클라우드 컨트롤 매니저가 없다.
- kube-controller-manager와 마찬가지로 논리적으로 독립적인 여러 컨트롤 루프를 단일 프로세스로 실행하는 단일 바이너리로 결합한다.
- 수평으로 확장하여 성능을 향상시키거나 장애를 견딜 수 있다.

다음 컨트롤러들은 클라우드 제공 사업자의 의존성을 가질 수 있다(The following controllers can have cloud provider dependencies).

- 노드 컨트롤러: 노드가 응답을 멈춘 후 클라우드 상에서 삭제되었는지 판별하기 위해 클라우드 제공 사업자에게 확인하는 것
- 라우트 컨트롤러: 기본 클라우드 인프라에 경로를 구성하는 것
- 서비스 컨트롤러: 클라우드 제공 사업자 로드밸러서를 생성, 업데이트 그리고 삭제하는 것

### 노드 컴포넌트

- 동작중인 파드를 유지시킴
- 쿠버네티스 런타임 환경을 제공
- 모든 노드 상에서 동작

#### kubelet

kublet: 클러스터의 각 노드에서 실행되는 에이전트.

- 파드에서 컨테이너가 확실하게 동작하도록 관리
- Kubelet은 쿠버네티스를 통해 생성되지 않는 컨테이너는 관리하지 않는다.

#### kube-proxy

kube-proxy: 클러스터의 각 노드에서 실행되는 네트워크 프록시. 쿠버네티스 서비스 개념의 구현부

- 노드의 네트워크 규칙을 유지.관리. 이 네트워크 규칙이 내부 네트워크 세션이나 클러스터 바깥에서 파드로 네트워크 통신을 할 수 있도록 해준다.
- 운영 체제에 가용한 패킷 필터링 계층이 있는 경우 이를 사용하고 그렇지 않은 경우에는 트래픽 자체를 포워드(forward)한다.

#### 컨테이너 런타임

컨테이너 런타임: 컨테이너 실행을 담당하는 소프트웨어.

쿠버네티스가 지원하는 컨테이너 런타임

- 도커(Docker)
- containered
- CRI-O
- 그외 Kubernetes CRI(컨테이너 런타임 인터페이스)를 구현한 모든 소프트웨어

### 애드온

애드온: 쿠버네티스 리소스(데몬셋, 디플로이먼트 등)를 이용해 클러스터 기능울 구현

- 클러스터 단위의 기능을 제공(애드온에 대한 네임스페이스 리소스는 `kube-system` 네임스페이스에 속함

#### DNS

클러스터 DNS: 구성환경 내 다른 DNS 서버와 더불어, 쿠버네티스 서비스를 위해 DNS 레코드를 제공해주는 DNS 서버.

- 모든 쿠버네티스 클러스터는 클러스터 DNS를 갖춰야 한다.
- 쿠버네티스에 의해 구동되는 컨테이너는 DNS 검색에서 이 DNS 서버를 자동으로 포함한다.

#### 웹 UI(대시보드)

대시보드: 쿠버네티스 클러스터를 위한 범용의 웹 기반 UI.

#### 컨테이너 리소스 모니터링

컨테이너 리소스 모니터링: 중앙 데이터베이스 내의 컨테이너들에 대한 포괄적인 시계열 매트릭스를 기록하고, 그 데이터를 열람하기 위한 UI를 제공함

#### 클러스터-레벨 로깅

클러스터-레벨 로깅: 검색/열람 인터페이스와 함께 중앙 로그 저장소에 컨테이너 로그를 저장하는 책임을 지는 메커니즘

## 쿠버네티스 API

> 쿠버네티스 컨트롤 플레인의 핵심은 API 서버이다.

- API 서버는 최종 사용자, 클러스터의 다른 부분 그리고 외부 컴포넌트가 서로 통신할 수 있도록 HTTP API를 제공
- kubectl 커맨드라인 인터페이스 또는 API를 사용하는 kubeadm과 같은 커맨드라인 도구를 통해 작업 수행 가능
- REST 호출을 사용하여 API에 직접 접근할 수도 있음

### OpenAPI 명세

OpenAPI 규격은 `/openapi/v2` 엔드포인트에서만 제공

| Header | Possible values | Notes |
|-----|---|---|
| Accept-Encoding | `gzip` | not supplying this header is also acceptable |
| Accept | `application/com.github.proto-openapi.spec.v2@v1.0+protobuf` | mainly for intra-cluster use |
| | `application/json` | default |
| | `*` | serves `application/json` |

### API 관련

> 쿠버네티스 프로젝트는 기존 클라이언트와의 호환성을 깨지 않고 다른 프로젝트가 적응할 기회를 가질 수 있도록 장기간 해당 호환성을 유지하는 것을 목표로 한다.

쿠버네티스 API는 다음 두 가지 방법 중 하나로 확장

1. 커스텀 리소스를 사용하면 API 서버가 선택한 리소스 API를 제공하는 방법을 선언적으로 정의
1. 애그리게이션 레이어(aggregation layer)를 구현하여 쿠버네티스 API를 확장

## 쿠버네티스 오브젝트

> 쿠버네티스 오브젝트는 쿠버네티스 시스템에서 영속성을 가지는 개체이다.

쿠버네티스 오브젝트가 알려줄 수 있는 것

- 어떤 컨테이너화된 애플리케이션이 동작중인지, 그 애플리케이션이 어떤 노드에서 동작 중인지
- 그 애플리케이션이 이용할 수 있는 리소스
- 그 애플리케이션의 재구동, 업그레이드 방법, 내부 오류에 대한 동작 방법에 대한 정책

쿠버네티스 오브젝트

- 하나의 "의도를 담은 레코드"
- 오브젝트를 생성함으로써 클러스터의 워크로드를 어떤 형태로 보이고자 하는지에 대해 효과적으로 쿠버네티스 시스템에 전달할 수 있음

쿠버네티스 API

- 생성/수정/삭제 등 쿠버네티스 오브젝트를 동작시킬 때 이용
- `kubectl` 커맨드라인 인터페이스를 실행하면 쿠버네티스 API를 호출해준다.
- 클라이언트 라이브러리 중 하나를 이용해 프로그램에서 쿠버네티스 API를 직접 이용할 수도 있다.

### 오브젝트 명세(spec)와 상태(status)

`spec`과 `status`: 오브젝트의 구성을 결정해주는 두 개의 중첩된 오브젝트 필드

- `spec`: 오브젝트를 생성할 때 리소스에 원하는 특징("의도한 상태")에 대한 설명을 제공
- `status`: 쿠버네티스 시스템과 컴포넌트에 의해 제공되고 업데이트된 오브젝트의 "현재 상태"

> 만약, 인스턴스들 중 어느 하나가 어떤 문제로 인해 멈춘다면(상태 변화 발생), 쿠버네티스 시스템은 보정(이 경우에는 대체 인스턴스를 시작하여)을 통해 spec과 status간의 차이에 대응한다.

### 쿠버네티스 오브젝트 기술하기

쿠버네티스 API를 이용할 때, API 요청은 요청 내용 안에 JSON 형식으로 정보를 포함시켜야 한다. 대부분의 경우 정보를 .yaml 파일로 `kubectl`에 제공한다.

```yaml
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # tells deployment to run 2 pods matching the template
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
(예시코드 출처: [쿠버네티스 공식문서](https://kubernetes.io/ko/docs/concepts/overview/working-with-objects/kubernetes-objects/))

`kubectl` CLI로 .yaml 파일 사용하는 방법

```sh
$ kubectl apply -f https://k8s.io/examples/application/deployment.yaml --record
deployment.apps/nginx-deployment created
```

### .yaml 파일의 필수 필드

- `apiVersion`: 이 오브젝트를 생성하기 위해 사용하는 쿠버네티스 API 버전
- `kind`: 어떤 종류의 오브젝트를 생성하고자 하는지
- `metadata`: `이름` 문자열, `UID`, 그리고 선택적인 `네임스페이스`를 포함해 오브젝트를 특정할 수 있게 해주는 데이터
- `spec`: 오브젝트에 대해 어떤 상태를 의도하는지

참고 링크

- [Kubernetes API Reference](https://kubernetes.io/ko/docs/concepts/overview/working-with-objects/kubernetes-objects/)

## 쿠버네티스 오브젝트 관리

### 관리 기법

> 쿠버네티스 오브젝트는 하나의 기법만 사용해야 한다. 동일한 오브젝트에 대해 여러 기법을 혼용하면 예상치 못한 동작을 초래함

| 관리기법 | 대상 | 권장 환경 | 지원하는 작업자 수 | 학습 난이도 |
|--|--|--|--|--|
| 명령형 커맨드 | 활성 오브젝트 | 개발환경 | 1+ | 낮음 |
| 명령형 오브젝트 구성 | 개별 파일 | 프로덕션 환경 | 1 | 보통 |
| 선언형 오브젝트 구성 | 파일이 있는 디렉터리 | 프로덕션 환경 | 1+ | 높음 |

### 명령형 커맨드

실행할 작업을 인수 또는 플래그로 `kubectl` 커맨드에 지정한다.

- 일회성 작업을 개시하거나 동작시키기 위한 가장 단순한 방법
- 활성 오브젝트를 대상으로 직접적인 영향을 미치기 때문에, 이전 구성에 대한 이력을 제공해주지 않는다.

예시: 디플로이먼트 오브젝트를 생성해 nginx 컨테이너의 인스턴스를 구동하기

```sh
$ kubectl create deployment nginx --image nginx
```

#### 트레이드 오프

오브젝트 구성에 비해 장점

- 커맨드는 간단해서 배우기 쉽고, 기억하기 쉽다.
- 커맨드는 클러스터를 수정하기 위해 단 하나의 단계만을 필요로 한다.

오브젝트 구성에 비해 단점

- 커맨드는 변경 검토 프로세스와 통합되지 않는다.
- 커맨드는 변경에 관한 감사 추척(audit trail)을 제공하지 않는다.
- 커맨드는 활성 동작 중인 경우를 제외하고는 레코드의 소스를 제공하지 않는다.
- 커맨드는 새로운 오브젝트 생성을 위한 템플릿을 제공하지 않는다.

### 명령형 오브젝트 구성

`kubectl` 커맨드로 작업(생성, 교체 등), 선택적 플래그, 그리고 최소 하나의 파일 이름을 지정한다. 파일은 YAML 또는 JSON 형식으로 오브젝트의 완전한 정의를 포함해야만 한다.

참고

- [API Reference](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.19/)

예시: 구성 파일에 정의된 오브젝트 생성

```sh
$ kubectl create -f nginx.yaml
```

예시: 두 개의 구성 파일에 정의된 오브젝트를 삭제
```sh
$ kubectl delete -f nginx.yaml -f redis.yaml
```

예시: 활성 동작하는 구성을 덮어씀으로써 구성 파일에 정의된 오브젝트를 업데이트

```sh
$ kubectl replace -f nginx.yaml
```

#### 트레이드 오프

명령형 커맨드에 비해 장점

- 오브젝트 구성은 Git과 같은 소스 컨트롤 시스템에 보관할 수 있다.
- 오브젝트 구성은 푸시와 감사 추적 전에 변경사항을 검토하는 것과 같은 프로세스들과 통합할 수 있다.
- 오브젝트 구성은 새로운 오브젝트 생성을 위한 템플릿을 제공한다.

명령형 커맨드에 비해 단점

- 오브젝트 구성은 오브젝트 스키마에 대한 기본적인 이해를 필요로 한다.
- 오브젝트 구성은 YAML 파일을 기록하는 추가적인 과정을 필요로 한다.

선언형 오브젝트 구성에 비해 장점

- 명령형 오브젝트 구성의 동작은 보다 간결하고 이해하기 쉽다.
- 쿠버네티스 버전 1.5 부터는 더 나은 명령형 오브젝트 구성을 제공한다.

선언형 오브젝트 구성에 비해 단점

- 명령형 오브젝트 구성은 디렉터리가 아닌, 파일에 가장 적합하다.
- 활성 오브젝트에 대한 업데이트는 구성 파일에 반영되어야 한다. 그렇지 않으면 다음 교체 중에 손실된다.

### 선언형 오브젝트 구성

- 로컬에 보관된 오브젝트 구성 파일을 대상으로 작동시키지만, 파일에서 수행할 작업을 정의하지 않는다.
- 생성, 업데이트, 그리고 삭제 작업은 `kubectl`에 의해 오브젝트마다 자동으로 감지
- 다른 오브젝트에 대해 다른 조작이 필요할 수 있는 디렉터리에서 작업 가능

> 선언형 오브젝트 구성은 변경 사항이 오브젝트 구성 파일에 다시 병합되지 않더라도 다른 작성자가 작성한 변경 사항을 유지한다. 이것은 전체 오브젝트 구성 변경을 위한 replace API를 사용하는 대신, patch API를 사용하여 인지되는 차이만 작성하기 때문에 가능하다.

예시: `configs` 디렉터리 내 모든 오브젝트 구성 파일을 처리하고 활성 오브젝트를 생성 또는 패치(`diff`로 확인 후 적용)

```sh
kubectl diff -f configs/
kubectl apply -f configs/
```

예시: 재귀적으로 디렉터리 처리

```sh
kubectl diff -R -f configs/
kubectl apply -R -f configs/
```

#### 트레이드 오프

명령형 오브젝트 구성에 비해 장점

- 활성 오브젝트에 직접 작성된 변경 사항은 구성 파일로 다시 병합되지 않더라도 유지된다.
- 선언형 오브젝트 구성은 디렉터리에서의 작업 및 오브젝트 별 작업 유형(생성, 패치, 삭제)의 자동 감지에 더 나은 지원을 제공한다.

명령형 오브젝트 구성에 비해 단점

- 선언형 오브젝트 구성은 예상치 못한 결과를 디버깅하고 이해하기가 더 어렵다.
- diff를 사용한 부분 업데이트는 복잡한 병합 및 패치 작업을 일으킨다.

## 오브젝트 이름과 ID

> 클러스터의 각 오브젝트는 해당 유형의 리소스에 대하여 고유한 이름을 가지고 있다. 또한, 모든 쿠버네티스 오브젝트는 전체 클러스터에 걸쳐 고유한 UID 를 가지고 있다.

유일하지 않은 사용자 제공 속성의 경우 쿠버네티스는 레이블과 어노테이션을 제공한다.

### 이름

> /api/v1/pods/some-name과 같이, 리소스 URL에서 오브젝트를 가리키는 클라이언트 제공 문자열.

- 특정 시점의 같은 종류(kind) 내에서는 하나의 이름은 하나의 오브젝트에만 지정할 수 있다.
- 오브젝트를 삭제한 경우, 해당 이름을 새로운 오브젝트에 지정 가능하다.

리소스에 일반적으로 사용되는 세 가지 유형의 이름 제한 조건

- DNS 서브도메인 이름
- DNS 레이블 이름
- 경로 세그먼트 이름

#### DNS 서브도메인 이름

대부분의 리소스 유형은 DNS 서브 도메인 이름으로 사용할 수 있는 이름이 필요하다.

- 253자를 넘지 말아야 한다.
- 소문자와 영숫자 - 또는 . 만 포함한다.
- 영숫자로 시작한다.
- 영숫자로 끝난다.

#### DNS 레이블 이름

대부분의 리소스 유형은 DNS 레이블 표준을 따라야 한다.

- 최대 63자이다.
- 소문자와 영숫자 또는 - 만 포함한다.
- 영숫자로 시작한다.
- 영숫자로 끝난다.

#### 경로 세그먼트 이름

일부 리소스 유형에서는 이름을 경로 세그먼트로 안전하게 인코딩 할 수 있어야 한다.

파드의 이름이 nginx-demo라는 매니페스트 예시

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-demo
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

### UID

오브젝트를 중복 없이 식별하기 위해 쿠버네티스 시스템이 생성하는 문자열.

- 쿠버네티스 클러스터가 구동되는 전체 시간에 걸쳐 생성되는 모든 오브젝트는 서로 구분되는 UID 사용
- 쿠버네티스 UID는 보편적으로 고유한 식별자이다(또는 UUID라고 한다).

## 네임스페이스

네임스페이스: 동일한 물리 클러스터를 기반으로 하는 여러 가상 클러스터

- 많은 사용자가 있는 환경에서 사용하도록 만들어졌음. 사용자가 수 십명 정도라면 네임스페이스를 고려할 필요 없음
- 이름의 범위를 제공. 리소스의 이름은 네임스페이스 내에서만 유일하면 됨
- 네임스페이스는 서로 중첩될 수 없음
- 쿠버네티스 리소스는 각각 하나의 네임스페이스에만 있을 수 있음
- 클러스터 자원을(리소스 쿼터를 통해) 여러 사용자 사이에서 나누는 방법
- 동일한 네임스페이스 내에서 리소스를 구별할 때는 레이블을 사용함

### 네임스페이스 다루기

네임스페이스 조회

```
$ kubectl get namaspace
NAME              STATUS   AGE
default           Active   1d
kube-node-lease   Active   1d
kube-public       Active   1d
kube-system       Active   1d
```
쿠버네티스의 초기 네임스페이스

- `default` 다른 네임스페이스가 없는 오브젝트를 위한 기본 네임스페이스
- `kube-system` 쿠버네티스 시스템에서 생성한 오브젝트를 위한 네임스페이스
- `kube-public` 이 네임스페이스는 자동으로 생성되며 모든 사용자(인증되지 않은 사용자 포함)가 읽기 권한으로 접근할 수 있다. 이 네임스페이스는 주로 전체 클러스터 중에 공개적으로 드러나서 읽을 수 있는 리소스를 위해 예약되어 있다. 이 네임스페이스의 공개적인 성격은 단지 관례이지 요구 사항은 아니다.
- `kube-node-lease` 클러스터가 스케일링될 때 노드 하트비트의 성능을 향상시키는 각 노드와 관련된 리스(lease) 오브젝트에 대한 네임스페이스

요청에 네임스페이스 설정(`--namespace`)

```sh
$ kubectl run nginx --image=nginx --namespace=<insert-namespace-name-here>
$ kubectl get pods --namespace=<insert-namespace-name-here>
```

선호하는 네임스페이스 설정

```sh
$ kubectl config set-context --current --namespace=<insert-namespace-name-here>
# 확인하기
$ kubectl config view --minify | grep namespace:
```

### 네임스페이스와 DNS

서비스를 생성하면 해당 DNS 엔트리가 생성된다.

- 엔트리는 `<서비스-이름>.<네임스페이스-이름>.svc.cluster.local`의 형식
- <서비스-이름>만 사용하는 경우, 네임스페이스 내에 국한된 서비스로 연결됨
- 개발, 스테이징, 운영과 같이 여러 네임스페이스 내에서 동일한 설정을 사용하는 경우에 유용함
- 네임스페이스를 넘어서 접근하기 위해서는, 전체 주소 도메인 이름(FQDN)을 사용해야 함

모든 오브젝트가 네임스페이스에 속하지는 않음

- 대부분의 쿠버네티스 리소스(예를 들어, 파드, 서비스, 레플리케이션 컨트롤러 외)는 네임스페이스에 속함
- 하지만 네임스페이스 리소스 자체는 네임스페이스에 속하지 않는다.
- 노드나 퍼시스턴트 볼륨과 같은 저수준 리소스는 어느 네임스페이스에도 속하지 않는다.

네임스페이스에 속하지 않는 쿠버네티스 리소스를 조회

```sh
# 네임스페이스에 속하는 리소스
$ kubectl api-resources --namespaced=true

# 네임스페이스에 속하지 않는 리소스
$ kubectl api-resources --namespaced=false
```

### 레이블과 셀렉터

레이블: 파드와 같은 오브젝트에 첨부된 키와 값의 쌍

- 오브젝트의 특성을 식별하는 데 사용
- 사용자에게 중요하나, 코어 시스템에 직접적인 의미는 없음
- 오브젝트의 하위 집합을 선택하고, 구성하는데 사용
- 오브젝트를 생성할 때, 혹은 생성 이후에도 언제든 수정 가능
- 오브젝트마다 키와 값으로 레이블 정의. 키는 고유값

```json
"metadata": {
  "labels": {
    "key1" : "value1",
    "key2" : "value2"
  }
}
```

#### 사용 동기

- 레이블을 이용하면 사용자가 느슨하게 결합한 방식으로 조직 구조와 시스템 오브젝트를 매핑 가능
- 클라이언트에 매핑 정보를 저장할 필요가 없다.

레이블 예시

- "release" : "stable", "release" : "canary"
- "environment" : "dev", "environment" : "qa", "environment" : "production"
- "tier" : "frontend", "tier" : "backend", "tier" : "cache"
- "partition" : "customerA", "partition" : "customerB"
- "track" : "daily", "track" : "weekly"

#### 구문과 캐릭터 셋

- 유효한 레이블 키에는 슬래시(/)로 구분되는 선택한 접두사와 이름이라는 2개의 세그먼트가 있음
- 이름 세그먼트는 63자 미만으로 시작과 끝은 알파벳과 숫자([a-z0-9A-Z])이며, 대시(-), 밑줄(_), 점(.)과 함께 사용할 수 있다.
- 접두사는 선택이다. 만약 접두사를 지정한 경우 접두사는 DNS의 하위 도메인으로 해야 하며, 점(.)과 전체 253자 이하, 슬래시(/)로 구분되는 DNS 레이블이다.
- 접두가가 없으면 키 레이블은 개인용으로 간주
- `kubernetes.io/`와 `k8s.io/` 접두사는 쿠버네티스의 핵심 컴포넌트로 예약되어있다.

예시

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: label-demo
  labels:
    environment: production
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

#### 레이블 셀렉터

레이블 셀렉터

- 클라이언트와 사용자가 이를 통해 오브젝트를 식별
- 쿠버네티스 코어 그룹의 기본임
- 쉼표로 구분된 다양한 요구사항에 따라 만들 수 있음
- 다양한 요구 사항이 있는 경우, 쉼표 기호가 AND(`&&`) 연산자로 구분되는 역할을 하도록 해야함

API가 지원하는 두 종류의 셀렉터

- 일치성 기준
- 집합성 기준

> 주의: 일치성 기준과 집합성 기준 조건 모두에 대해 논리적인 OR (`||`) 연산자가 없다. 필터 구문이 적절히 구성되어있는지 확인해야 한다.

##### 일치성 기준 요건

- 일치하는 오브젝트는 추가 레이블을 가질 수 있지만, 레이블의 명시된 제약 조건을 모두 만족해야 한다.
- `=`,`==`,`!=` 3가지 연산자만 허용
- 처음 두 개의 연산자는 일치성(그리고 단순히 동의어일 뿐임), 나머지는 불일치를 의미

예시

```text
environment = production
tier != frontend
```

위의 예시는,

- `environment`를 키로 가지는 것과 `production`을 값으로 가지는 모든 리소스를 선택
- `tier`를 키로 가지고, 값을 `frontend`를 가지는 리소스를 제외한 모든 리소스를 선택하고,
- `tier`를 키로 가지며, 값을 공백으로 가지는 모든 리소스를 선택

쉼표를 이용해 `environment=production,tier!=frontend`처럼 표현 가능


"accelerator=nvidia-tesla-p100" 레이블을 가진 노드를 선택하는 예시

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: cuda-test
spec:
  containers:
    - name: cuda-test
      image: "k8s.gcr.io/cuda-vector-add:v0.1"
      resources:
        limits:
          nvidia.com/gpu: 1
  nodeSelector:
    accelerator: nvidia-tesla-p100
```

##### 집합성 기준 요건

- `in`,`notin`, `exists`(키 식별자만 해당)의 3개의 연산자를 지원

예시

```text
environment in (production, qa)
tier notin (frontend, backend)
partition
!partition
```

위 예시는,

- 키가 `environment`이고 값이 `production` 또는 `qa`인 모든 리소스를 선택한다.
- 키가 `tier`이고 값이 `frontend`와 `backend`를 가지는 리소스를 제외한 모든 리소스와,
- 키로 `tier`를 가지고 값을 공백으로 가지는 모든 리소스를 선택한다.
- 레이블의 값에 상관없이 키가 `partition`을 포함하는 모든 리소스를 선택한다.
- 레이블의 값에 상관없이 키가 `partition`을 포함하지 않는 모든 리소스를 선택한다.

`partition,environment notin (qa)`와 같이 사용하면 값과 상관없이 키가 `partition`인 것과 키가 `environment`이고 값이 `qa`가 아닌 리소스를 필터링할 수 있다.

집합성 기준 요건은 일치성 기준 요건과 조합해서 사용할 수 있다.

```text
partition in (customerA, customerB),environment!=qa
```

#### API

##### LIST와 WATCH 필터링

LIST와 WATCH 작업은 쿼리 파라미터를 사용해서 반환되는 오브젝트 집합을 필터링하기 위해 레이블 셀렉터를 지정할 수 있다.

- 불일치 기준 요건: `?labelSelector=environment%3Dproduction,tier%3Dfrontend`
- 집합성 기준 요건: `?labelSelector=environment+in+%28production%2Cqa%29%2Ctier+in+%28frontend%29`

두 가지 레이블 셀렉터 스타일은 모두 REST 클라이언트를 통해 선택된 리소스를 확인하거나 목록을 볼 수 있다.

kubectl로 apiserver를 대상으로 불일치 기준 으로 하는 셀렉터 예시

```sh
$ kubectl get pods -l environment=production,tier=frontend
```

집합성 기준 요건을 사용 예시

```sh
$ kubectl get pods -l 'environment in (production),tier in (frontend)'
```

OR 연산자 구현 예시

```sh
$ kubectl get pods -l 'environment in (production, qa)'
```

불일치 예시

```sh
kubectl get pods -l 'environment,environment notin (frontend)'
```

##### API 오브젝트에서 참조 설정

서비스와 레플리케이션 컨트롤러

`services` 와 `replicationcontrollers`와 같은 일부 쿠버네티스 오브젝트는 레이블 셀렉터를 사용해서 파드와 같은 다른 리소스 집합을 선택한다.

`json` 파일 예시

```json
"selector": {
    "component" : "redis",
}
```

`yaml` 파일 예시

```yaml
selector:
    component: redis
```

세트-기반 요건을 지원하는 리소스

`Job`, `Deployment`, `ReplicaSet` 그리고 `DaemonSet` 같은 새로운 리소스들은 집합성 기준의 요건(set-based requirements)도 지원한다.


예시
```yaml
selector:
  matchLabels:
    component: redis
  matchExpressions:
    - {key: tier, operator: In, values: [cache]}
    - {key: environment, operator: NotIn, values: [dev]}
```

위 예시는,

- `matchLabels`는 {key,value}의 쌍과 매칭
- `matchLabels`에 매칭된 단일 `{key,value}`는 `matchExpressions`의 요소와 같으며 `key` 필드는 "key"로, `operator`는 "In" 그리고 `values`에는 "value"만 나열
- `matchExpressions`는 파드 셀렉터의 요건 목록
- 파드 셀렉터의 요건 목록에서 유효한 연산자: `In`, `NotIn`, `Exists`, `DoNotExist`
- `In` 및 `NotIn`은 설정된 값이 있어야 한다.
- `matchLabels`와 `matchExpressions` 모두 AND로 되어있어 모든 요건을 만족하는 것을 선택한다.

노드 셋 선택

- 레이블을 통해 선택하는 사용 사례 중 하나는 파드를 스케줄 할 수 있는 노드 셋을 제한하는 것
- [노드 선택 문서](https://kubernetes.io/ko/docs/concepts/scheduling-eviction/assign-pod-node/)를 참고할 것.

## 어노테이션

쿠버네티스 어노테이션을 사용하여 임의의 비-식별 메타데이터를 오브젝트에 첨부할 수 있다.

### 오브젝트에 메타데이터 첨부

레이블과 어노테이션 비교

- 레이블을 사용하여 오브젝트를 선택하고, 특정 조건을 만족하는 오브젝트 컬렉션을 찾을 수 있다.
- 어노테이션은 오브젝트를 식별하고 선택하는데 사용되지 않는다.
- 어노테이션의 메타데이터는 작거나 크고, 구조적이거나 구조적이지 않을 수 있으며, 레이블에서 허용되지 않는 문자를 포함할 수 있다.

어노테이션 예시

```json
"metadata": {
  "annotations": {
    "key1" : "value1",
    "key2" : "value2"
  }
}
```

어노테이션에 기록할 수 있는 정보의 예시

- 필드는 선언적 구성 계층에 의해 관리된다. 이러한 필드를 어노테이션으로 첨부하는 것은 클라이언트 또는 서버가 설정한 기본 값, 자동 생성된 필드, 그리고 오토사이징 또는 오토스케일링 시스템에 의해 설정된 필드와 구분된다.
- 빌드, 릴리스, 또는 타임 스탬프, 릴리즈 ID, git 브랜치, PR 번호, 이미지 해시 및 레지스트리 주소와 같은 이미지 정보.
- 로깅, 모니터링, 분석 또는 감사 리포지터리에 대한 포인터.
- 디버깅 목적으로 사용될 수 있는 클라이언트 라이브러리 또는 도구 정보: 예를 들면, 이름, 버전, 그리고 빌드 정보.
- 다른 생태계 구성 요소의 관련 오브젝트 URL과 같은 사용자 또는 도구/시스템 출처 정보.
- 경량 롤아웃 도구 메타데이터. 예: 구성 또는 체크포인트
- 책임자의 전화번호 또는 호출기 번호, 또는 팀 웹 사이트 같은 해당 정보를 찾을 수 있는 디렉터리 진입점.
- 행동을 수정하거나 비표준 기능을 수행하기 위한 최종 사용자의 지시 사항.

### 문법과 캐릭터 셋

유효한 어노테이션 키

- 두 개의 세그먼트가 있음
- 두 개의 세그먼트는 선택적인 접두사와 이름(name)이며, 슬래시(/)로 구분
- 이름 세그먼트는 필수. 영문 숫자([a-z0-9A-Z])로 시작하고 끝나는 63자 이하이어야 하고, 사이에 대시(-), 밑줄(_), 점(.)이 들어갈 수 있다.
- 접두사는 선택적이다. 지정된 경우, 접두사는 DNS 서브도메인이어야 한다.
- 점(.)으로 구분된 일련의 DNS 레이블은 총 253자를 넘지 않고, 뒤에 슬래시(/)가 붙는다.
- 접두가가 없으면 키 레이블은 개인용으로 간주
- `kubernetes.io/`와 `k8s.io/` 접두사는 쿠버네티스의 핵심 컴포넌트로 예약되어있다.

예시

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: annotations-demo
  annotations:
    imageregistry: "https://hub.docker.com/"
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
```

## 필드 셀렉터

필드 셀렉터: 한 개 이상의 리소스 필드 값에 따라 쿠버네티스 리소스를 선택하기 위해 사용

쿼리 예시

- `metadata.name=my-service`
- `metadata.namespace!=default`
- `status.phase=Pending`

### 사용 가능한 필드

- 사용 가능한 필드는 쿠버네티스의 리소스 종류에 따라서 다름
- 모든 리소스 종류는 metadata.name 과 metadata.namespace 필드 셀렉터를 사용할 수 있음

없는 필드 셀렉터 요청시 에러 예시

```sh
$ kubectl get ingress --field-selector foo.bar=baz
Error from server (BadRequest): Unable to find "ingresses" that match label selector "", field selector "foo.bar=baz": "foo.bar" is not a known field selector: only "metadata.name", "metadata.namespace"
```

### 사용 가능한 연산자

- `=`, `==`, `!=`

예시

```sh
$ kubectl get services  --all-namespaces --field-selector metadata.namespace!=default
```

### 연계되는(Chained) 셀렉터

쉼표로 구분되는 목록을 통해 필드 셀렉터를 연계해서 사용할 수 있다.

예시

```sh
$ kubectl get pods --field-selector=status.phase!=Running,spec.restartPolicy=Always
```

### 여러 개의 리소스 종류

필드 셀렉터를 여러 개의 리소스 종류에 걸쳐 사용할 수 있다.

예시

```sh
$ kubectl get statefulsets,services --all-namespaces --field-selector metadata.namespace!=default
```

## 권장 레이블

권장 레이블: kubectl과 대시보드 같은 지원 도구 외에도 쿼리하는 방식으로 애플리케이션을 식별하게 한다.

> 참고: 메타데이터들은 권장 레이블이다. 애플리케이션을 보다 쉽게 관리할 수 있지만 코어 도구에는 필요하지 않다.

### 레이블

레이블을 최대한 활용하려면 모든 리소스 오브젝트에 적용해야 한다.

| Key                                 | Description           | Example  | Type |
| ----------------------------------- | --------------------- | -------- | ---- |
| `app.kubernetes.io/name`            | 애플리케이션 이름 | `mysql` | 문자열 |
| `app.kubernetes.io/instance`        | 애플리케이션의 인스턴스를 식별하는 고유한 이름 | `mysql-abcxzy` | 문자열 |
| `app.kubernetes.io/version`         | 애플리케이션의 현재 버전 (예: a semantic version, revision hash 등.) | `5.7.21` | 문자열 |
| `app.kubernetes.io/component`       | 아키텍처 내 구성요소 | `database` | 문자열 |
| `app.kubernetes.io/part-of`         | 이 애플리케이션의 전체 이름 | `wordpress` | 문자열 |
| `app.kubernetes.io/managed-by`  | 애플리케이션의 작동을 관리하는데 사용되는 도구 | `helm` | 문자열 |

위 레이블의 실제 예시

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app.kubernetes.io/name: mysql
    app.kubernetes.io/instance: mysql-abcxzy
    app.kubernetes.io/version: "5.7.21"
    app.kubernetes.io/component: database
    app.kubernetes.io/part-of: wordpress
    app.kubernetes.io/managed-by: helm
```

### 애플리케이션과 애플리케이션 인스턴스

애플리케이션의 이름과 애플리케이션 인스턴스 이름은 별도로 기록된다.

예시

- 워드프레스는 애플리케이션 이름으로 app.kubernetes.io/name 이라는 레이블에 wordpress 라는 값을 가지며,
- 애플리케이션 인스턴스 이름으로는 app.kubernetes.io/instance 라는 레이블에 wordpress-abcxzy 라는 값을 가진다.

### 예시

#### 단순한 스테이트리스 서비스

`Deployment` 와 `Service` 오브젝트를 통해 배포된 단순한 스테이트리스 서비스의 경우

`Deployment`: 애플리케이션을 실행하는 파드를 감시하는데 사용

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: myservice
    app.kubernetes.io/instance: myservice-abcxzy
...
```

`Service`: 애플리케이션을 노출하기 위해 사용

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: myservice
    app.kubernetes.io/instance: myservice-abcxzy
...
```

#### 데이터베이스가 있는 웹 애플리케이션

Helm을 이용해서 데이터베이스(MySQL)을 이용하는 웹 애플리케이션(WordPress)을 설치하는, 더 복잡한 애플리케이션 예시

`Deployment`: WordPress를 배포

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/name: wordpress
    app.kubernetes.io/instance: wordpress-abcxzy
    app.kubernetes.io/version: "4.9.4"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: wordpress
...
```

`Service`: 애플리케이션을 노출하기 위해 사용

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: wordpress
    app.kubernetes.io/instance: wordpress-abcxzy
    app.kubernetes.io/version: "4.9.4"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: server
    app.kubernetes.io/part-of: wordpress
...
```

MySQL: `StatefulSet` 에 MySQL의 소속과 상위 애플리케이션에 대한 메타데이터를 포함해 노출

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app.kubernetes.io/name: mysql
    app.kubernetes.io/instance: mysql-abcxzy
    app.kubernetes.io/version: "5.7.21"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: database
    app.kubernetes.io/part-of: wordpress
...
```

`Service`: WordPress의 일부로 MySQL을 노출하는데 이용

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/name: mysql
    app.kubernetes.io/instance: mysql-abcxzy
    app.kubernetes.io/version: "5.7.21"
    app.kubernetes.io/managed-by: helm
    app.kubernetes.io/component: database
    app.kubernetes.io/part-of: wordpress
...
```

MySQL `StatefulSet`과 `Service`로 MySQL과 WordPress가 더 큰 범위의 애플리케이션에 포함되어 있는 것을 알게 된다.
