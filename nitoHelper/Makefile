GO_EASY_ON_ME=1
FW_DEVICE_IP=kbtv2.local
export SDKVERSION=4.3
TOOL_NAME := nitoHelper
nitoHelper_FILES = nitoHelper.m nitoHelperClass.m
nitoHelper_PACKAGE_TARGET_DIR = /usr/bin
nitoHelper_LDFLAGS = -framework Foundation #-framework BackRow

include theos/makefiles/common.mk
include theos/makefiles/tool.mk

after-nitoHelper-stage::
	$(FAKEROOT) cp $(FW_STAGING_DIR)/usr/bin/nitoHelper ../layout/usr/bin/nitoHelper
	$(FAKEROOT) chmod 6755 ../layout/usr/bin/nitoHelper
