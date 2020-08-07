# 4BitArcadeROMCombiner
Sample powershell script to combine two binary files, each containing 4 bits per byte, into one file of 8 bit bytes

8-7-2020:  Initial Upload:
Script seems to work.  Resultant output is a file the same size as the 2 input files.  Generally, to make this useful in a real arcade situation, you'd then combine multiple output files from this script into a larger file to be burned to a larger EPROM.  For example, with the Atari Video Pinball ROMs I used to test this, the original ROMs contain 1k of NIBBLES so the output of this script is 1k of BYTES.  To use these BYTES and create an EPROM, the Atari Video Pinball schematic shows 2k ROMs (I think it is wired for 2716 chips, but dont quote me on that!) so you'd have to take 2 output files from this script, and combine them into one binary file.  I did not do this in the script because it is easily done from a DOS prompt with the syntax:
copy /b InputRom1.bin + InputRom2.bin   2kOutputRom.bin
