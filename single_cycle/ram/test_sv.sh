#! /bin/sh

iverilog -o test.out "${PWD##*/}".sv test_sv_"${PWD##*/}".sv -g2012
./test.out
gtkwave dump.vcd
rm test.out
rm dump.vcd
