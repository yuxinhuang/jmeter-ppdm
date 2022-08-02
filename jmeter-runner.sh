#!/bin/bash
# arg[1] jmx file directory
# arg[2] csv file directory
{
	RESULT_DIR=data\\test-results;
	# Check the file is exists or not
	if [ -d "$RESULT_DIR" ]; then
	   	# Remove  the file with permission
	   	rm -rf $RESULT_DIR;
	  	echo "Removed original $RESULT_DIR folder";
	fi

	read
	while IFS=',', read -r testNum IP URI port username password verb numThreads requestsPerThread bodyFile testDuration rampUpTime || [ -n "$rampUpTime" ]
	do
		echo "Test Number : $testNum"
		TEST_DIR=$RESULT_DIR\\test-$testNum;
		POST_DIR=$TEST_DIR\\failed-post-requests;
		if [ -d "$TEST_DIR" ]; then
    			mkdir $TEST_DIR;
			mkdir $POST_DIR;
		fi
		bin\\jmeter -n -t $1 -l $TEST_DIR\\test-result.jtl -J testNum=$testNum -J IP=$IP -J URI=${URI//////} -J port=$port -J username=$username -J password=$password -J verb=$verb -J numThreads=$numThreads -J requestsPerThread=$requestsPerThread -J bodyFile=$bodyFile -J rampUpTime=$rampUpTime -J testDuration=$testDuration -J jmeter.reportgenerator.overall_granularity=1000 
		bin\\jmeter -g $TEST_DIR\\test-result.jtl -o $TEST_DIR\\dashboard-files
	done
} < $2
