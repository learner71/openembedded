nas100d_pack_image () {
	install -d ${DEPLOY_DIR_IMAGE}/firmupgrade
	install -m 0755 ${DEPLOY_DIR_IMAGE}/zImage-nslu2${SITEINFO_ENDIANNESS}.bin \
		${DEPLOY_DIR_IMAGE}/firmupgrade/ip-ramdisk
	install -m 0644 ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}.rootfs.jffs2 \
		${DEPLOY_DIR_IMAGE}/firmupgrade/rootfs.gz
	touch ${DEPLOY_DIR_IMAGE}/firmupgrade/usr.cramfs
	chmod 0644 ${DEPLOY_DIR_IMAGE}/firmupgrade/usr.cramfs
	echo "hwid=1.0.1"      >${DEPLOY_DIR_IMAGE}/firmupgrade/version.msg
	echo "model=koala"    >>${DEPLOY_DIR_IMAGE}/firmupgrade/version.msg
	echo "vendor=iomega"  >>${DEPLOY_DIR_IMAGE}/firmupgrade/version.msg
	echo ""               >>${DEPLOY_DIR_IMAGE}/firmupgrade/version.msg
	chmod 0744 ${DEPLOY_DIR_IMAGE}/firmupgrade/version.msg
	tar -c -f ${DEPLOY_DIR_IMAGE}/${IMAGE_NAME}-nas100d.bin \
		-C ${DEPLOY_DIR_IMAGE} firmupgrade
	rm -rf ${DEPLOY_DIR_IMAGE}/firmupgrade
}

IMAGE_POSTPROCESS_COMMAND += "nas100d_pack_image; "
