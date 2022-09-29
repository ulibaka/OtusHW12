### Скрипт аналог ps ax

```
#!/bin/env bash

( 
echo "PID|TTY|STAT|TIME|COMMAND";

for pid in `ls -1 /proc/ | egrep '^[0-9]+' | sort -n`; do
  if [ -d /proc/$pid ]; then
    stat=`</proc/$pid/stat`
        
        cmd=`echo "$stat" | awk -F" " '{print $2}'`
        state=`echo "$stat" | awk -F" " '{print $3}'`
        tty=`echo "$stat" | awk -F" " '{print $7}'`
        utime=`echo "$stat" | awk -F" " '{print $14}'`
        stime=`echo "$stat" | awk -F" " '{print $15}'`
        ttime=$((utime + stime))
        time=$((ttime / 100))

        echo "${pid}|${tty}|${state}|${time}|${cmd}"
    fi
done ) | column -t -s "|"

```

#### Вывод

```
$ ./psax.sh 
PID     TTY    STAT      TIME   COMMAND
1       0      S         82     (systemd)
2       0      S         0      (kthreadd)
3       0      I         0      (rcu_gp)
4       0      I         0      (rcu_par_gp)
5       0      I         0      (netns)
7       0      I         0      (kworker/0:0H-events_highpri)
10      0      I         0      (mm_percpu_wq)
11      0      S         0      (rcu_tasks_rude_)
12      0      S         0      (rcu_tasks_trace)
13      0      S         9      (ksoftirqd/0)
14      0      I         258    (rcu_sched)
15      0      S         1      (migration/0)
16      0      S         0      (idle_inject/0)
...
```
