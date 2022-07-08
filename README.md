# ⚗️ Hardware CI & Dev Containters 🚢

<p align="center">
  <a title="Sourcecode on GitHub" href="https://github.com/Mluckydwyer/hw-ci"><img src="https://img.shields.io/badge/Mluckydwyer-hw–ci-blueviolet.svg?longCache=true&logo=GitHub"></a><!--
  -->
  <a title="Builds" href="https://github.com/Mluckydwyer/hw-ci/actions"><img src="https://github.com/Mluckydwyer/hw-ci/actions/workflows/docker-image.yml/badge.svg"></a><!--
  -->
  <a title="Open in VSCode" href="https://open.vscode.dev/Mluckydwyer/hw-ci"><img src="https://img.shields.io/static/v1?logo=visualstudiocode&label=&message=Open%20in%20Visual%20Studio%20Code&labelColor=2c2c32&color=007acc&logoColor=007acc"></a><!--
  -->
  <!-- <br>
  <a title="CentOS" href="https://www.centos.org/"><img src="https://img.shields.io/badge/cent%20os-002260?style=for-the-badge&logo=centos&logoColor=F0F0F0"></a>
  <a title="Docker" href="https://docker.com/"><img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white"></a>
  <a title="Visual Studio Code" href="https://code.visualstudio.com/"><img alt="Slim Container Size" src="https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white"></a><!--
  -->
</p>

