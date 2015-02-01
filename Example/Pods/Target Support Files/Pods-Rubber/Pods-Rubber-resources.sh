#!/bin/sh
set -e

mkdir -p "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --reference-external-strings-file --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "rsync -av ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -av "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1"`.mom\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd\""
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd"
      ;;
    *.xcmappingmodel)
      echo "xcrun mapc \"${PODS_ROOT}/$1\" \"${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm\""
      xcrun mapc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcmappingmodel`.cdm"
      ;;
    *.xcassets)
      ;;
    /*)
      echo "$1"
      echo "$1" >> "$RESOURCES_TO_COPY"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
          install_resource "FontAwesome+iOS/Resources/FontAwesome.ttf"
                    install_resource "../../Fonts/Amatic_SC/AmaticSC-Bold.ttf"
                    install_resource "../../Fonts/Amatic_SC/AmaticSC-Regular.ttf"
                    install_resource "../../Fonts/Anton/Anton.ttf"
                    install_resource "../../Fonts/Audiowide/Audiowide-Regular.ttf"
                    install_resource "../../Fonts/Bangers/Bangers.ttf"
                    install_resource "../../Fonts/Chewy/Chewy.ttf"
                    install_resource "../../Fonts/Comfortaa/Comfortaa-Bold.ttf"
                    install_resource "../../Fonts/Comfortaa/Comfortaa-Light.ttf"
                    install_resource "../../Fonts/Comfortaa/Comfortaa-Regular.ttf"
                    install_resource "../../Fonts/Coming_Soon/ComingSoon.ttf"
                    install_resource "../../Fonts/Dancing_Script/DancingScript-Bold.ttf"
                    install_resource "../../Fonts/Dancing_Script/DancingScript-Regular.ttf"
                    install_resource "../../Fonts/Francois_One/FrancoisOne.ttf"
                    install_resource "../../Fonts/Indie_Flower/IndieFlower.ttf"
                    install_resource "../../Fonts/Lobster/Lobster-Regular.ttf"
                    install_resource "../../Fonts/Maven_Pro/MavenPro-Black.ttf"
                    install_resource "../../Fonts/Maven_Pro/MavenPro-Bold.ttf"
                    install_resource "../../Fonts/Maven_Pro/MavenPro-Medium.ttf"
                    install_resource "../../Fonts/Maven_Pro/MavenPro-Regular.ttf"
                    install_resource "../../Fonts/Orbitron/Orbitron-Black.ttf"
                    install_resource "../../Fonts/Orbitron/Orbitron-Bold.ttf"
                    install_resource "../../Fonts/Orbitron/Orbitron-Medium.ttf"
                    install_resource "../../Fonts/Orbitron/Orbitron-Regular.ttf"
                    install_resource "../../Fonts/Pacifico/Pacifico.ttf"
                    install_resource "../../Fonts/Permanent_Marker/PermanentMarker.ttf"
                    install_resource "../../Fonts/Playball/Playball-Regular.ttf"
                    install_resource "../../Fonts/Poiret_One/PoiretOne-Regular.ttf"
                    install_resource "../../Fonts/PT_Sans/PT_Sans-Web-Bold.ttf"
                    install_resource "../../Fonts/PT_Sans/PT_Sans-Web-BoldItalic.ttf"
                    install_resource "../../Fonts/PT_Sans/PT_Sans-Web-Italic.ttf"
                    install_resource "../../Fonts/PT_Sans/PT_Sans-Web-Regular.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-Bold.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-ExtraBold.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-ExtraLight.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-Heavy.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-Light.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-Medium.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-Regular.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-SemiBold.ttf"
                    install_resource "../../Fonts/Raleway/Raleway-Thin.ttf"
                    install_resource "../../Fonts/Satisfy/Satisfy-Regular.ttf"
                    install_resource "../../Fonts/Shadows_Into_Light/ShadowsIntoLight.ttf"
          
rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
if [[ "${ACTION}" == "install" ]]; then
  rsync -avr --copy-links --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${INSTALL_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
rm -f "$RESOURCES_TO_COPY"

if [[ -n "${WRAPPER_EXTENSION}" ]] && [ "`xcrun --find actool`" ] && [ `find . -name '*.xcassets' | wc -l` -ne 0 ]
then
  case "${TARGETED_DEVICE_FAMILY}" in
    1,2)
      TARGET_DEVICE_ARGS="--target-device ipad --target-device iphone"
      ;;
    1)
      TARGET_DEVICE_ARGS="--target-device iphone"
      ;;
    2)
      TARGET_DEVICE_ARGS="--target-device ipad"
      ;;
    *)
      TARGET_DEVICE_ARGS="--target-device mac"
      ;;
  esac
  find "${PWD}" -name "*.xcassets" -print0 | xargs -0 actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${IPHONEOS_DEPLOYMENT_TARGET}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
fi
