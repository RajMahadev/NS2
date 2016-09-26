# Excercise 1: Bandwidth restrictions on KotNet
# Part 2
# Author: Matthias Moulin
# Course: Computer Networks
set ns [new Simulator]

# Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red
$ns color 8 Red
$ns color 9 Red
$ns color 10 Red
$ns color 11 Red
$ns color 12 Red
$ns color 13 Red
$ns color 14 Red
$ns color 15 Red

# Open the Trace files
set tracefile1 [open out1_6a.tr w]
$ns trace-all $tracefile1
# Open the NAM trace file
set namfile [open out1_6a.nam w]
$ns namtrace-all $namfile

set window1 [open window1_6a.txt w]
set window0 [open window1_6a_0.txt w]
set window8 [open window1_6a_8.txt w]
set window9 [open window1_6a_9.txt w]
set window10 [open window1_6a_10.txt w]
set window11 [open window1_6a_11.txt w]
set window12 [open window1_6a_12.txt w]
set window13 [open window1_6a_13.txt w]
set window14 [open window1_6a_14.txt w]
set window15 [open window1_6a_15.txt w]

# Define a 'finish' procedure
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	# exec nam out1_2.nam &
	exec perl Throughput.pl out1_6a.tr 1 1 0.2 > thpTCP.txt
	exec perl Throughput.pl out1_6a.tr 0 2 0.2 > thpTCP0.txt
	exec perl Throughput.pl out1_6a.tr 8 8 0.2 > thpTCP8.txt
	exec perl Throughput.pl out1_6a.tr 9 9 0.2 > thpTCP9.txt
	exec perl Throughput.pl out1_6a.tr 10 10 0.2 > thpTCP10.txt
	exec perl Throughput.pl out1_6a.tr 11 11 0.2 > thpTCP11.txt
	exec perl Throughput.pl out1_6a.tr 12 12 0.2 > thpTCP12.txt
	exec perl Throughput.pl out1_6a.tr 13 13 0.2 > thpTCP13.txt
	exec perl Throughput.pl out1_6a.tr 14 14 0.2 > thpTCP14.txt
	exec perl Throughput.pl out1_6a.tr 15 15 0.2 > thpTCP15.txt
	exec gnuplot Gnu.txt
	exit 0
}

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]

# Create links between nodes
$ns duplex-link $n0 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n1 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n2 $n3 10Mb 0.2ms DropTail
$ns simplex-link $n3 $n4 2Mb 0.2ms DropTail
$ns simplex-link $n4 $n3 40Mb 0.2ms DropTail
$ns duplex-link $n4 $n5 100Mb 0.3ms DropTail
$ns duplex-link $n5 $n6 100Mb 0.3ms DropTail
$ns duplex-link $n5 $n7 100Mb 0.3ms DropTail

$ns duplex-link $n8 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n9 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n10 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n11 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n12 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n13 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n14 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n15 $n2 10Mb 0.2ms DropTail

# Set Queue Size of link(s)

# Give node position (for NAM)
$ns duplex-link-op $n0 $n2 orient right-up
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n2 $n3 orient right
$ns simplex-link-op $n3 $n4 orient right
$ns simplex-link-op $n4 $n3 orient left
$ns duplex-link-op $n4 $n5 orient right
$ns duplex-link-op $n5 $n6 orient right-up
$ns duplex-link-op $n5 $n7 orient right-down

$ns duplex-link-op $n8 $n2 orient right
$ns duplex-link-op $n9 $n2 orient right
$ns duplex-link-op $n10 $n2 orient right
$ns duplex-link-op $n11 $n2 orient right
$ns duplex-link-op $n12 $n2 orient right
$ns duplex-link-op $n13 $n2 orient right
$ns duplex-link-op $n14 $n2 orient right
$ns duplex-link-op $n15 $n2 orient right

# Set up a TCP connection
set tcp6_1 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_1
set sink6_1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink6_1
$ns connect $tcp6_1 $sink6_1
$tcp6_1 set fid_ 1
$tcp6_1 set packetSize_ 1000
$tcp6_1 set window_ 80

# Set up a FTP over TCP connection
set ftp6_1 [new Application/FTP]
$ftp6_1 attach-agent $tcp6_1

# Set up a TCP connection
set tcp6_0 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_0
set sink6_0 [new Agent/TCPSink]
$ns attach-agent $n0 $sink6_0
$ns connect $tcp6_0 $sink6_0
$tcp6_0 set fid_ 2
$tcp6_0 set packetSize_ 1000
$tcp6_0 set window_ 80

# Set up a FTP over TCP connection
set ftp6_0 [new Application/FTP]
$ftp6_0 attach-agent $tcp6_0

# Set up a TCP connection
set tcp6_8 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_8
set sink6_8 [new Agent/TCPSink]
$ns attach-agent $n8 $sink6_8
$ns connect $tcp6_8 $sink6_8
$tcp6_8 set fid_ 8
$tcp6_8 set packetSize_ 1000
$tcp6_8 set window_ 80

# Set up a FTP over TCP connection
set ftp6_8 [new Application/FTP]
$ftp6_8 attach-agent $tcp6_8

# Set up a TCP connection
set tcp6_9 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_9
set sink6_9 [new Agent/TCPSink]
$ns attach-agent $n9 $sink6_9
$ns connect $tcp6_9 $sink6_9
$tcp6_9 set fid_ 9
$tcp6_9 set packetSize_ 1000
$tcp6_9 set window_ 80

