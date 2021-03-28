#!bin/bash

for arg in "$@"
do
	if [[ $arg == "-"* ]]
	then
		case $arg in
			"-entity")
				s=1
				;;
			"-architecture")
				s=2
				;;
			"-param")
				s=3
				;;
			"-vhd")
				s=4
				;;
			"-help")
				s=-1
				echo "Command to prepare the environment and the synthesis script to be executed by Synopsys."
				echo "Usage:"
				echo "you need to specify the ENTITY and the ARCHITECTURE you want to synthesize (same names as in the vhd file), the VHD file name(s) and the PARAMeter(s) to be set constant during synthesis, in case they are needed."
				echo "If you need to specify more than one VHD file, you need to separe them with a whitespace."
				echo "Parameters have to follow this pattern: \"NAME = VALUE\", enclosed in double quotes and separed by whitespace if more than one is needed."
				echo "-entity alu -architecture BEHAVIORAL_VERSION_B -vhd alu.vhd - param \"N = 4\""
				exit 0
				;;
			*)
				s=-1
				echo "wrong parameter, allowed params: -entity, -architecture, -vhd, -param"
				exit 1
				;;	
		esac
	else
		case $s in
			1)
				entity=$arg
				;;
			2)
				architecture=$arg
				;;
			3)
				if [ -z "$parameters" ]
				then
					parameters="\"$arg\""
				else
					parameters+=" \"$arg\""
				fi
				;;
			4)
				if [ -z "$vhd" ]
				then
					vhd=$arg
				else
					vhd+=" $arg"
				fi
				;;
		esac
	fi
done
if [ -z "$entity" ] || [ -z "$architecture" ] || [ -z "$vhd" ]
then
	echo "entity, architecture and vhd are mandatory params! Define them using -entity, -architecture, -vhd"
else
	workingDir=$(pwd)
	if ! [ -z "$parameters" ]
	then
		parameters=" -parameters $parameters"
	fi
	mkdir -p $workingDir/$entity/report/
	mkdir -p $workingDir/$entity/schematic/
	scriptName=$workingDir/$entity/$architecture.script
	echo "analyze -library WORK -format vhdl {$vhd}" > $scriptName
	
	echo "elaborate $entity -architecture $architecture -library WORK$parameters" >> $scriptName
	echo "compile -exact_map" >> $scriptName
	echo "write -hierarchy -format ddc -output $workingDir/$entity/${architecture}.ddc" >> $scriptName
	echo "write -hierarchy -format vhdl -output $workingDir/$entity/postSyn_$architecture.vhdl" >> $scriptName
	echo "report_timing > $workingDir/$entity/report/timing_$architecture.txt" >> $scriptName
	echo "report_area > $workingDir/$entity/report/area_$architecture.txt" >> $scriptName
	echo "initialization done"
fi
