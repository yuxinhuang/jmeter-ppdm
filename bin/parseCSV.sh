#!/bin/bash
# arg[1] jmx file directory
# arg[2] csv file directory

{
	RESULT_DIR=test_results
	# Check the file is exists or not
	if [ -d "$RESULT_DIR" ]; then
	   # Remove  the file with permission
	   rm -rf $RESULT_DIR;
	   echo "Removed original $RESULT_DIR folder";
	fi


	read
	while IFS=, read -r testNum IP URI port username password verb numRequests numThreads bodyFile testDuration numLoops rampUpTime
	do
		echo "Test Number : $testNum"
	    jmeter -n -t $1 -J testNum=$testNum -J IP=$IP -J URI=${URI//////} -J port=$port -J username=$username -J password=$password -J verb=$verb -J numRequests=$numRequests -J numThreads=$numThreads -J bodyFile=$bodyFile -J numLoops=$numLoops -J rampUpTime=$rampUpTime -J testDuration=$testDuration -l test_results\\test_$testNum\\test_result.jtl
	 	jmeter -g test_results\\test_$testNum\\test_result.jtl -o test_results\\test_$testNum\\logs
	done 
} < $2

