SUMMARY = "NVidia Binary Graphics Driver"
LICENSE = "NVIDIA-Proprietary"
LIC_FILES_CHKSUM = "file://../LICENSE;md5=01c5e23f445259a6d1b4867efec45d22"

NVIDIA_ARCHIVE_NAME = "NVIDIA-Linux-${TARGET_ARCH}-${PV}"
NVIDIA_SRC = "${WORKDIR}/${NVIDIA_ARCHIVE_NAME}"

SRC_URI = "https://download.nvidia.com/XFree86/NVIDIA-kernel-module-source/NVIDIA-kernel-module-source-570.153.02.tar.xz"

S = "${NVIDIA_SRC}/kernel"

do_unpack() {
	rm -rf ${NVIDIA_SRC}
	tar -xf ${DL_DIR}/NVIDIA-kernel-module-source-570.153.02.tar.xz -C ${NVIDIA_SRC}
}

do_make_scripts[noexec] = "1"
