# Excercise 2
# Part 1
# Author: Matthias Moulin
# Course: Computer Networks
set ns [new Simulator]

# Define different colors for data flows (for NAM)
$ns color 1 Blue

# Open the Trace files
set tracefile1 [open out2_1.tr w]
$ns trace-all $tracefile1
# Open the NAM trace file
set namfile [open out2_1.nam w]
$ns namtrace-all $namfile

set log [open log2_1.txt w]
set window [open window2_1.txt w]

# Define a 'finish' procedure
proc finish {} {
	global ns tracefile1 namfile
	$ns flush-trace
	close $tracefile1
	close $namfile
	# exec nam out2_1.nam &
	exec perl ThroughputTCP.pl out2_1.tr 2 0.2 > thpTCP.txt
	exec gnuplot Gnu.txt
	exit 0
}

# Create nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

# Create links between nodes
$ns duplex-link $n2 $n0 10Mb 10ms DropTail
$ns duplex-link $n4 $n0 10Mb 10ms DropTail
$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns duplex-link $n1 $n3 10Mb 10ms DropTail

# Set Queue Size of link(s)
$ns queue-limit $n0 $n1 20

# Give node position (for NAM)
$ns duplex-link-op $n2 $n0 orient right-down
$ns duplex-link-op $n4 $n0 orient right-up
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n3 orient right-up

# Create nodes for web server
set NbBursts 3
set NbNodesPerBurst 40
for {set j 1} {$j <= [expr $NbBursts * $NbNodesPerBurst]} {incr j} {
	set S($j) [$ns node]
}

# Create links between nodes for web server
for {set j 1} {$j <= [expr $NbBursts * $NbNodesPerBurst]} {incr j} {
	$ns duplex-link $n1 $S($j) 10Mb 10ms DropTail
	# Give node position (for NAM)
	$ns duplex-link-op $n1 $S($j) orient right-down
}

# Setup a TCP connection for the FTP server
set tcp3_2 [new Agent/TCP]
$ns attach-agent $n3 $tcp3_2
set sink3_2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink3_2
$ns connect $tcp3_2 $sink3_2
$tcp3_2 set fid_ 1
$tcp3_2 set packetSize_ 1000
$tcp3_2 set window_ 80

# Setup a FTP over TCP connection
set ftp3_2 [new Application/FTP]
$ftp3_2 attach-agent $tcp3_2

# Setup TCP connections for the web server
for {set j 1} {$j <= [expr $NbBursts * $NbNodesPerBurst]} {incr j} {
	set tcp_src($j) [new Agent/TCP]
	$ns attach-agent $S($j) $tcp_src($j)
	set tcp_snk($j) [new Agent/TCPSink]
	$ns attach-agent $n4 $tcp_snk($j)
	$ns connect $tcp_src($j) $tcp_snk($j)
}

# Setup a FTP over TCP connections for the web server
for {set j 1} {$j <= [expr $NbBursts * $NbNodesPerBurst]} {incr j} {
	set ftp($j) [$tcp_src($j) attach-source FTP]
}

# Create random generators
set rng1 [new RNG]
$rng1 seed 0
set rng2 [new RNG]
$rng2 seed 0

# Parameters for random variables for beginning of ftp connections for the web server
set RVstart [new RandomVariable/Exponential]
$RVstart set avg_ 0.05
$RVstart use-rng $rng1

# Parameters for random variables for the size of the files of the ftp connections for the web server
set RVsize [new RandomVariable/Pareto]
$RVsize set shape_ 1.5
$RVsize set avg_ 150000
$RVsize use-rng $rng2

set start 5.0
set current $start
for {set j 1} {$j <= [expr $NbBursts * $NbNodesPerBurst]} {incr j} {
	set current [expr $current + [expr [$RVstart value]]]
	$tcp_src($j) set starts $current
	$tcp_src($j) set size [expr [$RVsize value]]
	$ns at [$tcp_src($j) set starts] "$ftp($j) send [$tcp_src($j) set size]"
	puts $log "$j [$tcp_src($j) set starts] [$tcp_src($j) set size]"
	if {[expr $j % $NbNodesPerBurst] == 0.0} {
		set start [expr $start + 5.0]
		set current $start
	}
}

# Schedule events
$ns at 0.1 "$ftp3_2 start"
$ns at 19.9 "$ftp3_2 stop"

# Printing the window size
proc plotWindow {tcpSource file} {
	global ns
	set time 0.1
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $file "$now $cwnd"
	$ns at [expr $now+$time] "plotWindow $tcpSource $file"
}
$ns at 0.0 "plotWindow $tcp3_2 $window"

# Sample the bottleneck queue every 0.1 sec. Store the trace in qm2_1.out
set qmon [$ns monitor-queue $n0 $n1 [open qm2_1.out w] 0.1];
[$ns link $n0 $n1] queue-sample-timeout; # [$ns link $n0 $n1] start-tracing

$ns at 20.0 "finish"
$ns run
