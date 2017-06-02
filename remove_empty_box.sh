#!/bin/bash
# Script to remove empty box
# Can change to .ext to remove empty other file types

ls -l Micrographs/*.box | awk '{if ($5==0) {print "rm ", $9}}' > zz

sh zz
