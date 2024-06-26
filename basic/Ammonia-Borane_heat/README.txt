Disclaimer:  Using these force fields for systems they 
have not been explicitly trained against may produce
unrealistic results.  Please see the README file in 
each subdirectory for more detailed information.

Ammonia Borane:

     The follow information is reproduced from:
 
     "Weismiller, M.R.; van Duin, A.C.T.; Lee, J.; 
     Yetter, R.A. J. Phys. Chem. A 2010, 114, 5485-5492"

   - QM data were generated describing the single and 
   (if relevant) double and triple bond dissociation 
   for all B/N/O/H combinations. These data were used 
   to derive initial ReaxFF bond parameters, and all 
   calculations were performed using DFT with the B3LYP 
   functional and the Pople 6-311G** basis set.

   - The training set was then extended with QM data 
   describing angular distortions in a set of small 
   AB-related (AB = H3N-BH3) molecules. These data 
   were used to derive the initial ReaxFF angular 
   parameters.

   - The training set was extended with reaction barriers 
   for key reaction steps such as H2 release 
   from AB, dimerization of H2B-NH2 and reaction 
   energies associated with H2 release from AB and with AB 
   oxidation.
