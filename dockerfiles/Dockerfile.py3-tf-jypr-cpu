# alex-keras:cpu - Keras in Docker with Python 3 and TensorFlow on CPU

FROM debian:stretch
MAINTAINER Alex Kim "alexgkim205@gmail.com"

# install debian packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # install essentials
    build-essential \
    g++ \
    git \
    openssh-client \
    # install python 3
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-virtualenv \
    python3-wheel \
    pkg-config \
    # requirements for numpy
    libopenblas-base \
    python3-numpy \
    python3-scipy \
    # requirements for keras
    python3-h5py \
    python3-yaml \
    python3-pydot \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# manually update numpy
RUN pip3 --no-cache-dir install -U numpy==1.13.3

ARG TENSORFLOW_VERSION=1.5.0
ARG TENSORFLOW_DEVICE=cpu
ARG TENSORFLOW_APPEND=
RUN pip3 --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/${TENSORFLOW_DEVICE}/tensorflow${TENSORFLOW_APPEND}-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl

ARG KERAS_VERSION=2.1.4
ENV KERAS_BACKEND=tensorflow
RUN pip3 --no-cache-dir install --no-dependencies git+https://github.com/fchollet/keras.git@${KERAS_VERSION}

# install additional debian packages
RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # system tools
    sudo \
    less \
    procps \
    vim-tiny \
    # build dependencies
    build-essential \
    libffi-dev \
    # visualization (Python 2 and 3)
    python3-matplotlib \
    python3-pillow \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install additional python packages
RUN pip3 --no-cache-dir install \
    # jupyter notebook and ipython (Python 3)
    jupyter \
    jupyter-kernel-gateway \
    jupyter-tensorboard \
    ipython \
    ipykernel \
    # data analysis (Python 3)
    pandas \
    scikit-learn \
    statsmodels \
 && python3 -m ipykernel.kernelspec

# configure console
RUN echo 'alias ll="ls --color=auto -alF"' >> /root/.bashrc
ENV SHELL=/bin/bash

RUN jupyter notebook --version \
 && jupyter nbextension list 2>&1 \
 && python3 -c "import numpy; print(numpy.__version__)" \
 && python3 -c "import tensorflow; print(tensorflow.__version__)" \
 && MPLBACKEND=Agg python3 -c "import matplotlib.pyplot" \
 && rm -rf /tmp/* \
 && dpkg-query -l > /dpkg-query-l.txt \
 && pip3 freeze > /pip3-freeze.txt

# run as user 1000
RUN useradd --create-home --uid 1000 --user-group --shell /bin/bash user \
 && cp -a /root/.jupyter /root/.local /root/.bashrc /home/user \
 && chown -R user:user /home/user /srv
# make user sudo
RUN  useradd admin && echo "admin:admin" | chpasswd && adduser admin sudo
USER user

# accessible only from localhost
ENV IP=*

# only password authentication (password: keras)
#ENV PASSWD='sha1:98b767162d34:8da1bc3c75a0f29145769edc977375a373407824'
#unset ENV TOKEN=
# password and token authentication (password and token: keras)
ENV PASSWD='sha1:98b767162d34:8da1bc3c75a0f29145769edc977375a373407824'
ENV TOKEN='keras'
# random token authentication
#unset ENV PASSWD=
#unset ENV TOKEN=

EXPOSE 8888
WORKDIR /srv/
CMD /bin/bash -c 'jupyter notebook \
    --NotebookApp.open_browser=False \
    --NotebookApp.allow_root=True \
    --NotebookApp.ip="$IP" \
    ${PASSWD+--NotebookApp.password=\"$PASSWD\"} \
    ${TOKEN+--NotebookApp.token=\"$TOKEN\"} \
    --NotebookApp.allow_password_change=False \
    --JupyterWebsocketPersonality.list_kernels=True \
    "$@"'