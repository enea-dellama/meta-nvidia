SUMMARY = "NVidia Binary Graphics Driver"
LICENSE = "NVIDIA-Proprietary"
LIC_FILES_CHKSUM = "file://../LICENSE;md5=01c5e23f445259a6d1b4867efec45d22"

NVIDIA_ARCHIVE_NAME = "NVIDIA-Linux-${TARGET_ARCH}-${PV}"
NVIDIA_SRC = "${WORKDIR}/${NVIDIA_ARCHIVE_NAME}"
# https://us.download.nvidia.com/tesla/${PV}/${NVIDIA_ARCHIVE_NAME}.run
SRC_URI = " \
		https://us.download.nvidia.com/tesla/550.54.15/NVIDIA-Linux-x86_64-550.54.15.run \
"

S = "${NVIDIA_SRC}/kernel"

do_unpack() {
	chmod +x ${DL_DIR}/NVIDIA-Linux-x86_64-550.54.15.run
	rm -rf ${NVIDIA_SRC}
	${DL_DIR}/NVIDIA-Linux-x86_64-550.54.15.run -x --target ${NVIDIA_SRC}
}

do_make_scripts[noexec] = "1"
