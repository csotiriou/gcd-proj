Grand Central Dispatch Project (under development)
========

Project for GCD. In development. Project for 3rd semester of MSc Software Engineering for Ambient Intelligence, Telecom SudParis, France.

#Problem Overview

Scientists have discovered different types of alien genetic material, sharing common structure:

    •3 dimensional lattice of cubes of distinctive components (letters)
    •Each lattice has a finite number of letters in its alphabet – from 2 up to 100 •The lattice sizes range from 4*4*4 up to 1000*1000*1000
    
Scientists have also discovered dictionaries of words from the genetic alphabet: 

    •The dictionary size ranges from 3 up to 1000 words
    •All words in a common dictionary share the same length, from 2 up to 100
    

The scientists hypothesise that dictionaries are associated to some of the genetic material, provided all words in the dictionary can be found in sequence (horizontal, vertical or diagonal) in the material lattice. You are to write a program that takes as input any lattice material and any dictionary, and returns a boolean stating whether there is an association between the two.

In short, we have a 3D cube with possible size 4x4x4 - 1000x1000x1000 and we must do a string search and pattern matching in all possible directions in the cube with one single-threaded way, and 2 multithreaded ones, using any multiprocessing library we want. I chose Grand Central Dispatch for OS X as the development platform.

We are to document our findings at the end. I will include the PDF report in the code, when finished.

Still under development!