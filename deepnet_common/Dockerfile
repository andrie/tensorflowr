FROM rocker/rstudio:3.3.3
# install tensorflow
# using instructions at https://www.tensorflow.org/install/install_linux#InstallingVirtualenv

RUN apt-get update \
	&& apt-get install -y \
		libssl-dev \
		libxml2-dev

# install R packages, including tensorflow and keras (python dependencies come later, in tensorflowr Dockerfile)

RUN install2.r --repos "https://mran.microsoft.com/snapshot/2017-04-01" \
		Rcpp \
		devtools \
		roxygen2 \
		reticulate \
		yaml \
		kerasR \
	&& R -e 'devtools::install_github("rstudio/tensorflow")'

# Install conda
# (Using code from https://github.com/ContinuumIO/docker-images/blob/master/miniconda/Dockerfile )

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

# Configure environment variables 

RUN echo 'options(repos = c(CRAN = "https://mran.microsoft.com/snapshot/2017-04-01"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
	&& echo 'TENSORFLOW_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron \
	&& echo 'RETICULATE_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron 

# Run rocker/rstudio init
CMD ["/init"]


