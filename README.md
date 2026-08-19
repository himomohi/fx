<div align="center">

```text
             f x
     native agent runtime
```

# fx

### A tiny, open, embeddable coding agent built for the terminal

[English](README.md) | [한국어](README.ko.md)

[![License: Apache 2.0](https://img.shields.io/badge/license-Apache%202.0-111827.svg)](LICENSE)
[![Zig 0.16.0](https://img.shields.io/badge/Zig-0.16.0-f7a41d.svg)](https://ziglang.org/)
[![Status: Experimental](https://img.shields.io/badge/status-experimental-8b5cf6.svg)](#project-status)
[![Windows: Native Preview](https://img.shields.io/badge/Windows-native%20preview-2563eb.svg)](#platform-support)

Minimal by design. Model agnostic. Native where it matters.

[Quick start](#quick-start) · [Why fx](#why-fx) · [Embed](#embed-fx) · [Documentation](https://fx.sh/docs)

</div>

> [!WARNING]
> fx is experimental software. Interfaces, configuration, and behavior may change between releases.

## Why fx

fx keeps the agent runtime small enough to understand, modify, and embed without giving up the workflows expected from a modern coding agent.

| Principle | What it means |
| --- | --- |
| Native runtime | A compact Zig executable with fast startup and minimal overhead |
| Model agnostic | Connect to supported providers without binding the runtime to one model |
| Terminal first | Work where the repository, tools, and developer context already live |
| Embeddable | Use fx as a CLI, ACP process, or library component |
| Extensible | Add skills, MCP servers, custom tools, and project instructions |
| Transparent | Inspect the source, permission model, prompts, and execution flow |

## Quick start

### macOS and Linux

Install the latest release:

```sh
curl -fsSL https://fx.sh/setup.sh | bash
```

Run the setup flow, then start fx:

```sh
fx setup
fx
```

### Windows native preview

Windows support is currently source-built and focused on foreground CLI and ACP workflows. Install Git and Zig 0.16.0, then run:

```powershell
git clone https://github.com/vercel-labs/fx.git
Set-Location fx
.\scripts\build-windows.ps1
.\zig-out\bin\fx.exe setup
.\zig-out\bin\fx.exe
```

The build script creates a native `fx.exe` without requiring WSL.

## Platform support

| Capability | macOS / Linux | Windows native preview |
| --- | :---: | :---: |
| Foreground CLI | Supported | Preview |
| Configuration and sessions | Supported | Preview |
| ACP over standard input/output | Supported | Preview |
| Skills and MCP integration | Supported | Preview |
| Interactive terminal UI | Supported | Partial |
| Unix sockets and Herdr | Supported | Not available |
| POSIX background process groups | Supported | Not available |
| Pinned-socket `web_fetch` | Supported | Not available |
| Terminal takeover | Supported | Not available |
| Self-upgrade | Supported | Not available |

On Windows, fx relies on inherited user-directory ACLs instead of POSIX file modes. The Windows build gate validates compilation and focused native smoke paths; POSIX-specific test fixtures are not part of that gate yet.

## Everyday workflow

```sh
# Start an interactive session
fx

# Ask a single question
fx ask "Explain the architecture of this repository"

# Inspect the current runtime
fx status

# Diagnose configuration and provider issues
fx doctor

# Run fx as an Agent Client Protocol process
fx acp
```

Use project instructions to shape behavior close to the code:

```text
your-project/
|-- AGENTS.md
|-- src/
`-- ...
```

fx asks before sensitive operations according to its permission policy. Review requested commands and file access as you would with any developer automation.

## Embed fx

fx builds as a native binary or WebAssembly. Applications embedding fx can provide network transport, session storage, configuration, permission handling, and terminal input/output.

| Surface | Use |
| --- | --- |
| `fx acp` | Connect the native agent to editors and other Agent Client Protocol clients |
| `createFxAgent()` | Embed the agent core in a JavaScript host with `fx-core.wasm` |
| `createFxTerminal()` | Embed the interactive terminal with `fx-term.wasm` |

The WebAssembly SDK is experimental. See the [WebAssembly SDK](sdk/README.md) and [ACP documentation](https://fx.sh/docs/using-fx/acp).

## Extend fx

- Put reusable instructions and workflows in skills.
- Connect external capabilities through MCP servers.
- Define repository behavior in `AGENTS.md`.
- Add native tools directly in Zig when tighter integration is needed.

See the [documentation](https://fx.sh/docs) for configuration and extension guides.

## Build from source

Requirements:

- Zig 0.16.0
- Git
- A supported macOS, Linux, or Windows development environment

```sh
git clone https://github.com/vercel-labs/fx.git
cd fx
zig build
zig build test
```

Windows users can run `.\scripts\build-windows.ps1` for the native preview build. Some POSIX-specific tests do not compile on Windows yet.

## Project status

fx is under active development. The macOS and Linux paths are the primary supported environments. Native Windows support is an experimental port and does not yet provide full feature parity.

Bug reports and focused contributions are welcome. Include the operating system, Zig version, exact command, and relevant output when reporting a problem.

## Documentation

- [Documentation](https://fx.sh/docs)
- [Contributing guide](CONTRIBUTING.md)
- [Third-party notices](THIRD_PARTY_NOTICES.md)
- [Korean README](README.ko.md)

## License

Licensed under the [Apache License 2.0](LICENSE).

## Credits

Created and maintained by [Vercel Labs](https://github.com/vercel-labs).

Interface sounds by [cuelume](https://github.com/Danilaa1/cuelume).
