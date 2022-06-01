#! /bin/sh

iverilog -o test.out "${PWD##*/}".v test_"${PWD##*/}".v
./test.out
gtkwave dump.vcd
rm test.out
rm dump.vcd