# Set up a FTP over TCP connection
set ftp6_9 [new Application/FTP]
$ftp6_9 attach-agent $tcp6_9

# Set up a TCP connection
set tcp6_10 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_10
set sink6_10 [new Agent/TCPSink]
$ns attach-agent $n10 $sink6_10
$ns connect $tcp6_10 $sink6_10
$tcp6_10 set fid_ 10
$tcp6_10 set packetSize_ 1000
$tcp6_10 set window_ 80

# Set up a FTP over TCP connection
set ftp6_10 [new Application/FTP]
$ftp6_10 attach-agent $tcp6_10

# Set up a TCP connection
set tcp6_11 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_11
set sink6_11 [new Agent/TCPSink]
$ns attach-agent $n11 $sink6_11
$ns connect $tcp6_11 $sink6_11
$tcp6_11 set fid_ 11
$tcp6_11 set packetSize_ 1000
$tcp6_11 set window_ 80

# Set up a FTP over TCP connection
set ftp6_11 [new Application/FTP]
$ftp6_11 attach-agent $tcp6_11

# Set up a TCP connection.
set tcp6_12 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_12
set sink6_12 [new Agent/TCPSink]
$ns attach-agent $n12 $sink6_12
$ns connect $tcp6_12 $sink6_12
$tcp6_12 set fid_ 12
$tcp6_12 set packetSize_ 1000
$tcp6_12 set window_ 80

# Set up a FTP over TCP connection
set ftp6_12 [new Application/FTP]
$ftp6_12 attach-agent $tcp6_12

# Set up a TCP connection
set tcp6_13 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_13
set sink6_13 [new Agent/TCPSink]
$ns attach-agent $n13 $sink6_13
$ns connect $tcp6_13 $sink6_13
$tcp6_13 set fid_ 13
$tcp6_13 set packetSize_ 1000
$tcp6_13 set window_ 80

# Set up a FTP over TCP connection
set ftp6_13 [new Application/FTP]
$ftp6_13 attach-agent $tcp6_13

# Set up a TCP connection
set tcp6_14 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_14
set sink6_14 [new Agent/TCPSink]
$ns attach-agent $n14 $sink6_14
$ns connect $tcp6_14 $sink6_14
$tcp6_14 set fid_ 14
$tcp6_14 set packetSize_ 1000
$tcp6_14 set window_ 80

# Set up a FTP over TCP connection
set ftp6_14 [new Application/FTP]
$ftp6_14 attach-agent $tcp6_14

# Set up a TCP connection
set tcp6_15 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_15
set sink6_15 [new Agent/TCPSink]
$ns attach-agent $n15 $sink6_15
$ns connect $tcp6_15 $sink6_15
$tcp6_15 set fid_ 15
$tcp6_15 set packetSize_ 1000
$tcp6_15 set window_ 80

# Set up a FTP over TCP connection
set ftp6_15 [new Application/FTP]
$ftp6_15 attach-agent $tcp6_15

# Schedule events
$ns at 0.1 "$ftp6_1 start"
$ns at 0.1 "$ftp6_0 start"
$ns at 0.1 "$ftp6_8 start"
$ns at 0.1 "$ftp6_9 start"
$ns at 0.1 "$ftp6_10 start"
$ns at 0.1 "$ftp6_11 start"
$ns at 0.1 "$ftp6_12 start"
$ns at 0.1 "$ftp6_13 start"
$ns at 0.1 "$ftp6_14 start"
$ns at 0.1 "$ftp6_15 start"
$ns at 9.9 "$ftp6_1 stop"
$ns at 9.9 "$ftp6_0 stop"
$ns at 9.9 "$ftp6_8 stop"
$ns at 9.9 "$ftp6_9 stop"
$ns at 9.9 "$ftp6_10 stop"
$ns at 9.9 "$ftp6_11 stop"
$ns at 9.9 "$ftp6_12 stop"
$ns at 9.9 "$ftp6_13 stop"
$ns at 9.9 "$ftp6_14 stop"
$ns at 9.9 "$ftp6_15 stop"

# Printing the window size
proc plotWindow {tcpSource file} {
	global ns
	set time 0.1
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $file "$now $cwnd"
	$ns at [expr $now+$time] "plotWindow $tcpSource $file"
}
$ns at 0 "plotWindow $tcp6_1 $window1"
$ns at 0 "plotWindow $tcp6_0 $window0"
$ns at 0 "plotWindow $tcp6_8 $window8"
$ns at 0 "plotWindow $tcp6_9 $window9"
$ns at 0 "plotWindow $tcp6_10 $window10"
$ns at 0 "plotWindow $tcp6_11 $window11"
$ns at 0 "plotWindow $tcp6_12 $window12"
$ns at 0 "plotWindow $tcp6_13 $window13"
$ns at 0 "plotWindow $tcp6_14 $window14"
$ns at 0 "plotWindow $tcp6_15 $window15"

# Sample the bottleneck queue every 0.1 sec. Store the trace in qm1_1.out
set qmon [$ns monitor-queue $n4 $n3 [open qm1_6a.out w] 0.1];
[$ns link $n4 $n3] queue-sample-timeout; # [$ns link $n4 $n3] start-tracing

$ns at 10.0 "finish"
$ns run
