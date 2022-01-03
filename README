# Hardware CI & Dev Containter
[![Build Docker Images](https://github.com/Mluckydwyer/hw-ci/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Mluckydwyer/hw-ci/actions/workflows/docker-image.yml)
![Cent OS](https://img.shields.io/badge/cent%20os-002260?style=for-the-badge&logo=centos&logoColor=F0F0F0)![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)

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
|               Size (Download)              |  ~14 GB  |  ~14 GB  |
|              Size (Extracted)              |  ~14 GB  |  ~14 GB  |
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
