# Hardware CI & Dev Containter
<p align="center">
  <a title="Image Builds" href="https://github.com/Mluckydwyer/hw-ci/actions"><img src="https://github.com/Mluckydwyer/hw-ci/actions/workflows/docker-image.yml/badge.svg"></a><!--
  -->
  <a title="hw-ci" href="https://hub.docker.com/repository/docker/mluckydwyer/hw-ci"><img src="https://badgen.net/badge/icon/docker?icon=docker&label"></a><!--
  -->
  <a title="Docker Image Size (Slim)" href="https://hub.docker.com/repository/docker/mluckydwyer/hw-ci"><img alt="Slim Container Size" src="https://img.shields.io/docker/image-size/Mluckydwyer/hw-ci/slim"></a><!--
  -->
  <a title="Docker Image Size (Full)" href="https://hub.docker.com/repository/docker/mluckydwyer/hw-ci"><img alt="Full Container Size" src="https://img.shields.io/docker/image-size/Mluckydwyer/hw-ci/full"></a><!--
  -->
  <a title="Open in Visual Studio Code" href="https://open.vscode.dev/Mluckydwyer/hw-ci"><img src="https://open.vscode.dev/badges/open-in-vscode.svg"></a><!--
  -->
  <br>
  <a title="CentOS" href="https://www.centos.org/"><img src="https://img.shields.io/badge/cent%20os-002260?style=for-the-badge&logo=centos&logoColor=F0F0F0"></a><!--
  -->
  <a title="Docker" href="https://docker.com/"><img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white"></a><!--
  -->
  <a title="Visual Studio Code" href="https://code.visualstudio.com/"><img alt="Slim Container Size" src="https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white"></a><!--
  -->
</p>

<!-- [![Build Docker Images](https://github.com/Mluckydwyer/hw-ci/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Mluckydwyer/hw-ci/actions/workflows/docker-image.yml) [![hw-ci](https://badgen.net/badge/icon/docker?icon=docker&label)](https://hub.docker.com/repository/docker/mluckydwyer/hw-ci) ![Docker Image Size (Slim)](https://img.shields.io/docker/image-size/Mluckydwyer/hw-ci/slim) ![Docker Image Size (Full)](https://img.shields.io/docker/image-size/Mluckydwyer/hw-ci/full) [![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/Mluckydwyer/hw-ci)


![Cent OS](https://img.shields.io/badge/cent%20os-002260?style=for-the-badge&logo=centos&logoColor=F0F0F0)![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)! [Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white) -->

These containers were created for my personal hardware development projects and courses duing my undergraduate degree. Please feel free to use them and give feedback, as I am always looking to improve them. [hdl/containers](https://github.com/hdl/containers) also have a great selection of containers designed for hardware development, so be sure to check them out as well.

## Getting Started
To get started with this container, pull either the `slim` or `full` variants from the Docker:
```sh
docker pull mluckydwyer/hw-ci:slim
```
```sh
docker pull mluckydwyer/hw-ci:full
```

This container also has support for VScode Development Containers and Github Code Spaces. In both cases, the `full` variant will be used, as it is intended for development and includes additional tools (See the _Tools_ sections for more details).

## Tools
This container is split into two variants, `slim` and `full`. The `slim` variant contains all of the primary simulation and testing tools needed for CD/CI hardware development and is intended to be used unattended. The `full` variant is built on top of the `slim` container and also includes additional tools that are useful when using the container for development. See the table below for additional details:

|                    Tool                    |   Slim   |   Full   |
|:------------------------------------------:|:--------:|:--------:|
|                   Base OS                  | Centos 7 | Centos 7 |
|               Size (Download)              |  ~4.6 GB  |  ~5.2 GB  |
|              Size (Extracted)              |  ~11.5 GB  |  ~14 GB  |
|         Modelsim 20.1.1.720 (Intel)        |     ✅    |     ✅    |
|                  Verilator                 |     ✅    |     ✅    |
|                    GHDL                    |     ✅    |     ✅    |
| CocoTB + AXI, Coverage, and Pytest Plugins |     ✅    |     ✅    |
|                    VUnit                   |     ✅    |     ✅    |
|                Python 3.6.14               |     ✅    |     ✅    |
|              Pytest + Plugins              |     ✅    |     ✅    |
|     GCC 8 + GNAT (Ada Core 2017) + Make    |     ✅    |     ✅    |
|           VNC (NoVNC Web Server)           |          |     ✅    |
|                VSCode Server               |          |     ✅    |
|             Matplotlib (Python)            |          |     ✅    |
|        Debugpy + Remote_pdb (Python)       |          |     ✅    |
|         Yowasp-Yosys + VSG (Python)        |          |     ✅    |
|              TerosHDL (VSCode)             |          |     ✅    |
|                   GTKWave                  |          |     ✅    |
|                   Firefox                  |          |     ✅    |
|                    CMake                   |          |     ✅    |
|                     Zsh                    |          |     ✅    |
|                 Vim + Nano                 |          |     ✅    |
|             Sudo + Wget + Htop             |          |     ✅    |
|           GUI Tool Helper Scripts          |          |     ✅    |

## CprE 480: GPU Architecture (Iowa State)
This container was originally created for the verifiaction of the OpenGL complient GPUs desined in this course. Thus, it purposefully includes VHDL simulation tools and Pytest support to make verification as easy as possible. For templates of lab verificaiton testbenches and automated Gitlab and Github Actions, please reach out to me either over e-mail or the alumni channel in Discord.

[![Contributors over time](https://contributor-graph-api.apiseven.com/contributors-svg?chart=contributorOverTime&repo=Mluckydwyer/hw-ci)](https://www.apiseven.com/en/contributor-graph?chart=contributorOverTime&repo=Mluckydwyer/hw-ci)