These containers were created for my personal hardware development projects and courses duing my undergraduate degree. Please feel free to use them and give feedback, as I am always looking to improve them. [hdl/containers](https://github.com/hdl/containers) also has a great selection of containers designed for hardware development, so be sure to check them out as well.


## 🚀 Getting Started
To get started with this container, pull either the `slim`, `full`, or `dev` variants from Docker:
```properties
docker pull mluckydwyer/hw-ci:slim
```
These containers can also be found on the Github Container Registry:
```properties
docker pull ghcr.io/mluckydwyer/hw-ci:slim
```

This repository also has support for VScode Development Containers and Github Code Spaces. In both cases, the `dev` variant will be used, as it is intended for development and includes additional tools (See the _Tools_ sections for more details).


## 🛠️ Tools
This container is split into three variants, `slim`, `full`, and `dev`. The `slim` variant contains all of the primary simulation and testing tools needed for CD/CI hardware development. It is intended to be light, fast, and used unattended. The `full` variant is built on top of the `slim` container and also includes additional tools that are useful when using the container for development. These include the Modelsim simulator tools, the Symbiflow open-source toolflow for both XC7 and EOS-S3 FPGAs, and other general programming tools such as an updated GCC version. Finally, the `dev` container is built off of the `full` container and includes some additional tools for working in a hands-on development enviornment. Most additions here are quality-of-life improvemnts for building automated flows with these tools or as a standalone development envrionemnt. See the table below for additional details:

|                                            | Slim 🍃 | Full 🌱 |  Dev 🌳 |
|:------------------------------------------:|:--------:|:--------:|:-------:|
|                      Tag                   |  `slim`  |  `full`  |  `dev`  |
|                   Base OS                  | Centos 7 | Centos 7 | Centos 7 |
|               Size (Compressed Download)   | <a href="https://hub.docker.com/r/mluckydwyer/hw-ci"><img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/mluckydwyer/hw-ci/slim?label=Image%20Size%20%28Slim%29"></a>  |  <a href="https://hub.docker.com/r/mluckydwyer/hw-ci"><img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/mluckydwyer/hw-ci/full?label=Image%20Size%20%28Full%29"></a>  | <a href="https://hub.docker.com/r/mluckydwyer/hw-ci"><img alt="Docker Image Size (tag)" src="https://img.shields.io/docker/image-size/mluckydwyer/hw-ci/dev?label=Image%20Size%20%28Dev%29"></a> |
|                  Verilator                 |     ✅    |     ✅    |     ✅    |
|                    GHDL                    |     ✅    |     ✅    |     ✅    |
|               Makepp, GNU M4               |     ✅    |     ✅    |     ✅    |
| CocoTB + AXI, Coverage, and Pytest Plugins |     ✅    |     ✅    |     ✅    |
|                Python 3.9.13               |     ✅    |     ✅    |     ✅    |
|              Pytest + Plugins              |     ✅    |     ✅    |     ✅    |
|           GCC 10 + LLVM 11 + Make          |          |     ✅    |     ✅    |
|         Questasim 22.2.0.94 (Intel)        |          |     ✅    |     ✅    |
|    Symbiflow with XC7 & EOS-S3 Support     |          |     ✅    |     ✅    |
|                  Miniconda                 |          |     ✅    |     ✅    |
|                    VUnit                   |          |     ✅    |     ✅    |
|         Symbiflow Tool Helper Scripts      |          |     ✅    |     ✅    |
|             Yowasp-Yosys + VSG             |          |          |     ✅    |
|           VNC (NoVNC Web Server)           |          |          |     ✅    |
|                VSCode Server               |          |          |     ✅    |
|             Matplotlib (Python)            |          |          |     ✅    |
|        Debugpy + Remote_pdb (Python)       |          |          |     ✅    |
|              TerosHDL (VSCode)             |          |          |     ✅    |
|                   GTKWave                  |          |          |     ✅    |
|                   Firefox                  |          |          |     ✅    |
|                    CMake                   |          |          |     ✅    |
|                    Bash                    |          |          |     ✅    |
|                 Vim + Nano                 |          |          |     ✅    |
|             Sudo + Wget + Htop             |          |          |     ✅    |
|           GUI Tool Helper Scripts          |          |          |     ✅    |


### 📜 Helper Scripts
Here is a list of the included helper scripts in the `full` and `dev` containers. They are included on the system path and can be run from anyhere:
- `start-modelsim`: Open Modelsim in GUI mode.
- `start-vnc-session`: Start the NoVNC server (VNC can be accessed on port 5090, NoVNC webserver can be accessed at localhost:6080 @1080p).
- `start-code-server`: Start the VSCode remote server (Can also be done by opening the container in VSCode).
- `enable-symbiflow-xc7`: Activate the Symbiflow XC7 Conda envrionment
- `enable-symbiflow-eos-s3`: Activate the Symbiflow EOS-S3 Conda envrionment
- `download-symbiflow-arch-defs`: Download all of the required Symbiflow architecture definition files for the XC7 and EOS-S3 boards (these are too large to include in the container since they are ~20 GB)
- `startup`: This script runs on startup of the `dev` container and starts noVNC, VNC, and the VSCode server in the background


### LLVM & GCC (Devtoolsets)
Included in the `dev` container is the LLVM 11.0 and GCC 10 toolsets. While they are installed, one must enable them using `scl`. The following are some sample ways to enable the devtool sets:
```properties
scl enable devtoolset-10 'sh'
scl enable devtoolset-10 'bash'
scl enable devtoolset-10 'gcc hello.c -c hello'

scl enable llvm-toolset-11.0 'sh'
scl enable llvm-toolset-11.0 'bash'
scl enable llvm-toolset-11.0 'clang hello.c -c hello'
```

### 🖥️ VNC & noVNC
The `dev` container includes tools to assist with visual applications such as Modelsim and GTKWave. On port `8000`, the container launches a Python webserver to serve the noVNC page. After navigating to this page, you are able to view and interact with any GUI applications from any web browser. VNC connections are also supported by the VNC server running at port `5900` (The `openbox` window manager is used in this workflow).

### ⌨️ VSCode
A VScode server is also installed on the `dev` container, although it appears that VSCode continues to install its own server anyways upon connections. This has not been tested, but reguardless should function as desired.


### 🛰️ Github Code Spaces
This repository contains an example `.devcontainer` configuration to allow the seemless integration with VSCode Development Containers and Github Code Spaces. By launching this repository in a Github Code Space, you will be able to pull the pre-build containers, open the proper ports, and install some helpful VSCode plugins.

## 🧮 CprE 480: GPU Architecture (Iowa State)
This container was originally created for the verifiaction of the OpenGL complient GPUs designed in this course. Thus, it purposefully includes VHDL simulation tools and Pytest support to make verification as easy as possible. For templates of lab verificaiton test benches and automated Gitlab and Github Actions, please reach out to me either over [e-mail](mailto:dwyer@iastate.edu) or the alumni channel in Discord.
