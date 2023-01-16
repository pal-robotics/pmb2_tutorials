FROM osrf/ros:noetic-desktop-full-focal

LABEL maintainer="Yue Erro <yue.erro@pal-robotics.com>"

ARG REPO_WS=/pmb2_public_ws
RUN mkdir -p $REPO_WS/src
WORKDIR $REPO_WS

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    libv4l-dev \
    libv4l2rds0 \
    libsuitesparse-dev \
    git \
    wget \
    vim \
    locales \
    dpkg \
    ssh \
    curl \
    aptitude \
    g++ \
    gcc \
    openvpn \
    gnupg \
    bash-completion \
    vim-gtk3 \
    nano \
    psmisc \
    ccache \
    gdb \
    qtcreator \
    htop \
    man \
    meld \
    silversearcher-ag \
    terminator \
    tig \
    valgrind \
    iputils-ping \
    python-is-python3 \
    ipython3 \
    python3-scipy \
    python3-wstool \
    python3-networkx \
    python3-pip  \
    python3-vcstool \
    python3-rosinstall \
    python3-catkin-tools \
    python3-future \
    ros-noetic-amcl \
    ros-noetic-costmap-2d \
    ros-noetic-costmap-converter \
    ros-noetic-four-wheel-steering-msgs \
    ros-noetic-global-plianner \
    ros-noetic-libg2o \
    ros-noetic-map-server \
    ros-noetic-mbf-costmap-core \
    ros-noetic-mbf-msgs \
    ros-noetic-move-base \
    ros-noetic-people-msgs \
    ros-noetic-twist-mux \
    ros-noetic-slam-gmapping \
    ros-noetic-urdf-geometry-parser \
  && rm -rf /var/lib/apt/lists/* \
  && wget https://raw.githubusercontent.com/pal-robotics/pmb2_tutorials/noetic-devel/pmb2_public-noetic.rosinstall \
  && vcs import src < pmb2_public-noetic.rosinstall

ARG ROSDEP_IGNORE=""

RUN apt-get update && rosdep install --from-paths src --ignore-src -y --rosdistro noetic --skip-keys="${ROSDEP_IGNORE}"

RUN bash -c "source /opt/ros/noetic/setup.bash \
  && catkin build -DCATKIN_ENABLE_TESTING=0 -j $(expr `nproc` / 2) \
  && echo 'source $REPO_WS/devel/setup.bash' >> ~/.bashrc"
