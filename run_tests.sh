#!/bin/bash
set -u

read -r -d '' HELP <<- EOM
Run WatchTester integration tests.\n
Requires a running iOS + watchOS simulator pair.\n
Flags: \n
\0     -h (--help) - print this message.\n
\0     -j (--junit) - run the test and generate an HTML test and coverage reports. Silences test logs.
EOM

GENERATE_JUNIT_REPORT=false

#for arg in "$@"
#do
#    case $arg in
#        -j|--junit)
#        echo "Due to some breaking changes in Flutter v1.13, junit report generation support is dropped until min Flutter SDK used is at least v1.13"
#        exit 1;
#        GENERATE_JUNIT_REPORT=true
#        shift
#        ;;
#        -h|--help)
#        echo -e $HELP
#        exit 0;
#        ;;
#    esac
#done

#if [[ ! -d build ]]
#then mkdir build
#fi
#rm build/test_script_log.log
#touch build/test_script_log.log
#
#if [ ! -f pubspec.yaml ]
#then
#	echo "pubspec.yaml not found. Run the script in Flutter project root."
#	exit;
#fi

MY_BUILD_DIR=$(pwd)/build

# Get the running sim ID
#
DEVICE_PAIR=$(xcrun simctl list | sed -n '/Device Pairs/,$p' | sed -n '/active, connected/,$p' | head -3)
BUNDLEID=$(xcodebuild  -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER | rev | cut -d" " -f1 | rev)

if [ -z "$DEVICE_PAIR" ]
then
  echo "This script needs a running Simulator with a paired watch to run the app."
  exit;
else
  if [ -z "$BUNDLEID" ]
    then
      echo "Could not retreive Product Bundle Identifier from Xcode project. You'll need to launch the app manually once build is finished."
    else
      echo "Application $BUNDLEID:"
  fi
  echo "Building for the device pair: $DEVICE_PAIR"
  echo "Build directory: $MY_BUILD_DIR"
fi

PHONE=$(echo "$DEVICE_PAIR" | grep 'Phone' | grep -oE '[A-Z0-9-]{36}')
WATCH=$(echo "$DEVICE_PAIR" | grep 'Watch' | grep -oE '[A-Z0-9-]{36}')

WATCH_SCHEME="Watch"

#flutter pub get

#echo "Running pod install..."
#(cd ios && pod install)

# Run flutter build to generate needed files for xcodebuild
# flutter build ios -t test_integration/main.dart > /dev/null 2>&1

#flutter logs -d $PHONE > build/test_script_log.log &

echo "Cleaning out old installations..."
xcrun simctl terminate "$PHONE" "$BUNDLEID"
xcrun simctl uninstall "$WATCH" "$BUNDLEID.watchkitapp"
xcrun simctl uninstall "$PHONE" "$BUNDLEID"

echo "Building app..."

(xcodebuild                                    \
-workspace WatchTesterApp.xcworkspace 	      \
-scheme "WatchTesterApp"                          \
-destination "platform=iOS Simulator,id=${PHONE}" \
BUILD_DIR=$MY_BUILD_DIR                           \
COMPILER_INDEX_STORE_ENABLE=NO | xcpretty)
echo "Done"

echo "Installing app..."
xcrun simctl install "$PHONE" "build/Debug-iphoneos/WatchTesterApp.app"
#xcrun simctl install "$WATCH" ""$MY_BUILD_DIR"/Debug-watchos/Watch.app"

#xcrun simctl launch $PHONE $BUNDLEID
#xcrun simctl launch $WATCH $BUNDLEID.watchkitapp

# Wait for observatory URL in logs file and save the URL to enviroment variable
#until CONNECTION_URL=$(sed -n 's/^.*Observatory listening on[[:space:]]*//p' build/test_script_log.log) && echo $CONNECTION_URL | grep -m 1 "http"; do :
#echo 'Waiting for Observatory url...'
#sleep 1;
#done
#
#export VM_SERVICE_URL=$CONNECTION_URL
#
#
#function testAndGenerateReport {
#    mkdir build/integration-junit-out
#    touch build/integration-junit-out/junit_report.xml
#    touch build/integration_test_output.log
#    # Run tests
#    flutter test -j 1 --machine test_integration/integration_test.dart | pub global run junitreport:tojunit -o build/integration-junit-out/junit_report.xml
#
#    echo "Tests finished. Generating reports..."
#
#    # Gather coverage logs
#    pub global run coverage:collect_coverage --uri=$VM_SERVICE_URL -o build/coverage/coverage.json --resume-isolates
#    # Format coverage logs to json file
#    pub global run coverage:format_coverage --packages=.packages --report-on=lib/ -i build/coverage/coverage.json -o build/coverage/coverage.info -l -v
#    # Generate coverage html report from coverage.json file
#    genhtml -o build/coverage/html build/coverage/coverage.info
#
#    # Generate the junit html report
#    mkdir build/integration-test-report
#    junit2html build/integration-junit-out/junit_report.xml build/integration-test-report/report.html
#
#    rm build/integration_test_output.log
#    rm build/integration-junit-out/junit_report.xml
#
#    open build/coverage/html/index.html
#    open build/integration-test-report/report.html
#}
#
#function runTest {
#    flutter test -j 1 test_integration/integration_test.dart
#}
#
#CODE=0
#echo "Running tests..."
#echo "It may take a few seconds for the Greybox Tester to connect."
#if [[ $GENERATE_JUNIT_REPORT == true ]]
#then
#    testAndGenerateReport
#    echo "Done!";
#else
#    runTest
#fi
#CODE=$?
## rm build/test_script_log.log
#exit $CODE;
#
