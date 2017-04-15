[![CircleCI](https://circleci.com/gh/andrie/tensorflowr.svg?style=svg)](https://circleci.com/gh/andrie/tensorflowr)
[![license](https://img.shields.io/badge/license-GPLv2-blue.svg)](https://opensource.org/licenses/GPL-2.0)


# tensorflowr: Docker repository with deep learning for R.

image            | description                               | size   | metrics | build status 
---------------- | ----------------------------------------- | ------ | ------- | --------------
[tensorflow](https://hub.docker.com/r/andrie/tensorflowr) | R-3.3.3, RStudio, tensorflow and keras  | [![](https://images.microbadger.com/badges/image/andrie/tensorflowr.svg)](https://microbadger.com/images/andrie/tensorflowr) | [![](https://img.shields.io/docker/pulls/andrie/tensorflowr.svg)](https://hub.docker.com/r/andrie/tensorflowr) |  [![](https://img.shields.io/docker/automated/andrie/tensorflowr.svg)](https://hub.docker.com/r/andrie/tensorflowr/builds)

The repository uses [rocker/rstudio:3.3.3](https://hub.docker.com/r/rocker/rstudio/) as the base, and adds:

* Python virtual environment ([virtualenv](http://python-guide-pt-br.readthedocs.io/en/latest/dev/virtualenvs/)) containing:
    - `tensorflow` library ([tensorflow.org](https://www.tensorflow.org/))
    - `keras` library ([keras.io](https://keras.io/))
* R packages for:
    - `tensorflow`, installed from [master branch on github](https://github.com/rstudio/tensorflow)
    - `kerasR`, installed from [CRAN](https://cran.r-project.org/package=kerasR)

The R package `reticulate` (available on [CRAN](https://cran.r-project.org/web/packages/reticulate/index.html)) communicates between R and python. The `reticulate` package needs to know where python is installed, so the repository writes environment variables into the `Renviron` file to configure `reticulate` correctly:

* `TENSORFLOW_PYTHON = "/tensorflow/bin/python"`
* `RETICULATE_PYTHON = "/tensorflow/bin/python"`

# Docker instructions

**Pull**

To pull and build the image, use:

```
docker pull andrie/tensorflowr
```

**Run the container**

Since the repository contains `rocker/rstudio`, you can run RStudio in your web browser by pointing to [https://localhost:8787] if you map the ports. The following line creates a container and names it `tensorflowr`, so you can easily refer to this later.

```
docker run -d --name tensorflowr -p 8787:8787 andrie/tensorflowr
```

**Exec**

To execute code inside the running container:

```
docker exec -ti tensorflowr bash
```
