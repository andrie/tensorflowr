# tensorflowr: Docker repository with deep learning for R.

image            | description                               | from |size   | metrics | build status 
---------------- | ----------------------------------------- | ---- | ------ | ------- | --------------
[reticulate](https://hub.docker.com/r/andrie/reticulate) |  R-3.3.3, RStudio, Python 3.4.2, Anaconda and the `reticulate` package | [rocker/rstudio:3.3.3](https://hub.docker.com/r/rocker/rstudio/) | [![](https://images.microbadger.com/badges/image/andrie/reticulate.svg)](https://microbadger.com/images/andrie/reticulate) | [![](https://img.shields.io/docker/pulls/andrie/reticulate.svg)](https://hub.docker.com/r/andrie/reticulate) |  [![](https://img.shields.io/docker/automated/andrie/reticulate.svg)](https://hub.docker.com/r/andrie/reticulate/builds)
[tensorflowr](https://hub.docker.com/r/andrie/tensorflowr) | Adds tensorflow and keras, installed in python virtualenv and conda environment | [andrie/reticulate](https://hub.docker.com/r/andrie/reticulate) | [![](https://images.microbadger.com/badges/image/andrie/tensorflowr.svg)](https://microbadger.com/images/andrie/tensorflowr) | [![](https://img.shields.io/docker/pulls/andrie/tensorflowr.svg)](https://hub.docker.com/r/andrie/tensorflowr) |  [![](https://img.shields.io/docker/automated/andrie/tensorflowr.svg)](https://hub.docker.com/r/andrie/tensorflowr/builds)

# Repositories

## andrie/reticulate

This repository will be useful to test any R code that connects to Python using the `reticulate` package.  The repository uses [rocker/rstudio:3.3.3](https://hub.docker.com/r/rocker/rstudio/) as the base, and adds:

* Python 3.4.2
* Anaconda
* R packages for:
    - Typical development tools, including `devtools`, `roxygen2` and `rmarkdown`
    - `Rcpp`
    - `reticulate`, an interface layer between R and python, installed from [CRAN](https://cran.r-project.org/package=reticulate)


## andrie/tensorflowr

This repository builds two environments that contain `tensorflow` ([tensorflow.org](https://www.tensorflow.org/)) and `keras` ([keras.io](https://keras.io/)):

* Python virtual environment, containing:
    - At location `/tensorflow`
    - Python 3.4.2
    - `tensorflow`, `keras` and `h5py`
    - Activate this environment using
        ```bash
        source /tensorflow/bin/activate
        ```

* Anaconda environment ([conda env](https://conda.io/docs/using/envs.html)) containing:
    - conda environment `tensorflow`
    - Python 3.4.2
    - `tensorflow`, `keras` and `h5py`
    - Activate this environment using
        ```bash
        source activate tensorflow
        ```
* The R package `reticulate` (available on [CRAN](https://cran.r-project.org/web/packages/reticulate/index.html)) communicates between R and python.
* The `reticulate` package needs to know where python is installed, so the repository writes environment variables into the `Renviron` file to configure `reticulate` correctly:

    ```r
    TENSORFLOW_PYTHON = "/tensorflow/bin/python"
    RETICULATE_PYTHON = "/tensorflow/bin/python"
    ```

# Docker instructions

## Pull

To pull and build the image, use:

```
docker pull andrie/tensorflowr
```

## Run

Since the repository contains `rocker/rstudio`, you can run RStudio in your web browser by pointing to [https://localhost:8787]([https://localhost:8787) if you map the ports. The following line creates a container and names it `tensorflowr`, so you can easily refer to this later.

```
docker run -d --name tensorflowr -p 8787:8787 andrie/tensorflowr
```

## Exec

To execute code inside the running container:

```
docker exec -ti tensorflowr bash
```

# Hello world

## tensorflow

To test `tensorflow`, try the `Hallo world` example from the `tensorflow` R package:

```r
library(tensorflow)
sess = tf$Session()
hello <- tf$constant('Hello, TensorFlow!')
sess$run(hello)
```

## keras

To test `keras`, try the code from the `kerasR` [vignette](https://cran.r-project.org/web/packages/kerasR/vignettes/introduction.html):

```r
library(kerasR)
mod <- Sequential()
mod$add(Dense(units = 50, input_shape = 13))
mod$add(Activation("relu"))
mod$add(Dense(units = 1))
keras_compile(mod,  loss = 'mse', optimizer = RMSprop())
boston <- load_boston_housing()
X_train <- scale(boston$X_train)
Y_train <- boston$Y_train
X_test <- scale(boston$X_test)
Y_test <- boston$Y_test
keras_fit(mod, X_train, Y_train,
          batch_size = 32, epochs = 200,
          verbose = 1, validation_split = 0.1)
pred <- keras_predict(mod, normalize(X_test))
sd(as.numeric(pred) - Y_test) / sd(Y_test)
```

# License

© Andrie de Vries

 [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
