#!/bin/bash
#
#  Copyright (c) 2018 - Present  Jeong Han Lee
#  Copyright (c) 2018 - Present  European Spallation Source ERIC
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#
#   author  : Jeong Han Lee
#   email   : jeonghan.lee@gmail.com
#   date    : Tuesday, December  4 19:09:43 CET 2018
#   version : 0.0.2
# 
# Update:
# Date: 2018-12-04
# Author: Wayne Lewis
# Description: Create file for IOC st.cmd to load, setting environment variable



EXIST=1
NON_EXIST=0

declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_TOP="${SC_SCRIPT%/*}"

function checkIfVar()
{

    local var=$1
    local result=""
    if [ -z "$var" ]; then
	result=$NON_EXIST
	# doesn't exist
    else
	result=$EXIST
	# exist
    fi
    echo "result = ${result}"
}


# Get the PCI bus number
# Example output of lspci -nm
# 05:0d.0 "1180" "10b5" "9030" -r01 "1a3e" "20e6"
#
# We need the '05' at the start
#
# "20e6" is the ID for the Event generator, "10e6" is the event receiver
#
# Search for all occurences, but just use the first line, as they should
# all be on the same bus

PCI_BUS_NUM="$(lspci -nm |grep -e 20e6 -e 10e6 | head -n 1 | cut -f1 -d':')"

#echo ${PCI_BUS_NUM}


if [[ $(checkIfVar "${PCI_BUS_NUM}") -eq "$EXIST" ]]; then
    echo "epicsEnvSet(PCI_BUS_NUM, \"${PCI_BUS_NUM}\")" > ${SC_TOP}/pci_bus_id
else
    echo "epicsEnvSet(PCI_BUS_NUM,\"Unknown\")" > ${SC_TOP}/pci_bus_id
    printf "We cannot find the CPCI EVG 230 or an EVR in the system\n";
    exit;
fi



