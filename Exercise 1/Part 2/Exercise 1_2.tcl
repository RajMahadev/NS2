# Excercise 1: Bandwidth restrictions on KotNet
# Part 2
# Author: Matthias Moulin
# Course: Computer Networks
set ns [new Simulator]

# Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

# Open the Trace files
set tracefile1 [open out1_2.tr w]
$ns trace-all $tracefile1
# Open the NAM trace file
set namfile [open out1_2.nam w]
$ns namtrace-all $namfile

set window [open window1_2.txt w]

# Define a 'finish' procedure
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	# exec nam out1_2.nam &
	exec perl ThroughputTCP.pl out1_2.tr 1 0.2 > thpTCP.txt
	exec perl ThroughputUDP.pl out1_2.tr 7 0.2 > thpUDP.txt
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

# Create links between nodes
$ns duplex-link $n0 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n1 $n2 10Mb 0.2ms DropTail
$ns duplex-link $n2 $n3 10Mb 0.2ms DropTail
$ns simplex-link $n3 $n4 0.256Mb 0.2ms DropTail
$ns simplex-link $n4 $n3 4Mb 0.2ms DropTail
$ns duplex-link $n4 $n5 100Mb 0.3ms DropTail
$ns duplex-link $n5 $n6 100Mb 0.3ms DropTail
$ns duplex-link $n5 $n7 100Mb 0.3ms DropTail

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

# Setup a TCP connection
set tcp6_1 [new Agent/TCP]
$ns attach-agent $n6 $tcp6_1
set sink6_1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink6_1
$ns connect $tcp6_1 $sink6_1
$tcp6_1 set fid_ 1
$tcp6_1 set packetSize_ 1000
$tcp6_1 set window_ 80

# Setup a FTP over TCP connection
set ftp6_1 [new Application/FTP]
$ftp6_1 attach-agent $tcp6_1

# Set up a UDP connection
set udp0_7 [new Agent/UDP]
$ns attach-agent $n0 $udp0_7
set null0_7 [new Agent/Null]
$ns attach-agent $n7 $null0_7
$ns connect $udp0_7 $null0_7
$udp0_7 set packetSize_ 1500
$udp0_7 set fid_ 2

# Set up a CBR over UDP connection
set cbr0_7 [new Application/Traffic/CBR]
$cbr0_7 attach-agent $udp0_7
$cbr0_7 set random_ false

# Schedule events
$ns at 0.1 "$ftp6_1 start"
$ns at 3.0 "$cbr0_7 start"
$ns at 6.0 "$cbr0_7 stop"
$ns at 9.9 "$ftp6_1 stop"

# Printing the window size
proc plotWindow {tcpSource file} {
	global ns
	set time 0.1
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $file "$now $cwnd"
	$ns at [expr $now+$time] "plotWindow $tcpSource $file"
}
$ns at 0 "plotWindow $tcp6_1 $window"

# Sample the bottleneck queue every 0.1 sec. Store the trace in qm1_1.out
set qmon [$ns monitor-queue $n4 $n3 [open qm1_2.out w] 0.1];
[$ns link $n4 $n3] queue-sample-timeout; # [$ns link $n4 $n3] start-tracing

$ns at 10.0 "finish"
$ns run
