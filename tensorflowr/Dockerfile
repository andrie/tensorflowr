FROM andrie/reticulate

ENV CRAN_MIRROR https://mran.microsoft.com/snapshot/2017-06-15

# install tensorflow

# create virtualenv at /tensorflow and install tensorflow as well as keras

# To use kerasR::plot_model()

RUN apt-get install -y \
    graphviz \
	libgraphviz-dev \
	libpng-dev

RUN mkdir /tensorflow \
	&& virtualenv -p python3.4 --system-site-packages /tensorflow

RUN . /tensorflow/bin/activate \
	&& pip3 install --upgrade \
		h5py \
		pydot \
		graphviz \
		tensorflow \
		tensorboard \
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
		tensorboard \
		keras

# install R packages for tensorflow and keras

RUN install2.r --repos ${CRAN_MIRROR}\
		kerasR \
		png \
	&& R -e 'devtools::install_github("rstudio/tensorflow", ref = "v0.8.2")' # released on 2017-06-12

RUN echo 'options(repos = c(CRAN = "'$CRAN_MIRROR'"), download.file.method = "libcurl")' >> /usr/local/lib/R/etc/Rprofile.site \
	&& echo 'TENSORFLOW_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron \
	&& echo 'RETICULATE_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron

# Expose port for tensorboard
RUN mkdir /tensorboard_logs
# Start running tensorboard when container is launched

RUN echo '. /tensorflow/bin/activate' >> /init_tensorboard \
    && echo 'tensorboard --logdir=/tensorboard_logs' >> /init_tensorboard \
	&& chmod +x /init_tensorboard

# ENTRYPOINT [".", "/tensorflow/bin/activate"]
# ENTRYPOINT ["/init_tensorboard"]
EXPOSE 6006 

# Run rocker/rstudio init

ENTRYPOINT ["/init"]
