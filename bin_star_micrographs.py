#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Created on Sat Feb	5 17:35:42 2022
Script to bin all micrographs from a star file
The script is a bit too complicated unfortunately
@author: kbui2
"""

import numpy as np
import multiprocessing as mp
import errno, os, argparse
import starfile
import pandas as pd

		
def binsinglemicrograph(micrograph, outdir, binning):
	''' Binning the micrograph'''
	bincmd = "newstack -bin {:d} {:s} {:s}".format(binning, micrograph, outdir + '/' + os.path.basename(micrograph))
	print(bincmd)
	os.system(bincmd)
		


if __name__=='__main__':
	# get name of input starfile, output starfile, output stack file
	print("This script requires IMOD!")

	parser = argparse.ArgumentParser(description='')
	parser.add_argument('--i', help='Input star file (from MotionCorr or CtfFind)',required=True)
	parser.add_argument('--outdir', help='Output folder',required=True)
	parser.add_argument('--bin', help='Binning',required=True)
	parser.add_argument('--j', help='Number of processors',required=False,default=1)
  parser.add_argument('--opticsless', help='With or without opticsgroup. Value 1 or 0',required=False,default="0")


	
	args = parser.parse_args()
	
	outdir = args.outdir
	nocpu = int(args.j)
	binning = int(args.bin)
	

	try:
		os.mkdir(outdir)
	except OSError as exc:
		if exc.errno != errno.EEXIST:
			raise
		pass
	
	stardict = starfile.read(args.i)
	if (args.opticsless == "1"):
		df = stardict
	else:
		df = stardict['micrographs']
		
	dfmicrograph = df["rlnMicrographName"].sort_values(ignore_index=True).copy()
	nomicro = len(dfmicrograph)
	
	# Binning
	print("Binning data by {:d}".format(binning))
	pool = mp.Pool(nocpu)
	# Prep input, convert Series to Dataframe
	dfbin = dfmicrograph.to_frame()
	listoutdir = [outdir]*nomicro
	listbinning = [binning]*nomicro
	dfbin['Outdir'] = listoutdir
	dfbin['Binning'] = listbinning
	#print(dfbin)
	# Convert to tuple
	listbinargs = list(dfbin.itertuples(index=False, name=None))
	
	# Parallel binning
	pool.starmap(binsinglemicrograph, listbinargs)
		
	# Done parallel processing
	pool.close()
	pool.join()
