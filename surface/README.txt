Disclaimer: Using these force fields for systems they have not been
explicitly trained against may produce unrealistic results.  Please
see the README file in each subdirectory for more detailed
information.

5_Au-SCH3: Tommi T. Jarvi, Adri C. T. van Duin, Kai Nordlund, 
William A. GoddardIII; Lee, J., J. Phys. Chem. A 2011, 115, 
37, 10315-10322.
http://dx.doi.org/10.1021/jp201496x

12_Ag_on_ZnO: A.Lloyd, D.Cornil, A.C.T.van Duin, D.van Duin, 
R.Smith, S.D.Kenny, J.Cornil, D.Beljonne;
Surface Science, Volume 645, March 2016, Pages 67-73.
http://dx.doi.org/10.1016/j.susc.2015.11.009
  Deposition simulations via MD were conducted using the velocity Verlet algorithm [32] with a corresponding time step of 1 fs. Periodic boundaries were implemented in the x and y directions along with a fixed bottom ZnO layer to emulate a large ZnO slab. A Berendsen thermostat [33] is used for temperature control applied to the second and third double ZnO layers. The simulation cells used for the polar and non-polar ZnO surfaces were of similar volume, namely 22.80 x 26.33 x 30 Angstrom (with 512 atoms) for ZnO (0001) and 26.51 x 26.33 x 30 Angstrom (with 640 atoms) for ZnO (1010).

14_Amino_acids_on_Cu: Susanna Monti, Cui Li, Vincenzo Carravetta,
J. Phys. Chem. C 2013, 117, 10, 5221-5228.
http://dx.doi.org/10.1021/jp312828d
  At LC only two-thirds of the surface were covered by the deposited molecules, whereas in the other case the surface was almost saturated. The characteristics and dynamics of the adsorbates were studied at 300 K in the NVT ensemble. The temperature was regulated by means of the Berendsen thermostat, and the relaxation constant was set to 0.1 ps.
Considering that ReaxFF updates bond orders every time step, it was necessary to fix the time step at 0.25 fs. The equations of motion were solved with the Verlet leapfrog algorithm, and system configurations were sampled every 0.1 ps during the subsequent production period (900 ps). Short MD runs of 10 ps each, at 400 K, were periodically (once every 150 ps) carried out during the sampling phase in order to randomize the position of the adsorbates and explore different regions of the system configurational space. It is worth noting that these temperature jumps interrupted the continuity of the system dynamics.

19_Cysteine_on_Au_in_H2O: S. Monti, V. Carravetta, H. Agren,
J. Phys. Chem. Lett. 2016, 7, 2, 272-276.
http://dx.doi.org/10.1021/acs.jpclett.5b02769
  Given these premises, we built a molecular model consisting of one cysteine molecule, 303 waters, and a relatively large Au(111) slab (10 layers made of 90 Au atoms each) which was placed in a simulation box where the size was about 26 x 25 x 70 in x, y, and z directions, respectively. The molecule was positioned close to the slab to avoid long sampling times and reactive MD simulations were carried out in the NVT ensemble at T = 300 K and ambient pressure by means of the ReaxFF version incorporated into the Amsterdam Density Functional (ADF) program. After the equilibration phase (25 ps), during which the molecule managed to get in touch with the surface orienting the S lone pairs toward the Au atoms (physisorption), the production phase started and system configurations were saved every 0.025 ps for a total simulation time of about 100 ps.
Temperature was controlled through the Berendsen thermostat with a relaxation constant of 0.1 ps, and the time step was set to 0.25 fs.

25_H-ZSM-5: George M. Psofogiannakis, John F. McCleerey, 
Eugenio Jaramillo, Adri C. T. van Duin,
J. Phys. Chem. C 2015, 119, 12, 6678-6686.
http://dx.doi.org/10.1021/acs.jpcc.5b00699
  In all cases the supercell had as many Al atoms as required to make the Cu/Al ratio equal to 0.5 (i.e., 4, 10, and 10 for simulation sets 1, 2, and 3, repsectively). All 3 sets of simulations were performed at six different starting temperatures: 100, 300, 500, 700, 900, and 1100 K. A short NPT run was performed first, at 1 atm pressure for all temperatures (progressively raising the temperature) to preoptimize the supercell sizes. The final structure from the NPT run for each temperature was then used as the starting structure in NVE simulations. The time step for integration was 0.25 fs. The total simulation time for each run was 500 ps (0.5 ns), or 2 million time steps. Because the reactive events in the simulations were only mildly exothermic, the temperatures throughout the simulations did not deviate much from their initial values (no more than 50 K). Thus, we can categorize the results according to the initial temperatures.

30_butane_YSZ_Ni111: B. V. Merinov, J. E. Mueller, 
A. C. T. van Duin, Qi An, W. A. Goddard III;
J. Phys. Chem. Lett. 2014, 5, 22, 4039-4043.
https://pubs.acs.org/doi/10.1021/jz501891y

45_Ni-CH3: Jonathan E. Mueller, Adri C. T. van Duin, 
William A. Goddard III, J. Phys. Chem. C 2010, 114, 11, 4939-4949.
http://dx.doi.org/10.1021/jp9035056
  The temperature-programmed (NVT)- MD simulations were performed using a velocity Verlet approach with a time step of 0.25 fs. A Berendsen thermostat with a damping constant of 100 fs was used for temperature control. Each MD simulation was initiated from an energy-minimized structure and was equilibrated to the simulation temperature by the thermostat prior to any reactive events being observed.

48_Pd-H2:Thomas P. Senftle, Michael J. Janik, Adri C. T. van Duin,
J. Phys. Chem. C 2014, 118, 9, 4967-4981.
http://dx.doi.org/10.1021/jp411015a
  MD simulations in this study were conducted in the NVT ensemble using the velocity Verlet method with a time step of 0.25 fs. A Berendsen thermostat with a damping constant of 100 fs maintained temperature control throughout the simulation.

49_CH3OH_on_V2O5: Chenoweth, K.; et
al. J. Phys. Chem. C, 2008, 112, 14645-14654.
http://dx.doi.org/10.1021/jp802134x
  MD simulations were performed to study the oxidative dehydrogenation of methanol to form formaldehyde and subsequent regeneration of the active site. These calculations used a time step of 0.25 fs with the temperature being controlled by a Berendsen thermostat with a temperature-damping constant of 0.1 ps.
To simulate the steps involved in the conversion of methanol to formaldehyde, we started with the crystal structure of V2O5 which has cell parameters of a ) 3.564 Angstrom, b ) 11.519 Angstrom, and c ) 4.373 Angstrom. We then built a 6 x 2 supercell in the a and b directions and used a finite slab with three layers in the c direction, leading to a (001) surface. This slab, containing 504 atoms, was exposed on both surfaces to a gas phase containing 30 methanol molecules in a volume of 8211 Angstrom^3 , which would correspond to a methanol pressure of 0.16 GPa at 2000 K. First, we optimized the CH3OH/V2O5 system to minimize the energy.
Subsequent simulations of the reaction with methanol were carried out for 250 ps using a dual-temperature thermostat keeping the V and O atoms associated with the vanadium oxide slab at 650 K. while the C, O, and H atoms associated with the methanol molecules were kept at 2000 K. This temperature regime was maintained throughout the simulation and did not change when reactions occurred.
To follow the reaction events, molecular analysis of the simulations was performed using a bond order cutoff of 0.2 to allow detection of short-lived intermediates.