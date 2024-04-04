DESCRIPTION = "Create containerd config"
LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Since we're not downloading or unpacking anything, skip those tasks
do_unpack[noexec] = "1"
do_configure[noexec] = "1"
do_compile[noexec] = "1"

inherit allarch

SRC_URI += "file://config.toml"

do_install:append() {
    install -d ${D}${sysconfdir}/containerd
    install -m 0644 ${WORKDIR}/config.toml ${D}${sysconfdir}/containerd/
}

RDEPENDS:${PN}:append = " containerd-opencontainers"
FILES:${PN}:append= "${sysconfdir}/containerd/config.toml"
