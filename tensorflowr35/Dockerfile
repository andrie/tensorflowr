FROM andrie/deepnet_common
# install tensorflow
# using instructions at https://www.tensorflow.org/install/install_linux#InstallingVirtualenv

# create virtualenv at /tensorflow and install tensorflow as well as keras

RUN conda create -n tensorflow python=3.5
# Force bash always, to prevent error on activate
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN . activate tensorflow \
	&& pip install --ignore-installed --upgrade tensorflow \
	&& pip install keras

# Run rocker/rstudio init
CMD ["/init"]
