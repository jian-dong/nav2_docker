FROM ros:humble
ENV TERM xterm
ENV DEBIAN_FRONTEND=noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/
RUN echo "Asia/Shanghai" > /etc/timezone
COPY archives /tmp/archives
COPY sources.list.d/sources.list /etc/apt/
COPY sources.list.d/ros2-latest.list /etc/apt/sources.list.d/ros2-latest.list
COPY rcfiles /tmp/rcfiles
COPY installers /opt/installers
RUN bash /opt/installers/install.sh
RUN bash /opt/installers/post_install.sh

RUN rm -fr /opt/installers
ADD 10_nvidia.json /etc/glvnd/egl_vendor.d/10_nvidia.json
RUN chmod 644 /etc/glvnd/egl_vendor.d/10_nvidia.json
ADD nvidia_icd.json /etc/vulkan/icd.d/nvidia_icd.json
RUN chmod 644 /etc/vulkan/icd.d/nvidia_icd.json
ENV NVIDIA_VISIBLE_DEVICES ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
ENV RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
COPY env.sh /etc/profile.d/ade_env.sh
COPY rcfiles/zshrc /etc/skel/.zshrc
COPY entrypoint /ade_entrypoint
ENTRYPOINT ["/ade_entrypoint"]
CMD ["/bin/bash", "-c", "trap 'exit 147' TERM; tail -f /dev/null & while wait ${!}; test $? -ge 128; do true; done"]
