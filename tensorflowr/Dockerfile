FROM andrie/reticulate

ENV CRAN_MIRROR https://mran.microsoft.com/snapshot/2017-04-01

# install tensorflow

# create virtualenv at /tensorflow and install tensorflow as well as keras

RUN mkdir /tensorflow \
	&& virtualenv --system-site-packages /tensorflow
RUN . /tensorflow/bin/activate \
	&& pip3 install --upgrade \
		h5py \
		pydot \
		graphviz \
		tensorflow \
		keras
	
# create conda env and install tensorflow as well as keras

RUN conda create python=3.4.2 -n tensorflow
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN . activate tensorflow \
	&& pip install \
		h5py \
		pydot \
		graphviz \
		tensorflow \
		keras

# To use kerasR::plot_model()

RUN apt-get install -y \
    graphviz \
	libgraphviz-dev \
	libpng-dev

# install R packages for tensorflow and keras

RUN install2.r --repos ${CRAN_MIRROR}\
		kerasR \
		png \
	&& R -e 'devtools::install_github("rstudio/tensorflow", ref = "v0.8.2")' # released on 2017-06-12

RUN echo 'options(repos = c(CRAN = "'.$CRAN_MIRROR.'"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
	&& echo 'TENSORFLOW_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron \
	&& echo 'RETICULATE_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron


# Run rocker/rstudio init
EXPOSE 6006
CMD ["/init"]
