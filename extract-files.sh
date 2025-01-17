#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=x00ad
VENDOR=asus

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib64/com.quicinc.cne.api@1.0.so)
            "${PATCHELF}" --remove-needed "libhidltransport.so" "${2}"
            "${PATCHELF}" --remove-needed "libhwbinder.so" "${2}"
            ;;
        vendor/lib64/com.quicinc.cne.constants@1.0.so)
            "${PATCHELF}" --remove-needed "libhidltransport.so" "${2}"
            "${PATCHELF}" --remove-needed "libhwbinder.so" "${2}"
            ;;
        vendor/lib64/libcneapiclient.so)
            "${PATCHELF}" --remove-needed "libhidltransport.so" "${2}"
            "${PATCHELF}" --remove-needed "libhwbinder.so" "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"
extract "${MY_DIR}/proprietary-files-twrp.txt" "${SRC}" "${KANG}" --section "${SECTION}"

TWRP_QSEECOMD="${ANDROID_ROOT}"/vendor/"${VENDOR}"/"${DEVICE}"/proprietary/recovery/root/sbin/qseecomd

sed -i "s|/system/bin/linker64|/sbin/linker64\x0\x0\x0\x0\x0\x0|g" "${TWRP_QSEECOMD}"

"${MY_DIR}/setup-makefiles.sh"
