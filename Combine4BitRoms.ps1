<#
Powershell script to combine 2 rom files
that each are 4 bit wide into a single file
which has 8 bit wide bytes ready to be programmed
into a more standard eprom

This is intended to combine files like used in Atari Football 
or Atari Video Pinball

Source roms are assumed to be in a binary format with 
each byte between 0-15.  Rom images can generally be found
from MAME repositories if you can't get them read from 
original hardware

Hacked together for fun by Steve Jones - sjarcade[at]cherokeesystems.combine
version 0.1 - 8-6-2020
#>

#Tested with a couple ROM files from Atari Video Pinball
#Replace filenames for input and output files
$Path=Get-Location #Default to current directory
$HighNibbleFile="$Path\34242-01.e0"
$LowNibbleFile="$Path\34237-01.k0"
$OutputFile="$Path\34260.K0"

#Input each ROM image into separate arrays of bytes:
$LowNibbles = [System.IO.File]::ReadAllBytes($LowNibbleFile)
$HighNibbles = [System.IO.File]::ReadAllBytes($HighNibbleFile)

#If we're going to combine them into 8 bit bytes, the 2 input files need to have the same 
#number of nibbles in them, or something went seriously wrong!
If ($LowNibbles.count -ne $HighNibbles.count) {
	Write-Host "The two files have different number of bytes in them.  Aborting!"
	exit
	}
	
#How many nibbles do we have to count through?	
$ByteCount=$LowNibbles.Count	

#initialize an empty array to contain the final bytes
$Bytes = @()

#Loop through each set of nibbles
for( $i=0; $i -lt $ByteCount; $i++) {
	#For each nibble, we multiply the high one by 16 to move it to the left 4 bits in a byte, and add the lower nibble
	[int]$byte = [int]$HighNibbles[$i]*16 + [int]$LowNibbles[$i]
	#Just for debugging, uncomment the next line to see the counter and the resulting byte to be output
	#Write-Host "$i    $byte"
	
	#Add the byte to the output list/array
	$bytes+=@([byte]$byte)
	
}

#This next command didn't work to write the bytes
#[io.file]::WriteAllBytes("$Path\$OutputFile",$bytes)

#Found some help online for this syntax, and it seems to work!
Set-Content $outputfile -Value $Bytes -Encoding Byte

