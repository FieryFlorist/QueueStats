# QueueStats
Checks the status of the submit queues on the cluster I used. This script assumes your server is slurm-based.

The code loops through each queue in the array listed at the top, and calculates the maximum node-hours remaining for all jobs in the queue as well as the number of active nodes in each queue and the hours per node remaining.

I use this to help plan out which queues to submit my jobs to.
