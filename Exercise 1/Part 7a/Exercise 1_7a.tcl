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

# Open the Trace files
set tracefile1 [open out1_7a.tr w]
$ns trace-all $tracefile1
# Open the NAM trace file
set namfile [open out1_7a.nam w]
$ns namtrace-all $namfile

set window1 [open window1_7a.txt w]
set window0 [open window1_7a_0.txt w]
set window8 [open window1_7a_8.txt w]
set window9 [open window1_7a_9.txt w]
set window10 [open window1_7a_10.txt w]

# Define a 'finish' procedure
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	# exec nam out1_2.nam &
	exec perl Throughput.pl out1_7a.tr 1 1 0.2 > thpTCP.txt
	exec perl Throughput.pl out1_7a.tr 0 2 0.2 > thpTCP0.txt
	exec perl Throughput.pl out1_7a.tr 8 8 0.2 > thpTCP8.txt
	exec perl Throughput.pl out1_7a.tr 9 9 0.2 > thpTCP9.txt
	exec perl Throughput.pl out1_7a.tr 10 10 0.2 > thpTCP10.txt
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

# Schedule events
$ns at 0.1 "$ftp6_1 start"
$ns at 0.1 "$ftp6_0 start"
$ns at 0.1 "$ftp6_8 start"
$ns at 0.1 "$ftp6_9 start"
$ns at 0.1 "$ftp6_10 start"
$ns at 9.9 "$ftp6_1 stop"
$ns at 9.9 "$ftp6_0 stop"
$ns at 9.9 "$ftp6_8 stop"
$ns at 9.9 "$ftp6_9 stop"
$ns at 9.9 "$ftp6_10 stop"

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

# Sample the bottleneck queue every 0.1 sec. Store the trace in qm1_1.out
set qmon [$ns monitor-queue $n4 $n3 [open qm1_7a.out w] 0.1];
[$ns link $n4 $n3] queue-sample-timeout; # [$ns link $n4 $n3] start-tracing

$ns at 10.0 "finish"
$ns run
