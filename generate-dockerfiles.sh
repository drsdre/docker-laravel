#!/usr/bin/env bash
VERSION=7.4 TYPE=cli OS=alpine ./templater.sh Dockerfile_cli.tmpl > 7.4/alpine/cli/Dockerfile
VERSION=7.4 TYPE=fpm OS=alpine ./templater.sh Dockerfile_fpm.tmpl > 7.4/alpine/fpm/Dockerfile
VERSION=8.0 TYPE=cli OS=alpine ./templater.sh Dockerfile_cli.tmpl > 7.4/alpine/cli/Dockerfile
VERSION=8.0 TYPE=fpm OS=alpine ./templater.sh Dockerfile_fpm.tmpl > 7.4/alpine/fpm/Dockerfile
VERSION=8.1 TYPE=cli OS=alpine ./templater.sh Dockerfile_cli.tmpl > 7.4/alpine/cli/Dockerfile
VERSION=8.1 TYPE=fpm OS=alpine ./templater.sh Dockerfile_fpm.tmpl > 7.4/alpine/fpm/Dockerfile
VERSION=8.2 TYPE=cli OS=alpine ./templater.sh Dockerfile_cli.tmpl > 7.4/alpine/cli/Dockerfile
VERSION=8.2 TYPE=fpm OS=alpine ./templater.sh Dockerfile_fpm.tmpl > 7.4/alpine/fpm/Dockerfile
