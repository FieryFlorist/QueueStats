#! /usr/bin/perl

@queueList = ("long", "gen3", "gen3", "debug");

print " queue | total length  |  total CPUs   | time to finish\n";
foreach $queue (@queueList)
{
        $QueueData = `squeue -h -o "%.8D %.4t %.16L" -p $queue`;
        $CPUTime = 0;
        $CPUCount = 0;
        foreach (split(/\n/, $QueueData))
        {
                # Separate different inputs
                ($empty, $nodes, $status, $time) = split(/\s+/, $_);
                # Calculate remaining time
                $lineTime = 0;
                if(index($time, "-") != -1) {
                        ($days, $hourTime) = split(/-/, $time);
                        @hms = split(/:/, $hourTime);
                        for my $i (0 .. $#hms)
                        {
                                $lineTime += 60.0**($#hms-$i) * int($hms[$i]) / 3600.0;
                        }
                        $lineTime += 24 * int($days);
                } else {
                        @hms = split(/:/, $time);
                        for my $i (0 .. $#hms)
                        {
                                $lineTime += 60.0**($#hms-$i) * int($hms[$i]) / 3600.0;
                        }
                }
                $CPUTime += int($nodes)*$lineTime;
                if ($status eq "R") {
                        $CPUCount += int($nodes);
                }
        }
        printf "%-6s |%14.4f |%14d |%14.4f\n", $queue, $CPUTime, $CPUCount, ($CPUCount>0)?($CPUTime/$CPUCount):($CPUTime);
}
