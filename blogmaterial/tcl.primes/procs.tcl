proc add_separator {x num a} {
    set x_len [string length $x]
    set space_num [expr $num-$x_len]
    append new_x $x
    append new_x [string repeat $a $space_num]
    return $new_x
}

proc printvar {x} {
    global DEBUG
    upvar 1 $x xx
    if {$DEBUG == "1"} {
        puts "DBG:\$$x = $xx"
    }
}

proc rm_files {pattern} {
    foreach f [glob -nocomplain ./$pattern] {
        file delete -force $f
    }
}