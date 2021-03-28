# synthBuilder
Really simple script to initialize the environment and prepare a Synopsis synthesis script.

By running the script, a set of folders are created in the current directory and a Synopsys script is generated.
To synthesize an architecture, its name and the one of the related entity are mandatory, as well as the vhd file name in which they are described.
The Synopsis script, that can be found in the directory named as the entity, analyze, elaborate and compile the wanted architecture and generates the ddc and post synthesis vhdl files, as well as the area and timing reports.
