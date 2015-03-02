WORKSPACE=bang.xcworkspace
SCHEME=bang
CONFIGURATION=Debug
OUTPUT_DIR=build

defualt: clean build

clean:
	xctool \
	-workspace ${WORKSPACE} \
	-scheme ${SCHEME} \
	-configuration ${CONFIGURATION} \
	clean

build:
	xctool \
	-workspace ${WORKSPACE} \
	-scheme ${SCHEME} \
	-configuration ${CONFIGURATION} \
  -sdk iphonesimulator8.1 \
	build \
  CONFIGURATION_BUILD_DIR="$(PWD)/${OUTPUT_DIR}" \
	ONLY_ACTIVE_ARCH=NO

test:
	xctool \
	-workspace ${WORKSPACE} \
	-scheme ${SCHEME} \
	test \
	-test-sdk iphonesimulator \
	-parallelize
