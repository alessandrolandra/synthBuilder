# synthBuilder
Really simple script to initialize the environment and prepare a **Synopsis** synthesis script.

By running the script, a set of folders are created in the current directory and a Synopsys script is generated.\
To synthesize an architecture, its name and the one of the related entity are required, as well as the vhd filename in which they are described.\
The Synopsis script, that can be found in the directory named as the entity, analyzes, elaborates and compiles the wanted architecture and generates the ddc and post synthesis vhdl files, as well as the area and timing reports. The latter are placed in a directory called report, and anotherone, named schematic, is created to handle the physical layout pictures; this folder is left empty by the script, has just been placed to better organize the files.

## directory structure

### pre script
1. entityname
   -report
   -schematic
   -architecture.script

### post script
1. entityname
   -report
    -timing_architecture.txt
    -area_architecture.txt
   -schematic
   -architecture.script
   -architecture.ddc
   -postSyn_architecture.vhdl
