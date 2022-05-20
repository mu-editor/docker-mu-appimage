# Docker Image to build Mu AppImages

Docker image with preinstalled tooling to build Mu AppImages.

This image has been created to build the Mu AppImages via GitHub Actions CI
in the Mu Editor main repository:
https://github.com/mu-editor/mu/actions/workflows/build.yml

## Image info

The source of truth of what's in this image is the [`Dockerfile`](Dockerfile),
which is self contained, so it's all in a single file.

For quick reference:
- Ubuntu 16.04
- Python 3.8
- xvfb
