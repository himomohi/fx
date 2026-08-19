<div align="center">

```text
             f x
     native agent runtime
```

# fx

### 터미널을 위해 만든 작고 개방적이며 임베드 가능한 코딩 에이전트

[English](README.md) | [한국어](README.ko.md)

[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-111827.svg)](LICENSE)
[![Zig 0.16.0](https://img.shields.io/badge/Zig-0.16.0-f7a41d.svg)](https://ziglang.org/)
[![Status: Experimental](https://img.shields.io/badge/status-experimental-8b5cf6.svg)](#프로젝트-상태)
[![Windows: Native Preview](https://img.shields.io/badge/Windows-native%20preview-2563eb.svg)](#플랫폼-지원)

작게 설계하고, 모델에 종속되지 않으며, 필요한 곳에서 네이티브로 동작합니다.

[빠른 시작](#빠른-시작) · [fx를 선택하는 이유](#fx를-선택하는-이유) · [임베드](#fx-임베드) · [문서](https://fx.sh/docs)

</div>

> [!WARNING]
> fx는 실험 단계의 소프트웨어입니다. 릴리스 사이에 인터페이스, 설정, 동작이 변경될 수 있습니다.

## fx를 선택하는 이유

fx는 최신 코딩 에이전트에 필요한 작업 흐름을 제공하면서도, 전체 런타임을 직접 이해하고 수정하고 임베드할 수 있을 만큼 작게 유지합니다.

| 원칙 | 의미 |
| --- | --- |
| 네이티브 런타임 | 빠르게 시작하고 오버헤드가 작은 Zig 실행 파일 |
| 모델 독립성 | 런타임을 하나의 모델에 묶지 않고 지원되는 공급자에 연결 |
| 터미널 우선 | 저장소, 도구, 개발자 컨텍스트가 이미 있는 환경에서 작업 |
| 임베드 가능 | CLI, ACP 프로세스 또는 라이브러리 구성 요소로 활용 |
| 확장 가능 | 스킬, MCP 서버, 사용자 정의 도구, 프로젝트 지침 추가 |
| 투명성 | 소스, 권한 모델, 프롬프트, 실행 흐름을 직접 확인 |

## 빠른 시작

### macOS와 Linux

최신 릴리스를 설치합니다.

```sh
curl -fsSL https://fx.sh/setup.sh | bash
```

초기 설정 후 fx를 실행합니다.

```sh
fx setup
fx
```

### Windows 네이티브 프리뷰

현재 Windows 지원은 소스 빌드 방식이며 포그라운드 CLI와 ACP 작업 흐름에 초점을 맞춥니다. Git과 Zig 0.16.0을 설치한 뒤 실행합니다.

```powershell
git clone https://github.com/vercel-labs/fx.git
Set-Location fx
.\scripts\build-windows.ps1
.\zig-out\bin\fx.exe setup
.\zig-out\bin\fx.exe
```

빌드 스크립트는 WSL 없이 네이티브 `fx.exe`를 생성합니다.

## 플랫폼 지원

| 기능 | macOS / Linux | Windows 네이티브 프리뷰 |
| --- | :---: | :---: |
| 포그라운드 CLI | 지원 | 프리뷰 |
| 설정과 세션 | 지원 | 프리뷰 |
| 표준 입출력 기반 ACP | 지원 | 프리뷰 |
| 스킬과 MCP 연동 | 지원 | 프리뷰 |
| 대화형 터미널 UI | 지원 | 일부 지원 |
| Unix 소켓과 Herdr | 지원 | 미지원 |
| POSIX 백그라운드 프로세스 그룹 | 지원 | 미지원 |
| 소켓 고정 방식 `web_fetch` | 지원 | 미지원 |
| 터미널 제어권 전환 | 지원 | 미지원 |
| 자체 업그레이드 | 지원 | 미지원 |

Windows에서는 POSIX 파일 모드 대신 사용자 디렉터리에서 상속된 ACL을 사용합니다. Windows 빌드 게이트는 컴파일과 핵심 네이티브 스모크 경로를 검증하며, POSIX 전용 테스트 픽스처는 아직 포함하지 않습니다.

## 자주 사용하는 명령

```sh
# 대화형 세션 시작
fx

# 질문 한 번 실행
fx ask "이 저장소의 아키텍처를 설명해 줘"

# 현재 런타임 상태 확인
fx status

# 설정과 공급자 문제 진단
fx doctor

# Agent Client Protocol 프로세스로 실행
fx acp
```

프로젝트 지침을 코드 가까이에 두어 동작을 조정할 수 있습니다.

```text
your-project/
|-- AGENTS.md
|-- src/
`-- ...
```

fx는 권한 정책에 따라 민감한 작업 전에 승인을 요청합니다. 다른 개발 자동화 도구와 마찬가지로 요청된 명령과 파일 접근 범위를 검토하세요.

## fx 임베드

fx는 네이티브 바이너리 또는 WebAssembly로 빌드됩니다. fx를 임베드하는 애플리케이션에서 네트워크 전송, 세션 저장소, 설정, 권한 처리, 터미널 입출력을 제공할 수 있습니다.

| 표면 | 용도 |
| --- | --- |
| `fx acp` | 네이티브 에이전트를 편집기와 다른 Agent Client Protocol 클라이언트에 연결 |
| `createFxAgent()` | `fx-core.wasm`을 사용하는 JavaScript 호스트에 에이전트 코어 임베드 |
| `createFxTerminal()` | `fx-term.wasm`으로 대화형 터미널 임베드 |

WebAssembly SDK는 실험 단계입니다. [WebAssembly SDK](sdk/README.md)와 [ACP 문서](https://fx.sh/docs/using-fx/acp)를 참고하세요.

## fx 확장

- 재사용 가능한 지침과 작업 흐름은 스킬로 구성합니다.
- 외부 기능은 MCP 서버로 연결합니다.
- 저장소별 동작은 `AGENTS.md`에 정의합니다.
- 더 긴밀한 통합이 필요하면 Zig로 네이티브 도구를 추가합니다.

설정과 확장 방법은 [공식 문서](https://fx.sh/docs)에서 확인할 수 있습니다.

## 소스에서 빌드

필요한 항목:

- Zig 0.16.0
- Git
- 지원되는 macOS, Linux 또는 Windows 개발 환경

```sh
git clone https://github.com/vercel-labs/fx.git
cd fx
zig build
zig build test
```

Windows에서는 `.\scripts\build-windows.ps1`로 네이티브 프리뷰를 빌드할 수 있습니다. 일부 POSIX 전용 테스트는 아직 Windows에서 컴파일되지 않습니다.

## 프로젝트 상태

fx는 활발히 개발 중입니다. macOS와 Linux가 주 지원 환경이며, Windows 네이티브 지원은 아직 전체 기능이 동일하지 않은 실험적 포트입니다.

버그 제보와 범위가 명확한 기여를 환영합니다. 문제를 제보할 때 운영체제, Zig 버전, 실행한 명령, 관련 출력을 포함해 주세요.

## 문서

- [공식 문서](https://fx.sh/docs)
- [기여 가이드](CONTRIBUTING.md)
- [서드파티 고지](THIRD_PARTY_NOTICES.md)
- [영문 README](README.md)

## 라이선스

[Apache License 2.0](LICENSE)에 따라 배포됩니다.

## 크레딧

[Vercel Labs](https://github.com/vercel-labs)에서 만들고 관리합니다.

인터페이스 사운드는 [cuelume](https://github.com/Danilaa1/cuelume)에서 제공했습니다.
