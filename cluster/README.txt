Disclaimer: Using these force fields for systems they have not been
explicitly trained against may produce unrealistic results.  Please
see the README file in each subdirectory for more detailed
information.

4_Al-C-H2O: Sungwook Hong, Adri C. T. van Duin,
J. Phys. Chem. C 2016, 120, 17, 9464-9474.
http://dx.doi.org/10.1021/acs.jpcc.6b00786
  Because the previous ReaxFF study indicated that the time step should be lower than one order of the highest frequency of the simulated system (normally, t 0.5 - 1.0 fs), and because our MD simulations were performed under a relatively high- temperature range (2500 - 3000 K), we chose to use the time step of 0.1 fs, which enabled us to correctly capture reaction events for the carbon coating/oxidation processes up to 3000 K. The bare ANPs consisting of 864 Al atoms were obtained from the previous ReaxFF study of the oxidation of the ANPs.
 Other Ref: https://pubs.acs.org/doi/10.1021/jp709896w (No.8)

5_Au-SCH3: Tommi T. Jarvi, Adri C. T. van Duin, Kai Nordlund, 
William A. GoddardIII; Lee, J., J. Phys. Chem. A 2011, 115, 
37, 10315-10322.
http://dx.doi.org/10.1021/jp201496x

31_C_TM: K. D. Nielson, A. C. T. van Duin, J. Oxgaard, 
W.-Q. Deng, W. A. Goddard III; J. Phys. Chem. A 2005, 
109, 3, 493-499
http://dx.doi.org/10.1021/jp046244d
  The NVT-MD simulations on C20 + C4 mixtures were performed using a velocity Verlet approach with a time step of 0.1 fs. This relatively short time step was chosen to ensure good MD behavior at the high temperatures (1500 K) employed in our simulations. When low to moderate temperatures are used (0-1000 K) ReaxFF MD will conserve energy in NVE simulations with time steps up to 0.5 fs, and at more elevated temperatures smaller time steps need to be used to obtain good energy conservation. A Berendsen thermostat with a temperature-damping constant of 250 fs was used to control the system temperature.

48_Pd-H2: Thomas P. Senftle, Michael J. Janik, Adri C. T. van Duin,
J. Phys. Chem. C 2014, 118, 9, 4967-4981.
http://dx.doi.org/10.1021/jp411015a
  MD simulations in this study were conducted in the NVT ensemble using the velocity Verlet method with a time step of 0.25 fs. A Berendsen thermostat with a damping constant of 100 fs maintained temperature control throughout the simulation.
  A temperature of 1250 K was employed for all simulations, which was selected because it is high enough to allow rapid dissociation and diffusion in the time frame of the simulation, yet is still below the melting point of Pd metal. The populations of H2 molecules and H atoms either present in the gas phase or adsorbed on the Pd cluster were recorded at 25 fs intervals, allowing the hydride formation process to be tracked as a function of simulation time.

75_AlCHO: J. Liu et al.,
Computational Materials Science
Volume 151, August 2018, Pages 95-105
https://www.sciencedirect.com/science/article/abs/pii/S0927025618302957

2015X1_ANPs: S. Hong et al.,
Cite this: J. Phys. Chem. C 2015, 119, 31, 17876-17886
Publication Date:July 7, 2015
https://doi.org/10.1021/acs.jpcc.5b04650
  To validate and apply the current ReaxFF description for the aluminum/oxygen system, two structures were prepared in this work: 504 Al atoms of Al (4 3 1) slab (1.40 x 1.28 x 4.82 nm, see Figure 1a) and 864 Al atoms of an amorphous Al cluster (diameter of 2.8 nm, see Figure 1b). The system configurations were displayed by the Visual Molecular Dynamics (VMD) molecular graphics viewer, Visit, and Molden. The slab was built by cleaving the (4 3 1) plane of fcc-Al crystal and then by placing the slab in a 1.4 x 1.28 x 10.0 nm simulation box with 150 oxygen molecules. The amorphous cluster was obtained by annealing the fcc-Al crystal containing 864 Al atoms from 0 to 800 K for two cycles. Then, the annealed cluster was placed in the middle of a simulation box that measured 5.0 x 5.0 x 5.0 nm. Two different numbers of oxygen gas, that is, 300 and 600 oxygen molecules, were distributed randomly in the simulation box with a periodic boundary condition, corresponding to oxygen gas densities of 0.13 and 0.26 g/cm3, respectively. For the ReaxFF-MD simulations to deal with chemical reactions to occur smoothly, it has been reported that the time step needs to be lower than 1 order of the highest frequency of molecules (generally, t = 0.5 - 1.0 fs). In this study, the system temperature was controlled up to 900 K, and it was found that the time step of 0.2 fs efficiently describes the adsorption, dissociation, and diffusion of oxygen molecules. Hence, all the simulations were performed with a time step of 0.2 fs and 5 000 000 iterations (up to 1.0 ns). Because this study was focused mainly on the oxidation of ANPs as a function of the temperature of the system, it was essential to control the temperature of the system during the MD simulations. For this reason, a canonical ensemble was used, that is, a constant number of atoms, constant volume, and constant temperature. In the canonical ensemble, a variety of thermostatic methods were used to control the temperature of the system, such as Nose/Hoover, Berendsen, and Anderson. It has been suggested that the Nose/Hoover thermostat correctly describes the canonical ensemble with true dynamics, because such a method makes it possible to obtain a canonical distribution of the particlesÅf positions and momenta by using the extended Hamiltonian system. Hence, we chose to use the Nose/ Hoover thermostat with a temperature damping constant of 100 fs implemented on the 29 Jan 2014 version of LAMMPS code41 (http://lammps.sandia.gov). In addition, the 864 atoms of the ANPs were heated from 0 to 1000 K with a heating rate of 0.02 K/fs to evaluate the melting temperature of the ANPs using the current ReaxFF description. The melting temperature of the 864 atoms of the ANPs is found to be about 800 K; the result is summarized in the Supporting Information.