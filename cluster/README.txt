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