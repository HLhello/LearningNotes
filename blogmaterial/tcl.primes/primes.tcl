#!/usr/bin/tclsh8.6
source ./procs.tcl
set DEBUG           0

set put_str ""
set n 100
set p_list [lrepeat [expr {$n + 1}] 1]
set p_list [lreplace $p_list 0 1 0 0]

set start_us [clock microseconds]
##method 1
#for {set i 2} {$i <= $n} {incr i} {
#    if {[lindex $p_list $i] == 0} {
#        continue
#    }
#    for {set p [expr {$i * 2}]} {$p <= $n} {incr p $i} {
#        set p_list [lreplace $p_list $p $p 0]
#        #puts "composite: $p -> $p_list"
#    }
#    #if {($i != 2) && ([lindex $p_list $i])} {
#    #    append put_str "$i "
#    #}
#}

#method 2
#multiple of prime 2
for {set i 4} {$i <= $n} {incr i 2} {
    set p_list [lreplace $p_list $i $i 0]
}
#even numbers are jumped
for {set i 3} {$i <= $n} {incr i 2} {
    if {[lindex $p_list $i] == 0} {
        continue
    }
    for {set p [expr {$i * $i}]} {$p <= $n} {incr p [expr {$i * 2}]} {
        set p_list [lreplace $p_list $p $p 0]
        #puts "composite: $p -> $p_list"
    }
    #if {($i != 2) && ([lindex $p_list $i])} {
    #    append put_str "$i "
    #}
}

set end_us [clock microseconds]

set time_us [expr {$end_us - $start_us}]

set j_file "primes.dat"
if [catch {open "${j_file}" w} ofhandle] {
    puts "Cannot open ${j_file} for write !"
    return
}

set j_num 0
set j_index 0
foreach j $p_list {
    if {$j} {
        append put_str "$j_index "
        puts $ofhandle "$j_index"
        incr j_num
    }
    incr j_index
}
puts "Total $j_num primes blow $n: $put_str"
puts $ofhandle "$time_us us"