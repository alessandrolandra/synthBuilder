# synthBuilder
Really simple script to initialize the environment and prepare a **Synopsis** synthesis script.

By running the script, a set of folders is created in the current directory and a Synopsys script is generated.\
To synthesize an architecture, its name and the one of the related entity are required, as well as the vhd filename in which they are described.\
The Synopsis script, that can be found in the directory named as the entity, analyzes, elaborates and compiles the wanted architecture and generates the ddc and post synthesis vhdl files, as well as the area and timing reports. The latter are placed in a directory called report, and anotherone, named schematic, is created to handle the physical layout pictures; this folder is left empty by the script, has just been placed to better organize the files.

## Directory structure

### pre script
- `<entity>`
  - report
  - schematic
  - `<architecture>`.script

### post script
- `<entity>`
  - report
    - timing_`<architecture>`.txt
    - area_`<architecture>`.txt
  - schematic
  - `<architecture>`.script
  - `<architecture>`.ddc
  - postSyn_`<architecture>`.vhdl

## Script usage

You need to specify the `<entity>` and the `<architecture>` you want to synthesize (**same names as in the vhd file**), the VHD filename(s) and the PARAMeter(s) to be set constant during synthesis, in case they are needed.\
\
If you need to specify more than one VHD file, you need to separe them with a **whitespace**.\
Parameters have to follow this pattern: `"NAME = VALUE"`, enclosed in double quotes, and separed by whitespace if more than one is needed\(`"N = 4 M = 4"`).\
\
Example:\
`bash synthBuilder.bash -entity alu -architecture BEHAVIORAL_VERSION_B -vhd alu.vhd - param "N = 4"`
\
This will generate the following folder structure:

<ul><li>alu
  <ul>
    <li>report</li>
    <li>schematic</li>
    <li>BEHAVIORAL_VERSION_B.script</li>
  </ul>
</li></ul>

That becomes the next one after the BEHAVIORAL_VERSION_B.script execution (with Synopsys):

<ul><li>alu
  <ul>
    <li>report
      <ul>
        <li>timing_BEHAVIORAL_VERSION_B.txt</li>
        <li>area_BEHAVIORAL_VERSION_B.txt</li>
      </ul>
    </li>
    <li>schematic</li>
    <li>BEHAVIORAL_VERSION_B.script</li>
    <li>BEHAVIORAL_VERSION_B.ddc</li>
    <li>postSyn_BEHAVIORAL_VERSION_B.vhdl</li>
  </ul>
</li></ul>

If you have multiple architectures to synthesize, for the same entity, you just need to rerun the **synthBuilder** script, maintaining the same entity name, and the new synopsys script will be added in the same folder used before.\
After running it, the newly generated reports will be placed in the report folder and the postSynthesis netlist and ddc will be added next to the ones of the previous architecture.
