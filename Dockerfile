FROM rocker/rstudio:3.3.3
# install tensorflow
# using instructions at https://www.tensorflow.org/install/install_linux#InstallingVirtualenv

ENV R_BASE_VERSION 3.3.3
ENV CRAN_MIRROR https://mran.microsoft.com/snapshots/2017-04-01
ENV CRAN_MIRROR https://cran.rstudio.com

RUN apt-get update \
	&& apt-get install -y \
		libssl-dev \
		libxml2-dev \
	&& echo 'options(repos = c(CRAN = "${CRAN}"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site

# install R packages, including tensorflow and keras (python dependencies come later)

RUN install2.r --repos ${CRAN_MIRROR}\
		MASS \
		Rcpp \
		devtools \
		reticulate \
		yaml \
		kerasR \
	&& R -e 'devtools::install_github("rstudio/tensorflow")'

# install python-pip and virtualenv

RUN apt-get update \
	&& apt-get install -y \
		python-pip \
	&& pip install virtualenv \
	&& apt-get install -y \
		python-pip \
		python-dev \
		python-virtualenv

# create virtualenv at /tensorflow and install tensorflow as well as keras

RUN mkdir /tensorflow \
	&& virtualenv --system-site-packages /tensorflow \
	&& . /tensorflow/bin/activate \
	&& pip install --upgrade tensorflow \
	&& pip install keras

# finally some R stuff: install tensorflow package and configure env variable

# ENV Renviron /usr/local/lib/R/etc
ENV Renviron /etc/R/
ENV Rpython "/tensorflow/bin/python"

RUN echo 'options(repos = c(CRAN = "${CRAN_MIRROR}"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
	&& echo 'TENSORFLOW_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron \
	&& echo 'RETICULATE_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron 

# Run rocker/rstudio init
CMD ["/init"]


