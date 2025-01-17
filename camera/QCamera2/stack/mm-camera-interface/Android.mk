LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    src/mm_camera_interface.c \
    src/mm_camera.c \
    src/mm_camera_channel.c \
    src/mm_camera_stream.c \
    src/mm_camera_thread.c \
    src/mm_camera_sock.c \
    src/cam_intf.c

ifeq ($(call is-board-platform-in-list, msm8974 msm8916 msm8226 msm8610 msm8909),true)
    LOCAL_CFLAGS += -DVENUS_PRESENT
endif

LOCAL_CFLAGS += -D_ANDROID_

LOCAL_C_INCLUDES := \
    $(LOCAL_PATH)/inc \
    $(LOCAL_PATH)/../common \
    $(call project-path-for,qcom-media)/mm-core/inc \
    system/media/camera/include

LOCAL_CFLAGS += -Wall -Wextra -Werror

LOCAL_MODULE := libmmcamera_interface
LOCAL_32_BIT_ONLY := true
LOCAL_HEADER_LIBRARIES := camera_common_headers generated_kernel_headers 
LOCAL_SHARED_LIBRARIES := libdl libcutils liblog
LOCAL_MODULE_TAGS := optional
LOCAL_VENDOR_MODULE := true

include $(BUILD_SHARED_LIBRARY)
