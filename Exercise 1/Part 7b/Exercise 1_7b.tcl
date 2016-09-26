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
set tracefile1 [open out1_6b.tr w]
$ns trace-all $tracefile1
# Open the NAM trace file
set namfile [open out1_6b.nam w]
$ns namtrace-all $namfile

# Define a 'finish' procedure
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	# exec nam out1_2.nam &
	exec perl Throughput.pl out1_6b.tr 7 1 0.2 > thpUDP.txt
	exec perl Throughput.pl out1_6b.tr 7 2 0.2 > thpUDP0.txt
	exec perl Throughput.pl out1_6b.tr 7 8 0.2 > thpUDP8.txt
	exec perl Throughput.pl out1_6b.tr 7 9 0.2 > thpUDP9.txt
	exec perl Throughput.pl out1_6b.tr 7 10 0.2 > thpUDP10.txt
	exec perl Throughput.pl out1_6b.tr 7 11 0.2 > thpUDP11.txt
	exec perl Throughput.pl out1_6b.tr 7 12 0.2 > thpUDP12.txt
	exec perl Throughput.pl out1_6b.tr 7 13 0.2 > thpUDP13.txt
	exec perl Throughput.pl out1_6b.tr 7 14 0.2 > thpUDP14.txt
	exec perl Throughput.pl out1_6b.tr 7 15 0.2 > thpUDP15.txt
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

# Set up a UDP connection
set udp1_7 [new Agent/UDP]
$ns attach-agent $n1 $udp1_7
set null1_7 [new Agent/Null]
$ns attach-agent $n7 $null1_7
$ns connect $udp1_7 $null1_7
$udp1_7 set packetSize_ 1500
$udp1_7 set fid_ 1

# Set up a CBR over UDP connection
set cbr1_7 [new Application/Traffic/CBR]
$cbr1_7 attach-agent $udp1_7
$cbr1_7 set random_ false

# Set up a UDP connection
set udp8_7 [new Agent/UDP]
$ns attach-agent $n8 $udp8_7
set null8_7 [new Agent/Null]
$ns attach-agent $n7 $null8_7
$ns connect $udp8_7 $null8_7
$udp8_7 set packetSize_ 1500
$udp8_7 set fid_ 8

# Set up a CBR over UDP connection
set cbr8_7 [new Application/Traffic/CBR]
$cbr8_7 attach-agent $udp8_7
$cbr8_7 set random_ false

# Set up a UDP connection
set udp9_7 [new Agent/UDP]
$ns attach-agent $n9 $udp9_7
set null9_7 [new Agent/Null]
$ns attach-agent $n7 $null9_7
$ns connect $udp9_7 $null9_7
$udp9_7 set packetSize_ 1500
$udp9_7 set fid_ 9

# Set up a CBR over UDP connection
set cbr9_7 [new Application/Traffic/CBR]
$cbr9_7 attach-agent $udp9_7
$cbr9_7 set random_ false

# Set up a UDP connection
set udp10_7 [new Agent/UDP]
$ns attach-agent $n10 $udp10_7
set null10_7 [new Agent/Null]
$ns attach-agent $n7 $null10_7
$ns connect $udp10_7 $null10_7
$udp10_7 set packetSize_ 1500
$udp10_7 set fid_ 10

# Set up a CBR over UDP connection
set cbr10_7 [new Application/Traffic/CBR]
$cbr10_7 attach-agent $udp10_7
$cbr10_7 set random_ false

# Set up a UDP connection
set udp11_7 [new Agent/UDP]
$ns attach-agent $n11 $udp11_7
set null11_7 [new Agent/Null]
$ns attach-agent $n7 $null11_7
$ns connect $udp11_7 $null11_7
$udp11_7 set packetSize_ 1500
$udp11_7 set fid_ 11

# Set up a CBR over UDP connection
set cbr11_7 [new Application/Traffic/CBR]
$cbr11_7 attach-agent $udp11_7
$cbr11_7 set random_ false

# Set up a UDP connection
set udp12_7 [new Agent/UDP]
$ns attach-agent $n12 $udp12_7
set null12_7 [new Agent/Null]
$ns attach-agent $n7 $null12_7
$ns connect $udp12_7 $null12_7
$udp12_7 set packetSize_ 1500
$udp12_7 set fid_ 12

# Set up a CBR over UDP connection
set cbr12_7 [new Application/Traffic/CBR]
$cbr12_7 attach-agent $udp12_7
$cbr12_7 set random_ false

# Set up a UDP connection
set udp13_7 [new Agent/UDP]
$ns attach-agent $n13 $udp13_7
set null13_7 [new Agent/Null]
$ns attach-agent $n7 $null13_7
$ns connect $udp13_7 $null13_7
$udp13_7 set packetSize_ 1500
$udp13_7 set fid_ 13

# Set up a CBR over UDP connection
set cbr13_7 [new Application/Traffic/CBR]
$cbr13_7 attach-agent $udp13_7
$cbr13_7 set random_ false

# Set up a UDP connection
set udp14_7 [new Agent/UDP]
$ns attach-agent $n14 $udp14_7
set null14_7 [new Agent/Null]
$ns attach-agent $n7 $null14_7
$ns connect $udp14_7 $null14_7
$udp14_7 set packetSize_ 1500
$udp14_7 set fid_ 14

# Set up a CBR over UDP connection
set cbr14_7 [new Application/Traffic/CBR]
$cbr14_7 attach-agent $udp14_7
$cbr14_7 set random_ false

# Set up a UDP connection
set udp15_7 [new Agent/UDP]
$ns attach-agent $n15 $udp15_7
set null15_7 [new Agent/Null]
$ns attach-agent $n7 $null15_7
$ns connect $udp15_7 $null15_7
$udp15_7 set packetSize_ 1500
$udp15_7 set fid_ 15

# Set up a CBR over UDP connection
set cbr15_7 [new Application/Traffic/CBR]
$cbr15_7 attach-agent $udp15_7
$cbr15_7 set random_ false

# Schedule events
$ns at 3.0 "$cbr0_7 start"
$ns at 3.0 "$cbr1_7 start"
$ns at 3.0 "$cbr8_7 start"
$ns at 3.0 "$cbr9_7 start"
$ns at 3.0 "$cbr10_7 start"
$ns at 3.0 "$cbr11_7 start"
$ns at 3.0 "$cbr12_7 start"
$ns at 3.0 "$cbr13_7 start"
$ns at 3.0 "$cbr14_7 start"
$ns at 3.0 "$cbr15_7 start"
$ns at 6.0 "$cbr0_7 stop"
$ns at 6.0 "$cbr1_7 stop"
$ns at 6.0 "$cbr8_7 stop"
$ns at 6.0 "$cbr9_7 stop"
$ns at 6.0 "$cbr10_7 stop"
$ns at 6.0 "$cbr11_7 stop"
$ns at 6.0 "$cbr12_7 stop"
$ns at 6.0 "$cbr13_7 stop"
$ns at 6.0 "$cbr14_7 stop"
$ns at 6.0 "$cbr15_7 stop"

# Printing the window size
proc plotWindow {tcpSource file} {
	global ns
	set time 0.1
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $file "$now $cwnd"
	$ns at [expr $now+$time] "plotWindow $tcpSource $file"
}

# Sample the bottleneck queue every 0.1 sec. Store the trace in qm1_1.out
set qmon [$ns monitor-queue $n4 $n3 [open qm1_6b.out w] 0.1];
[$ns link $n4 $n3] queue-sample-timeout; # [$ns link $n4 $n3] start-tracing

$ns at 10.0 "finish"
$ns run
