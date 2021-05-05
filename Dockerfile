FROM centos:7
USER root
COPY epel.repo /etc/yum.repos.d/
RUN \
    echo "armhfp" > /etc/yum/vars/basearch && \
    echo "armv7hl" > /etc/yum/vars/arch && \
    echo "armv7hl-redhat-linux-gpu" > /etc/rpm/platform && \
    yum -y install epel-release && \
    yum -y install pugixml-devel git readline-devel zlib-devel rpm-build git-core gcc-c++ make boost-devel python-devel && \
    yum clean all && \
    cd /tmp/ && \
    git clone --branch v2.7.4 https://github.com/ipbus/ipbus-software.git && \
    sed -i '1 i\#define _GLIBCXX_USE_CXX11_ABI 0' $(find ./ipbus-software -name '*.hpp') && \
    sed -i '1 i\#define _GLIBCXX_USE_CXX11_ABI 0' $(find ./ipbus-software -name '*.hxx') && \
    sed -i '1 i\#define _GLIBCXX_USE_CXX11_ABI 0' $(find ./ipbus-software -name '*.cpp') && \
    sed -i '1 i\#define _GLIBCXX_USE_CXX11_ABI 0' $(find ./ipbus-software -name '*.cxx') && \
    cd ipbus-software/ && \
    make -j$(nproc) Set=uhal BUILD_PUGIXML=0 BUILD_UHAL_TESTS=1 BUILD_UHAL_PYCOHAL=1 && \
    make Set=uhal BUILD_PUGIXML=0 BUILD_UHAL_TESTS=1 BUILD_UHAL_PYCOHAL=1 install && \
    cd .. && \
    rm -rf ipbus-software && \
    export CACTUS_ROOT=/opt/cactus && \
    cd /tmp/ && \
    mkdir test && \
    cd test && \
    mkdir include src && \
    mkdir src/common && \
    touch include test.hpp && \
    touch src/common/test.cxx && \
    curl -O https://ipbus.web.cern.ch/doc/user/html/_downloads/8c52ef8f4a670230515a9bbfbddaf2dc/Makefile
COPY test.hpp /tmp/test/include/
COPY test.cxx /tmp/test/src/common/
COPY entrypoint_env.sh /
RUN \
    chmod a+x /entrypoint_env.sh && \
    cd tmp/test/ &&\
    make 
ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "bash" ]