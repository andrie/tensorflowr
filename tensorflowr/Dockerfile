FROM andrie/reticulate

ENV CRAN_MIRROR https://mran.microsoft.com/snapshot/2017-04-01

# install tensorflow

# create virtualenv at /tensorflow and install tensorflow as well as keras

RUN mkdir /tensorflow \
	&& virtualenv --system-site-packages /tensorflow
RUN . /tensorflow/bin/activate \
	&& pip3 install --upgrade \
		tensorflow \
		keras \
		h5py

# create conda env and install tensorflow as well as keras

RUN conda create python=3.4.2 -n tensorflow
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN . activate tensorflow \
	&& pip install \
		tensorflow \
		keras \
		h5py

# install R packages for tensorflow and keras

RUN install2.r --repos ${CRAN_MIRROR}\
		kerasR \
	&& R -e 'devtools::install_github("rstudio/tensorflow", ref = "v0.7")' # released on 2017-03-10

RUN echo 'options(repos = c(CRAN = "'.$CRAN_MIRROR.'"), download.file.method = "libcurl")' >> /etc/R/Rprofile.site \
	&& echo 'TENSORFLOW_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron \
	&& echo 'RETICULATE_PYTHON = "/tensorflow/bin/python"' >> /usr/local/lib/R/etc/Renviron

# Run rocker/rstudio init
CMD ["/init"]
