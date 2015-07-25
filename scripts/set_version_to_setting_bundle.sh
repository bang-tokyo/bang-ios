#!/bin/sh

APP_VERSION=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $PRODUCT_SETTINGS_PATH)
/usr/libexec/PlistBuddy -c "Set :PreferenceSpecifiers:0:DefaultValue ${APP_VERSION}" "${BUILT_PRODUCTS_DIR}/${WRAPPER_NAME}/Settings.bundle/Root.plist"
