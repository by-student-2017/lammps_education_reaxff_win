# Supplementary Dataset

This ZIP archive provides the optimized ReaxFF parameters and example scripts for performing molecular dynamics runs. The optimized parameters are available in two formats, and the corresponding molecular dynamics scripts are provided for ReaxFF MD (both AMS and LAMMPS software packages) and VASP MD.

## `parameters`

This directory contains the optimized ReaxFF parameters for Si, Al, O, and H obtained through this work and combined with parameters from [Joshi *et al*](https://doi.org/10.1039/c4cp02612h).
The parameters are stored in two file formats:

* `ffield`: Optimized ReaxFF parameters in the original force field format.
  Compatible with software packages that utilize this format, such as LAMMPS.

* `parameter_interface.yaml`: The same parameters in [ParAMS](https://www.scm.com/doc/params) format.
  Suitable for use with AMS software.


## `molecular_dynamics_examples`

This directory contains three example inputs for molecular dynamics simulations:

* `AMS` Directory:
    * `ams_reax.py`: A Python run script that executes a molecular dynamics simulation with AMS.
    * `110b_supercell.cif`: A `CIF` format structure for the simulation.
    * To execute this script, ensure that AMS is installed on your system.
      Then, execute the following command:

      ```bash
      amspython ams_reax.py --forcefield {PATH_TO_FFIELD} --temperature {TEMPERATURE} --structure {PATH_TO_STRUCTURE} --thermostat_tau {THERMOSTAT_TAU}
      ```

      where the temperature is in kelvin and the timeconstant tau is in femtoseconds.
      For example:

      ```bash
      amspython ams_reax.py --forcefield ../../parameters/ffield --temperature 300 --structure 110b_supercell.cif --thermostat_tau 1000
      ```

* `LAMMPS` Directory:
    * `lammps_reax.input`: A minimal LAMMPS input file for conducting a ReaxFF-based molecular dynamics simulation.
    * `input_atomic_config.data`: A LAMMPS input format structure file for the simulation.
    * To execute this simulation, ensure that LAMMPS is installed on your system. Then, execute the following command:

      ```bash
      lmp_serial < lammps_reax.input
      ```

* `VASP` Directory: The files `INCAR`, `KPOINTS` and `POSCAR` were used to perform the molecular dynamics simulation described in section S2 of the Supporting Information PDF document.


## Software versions

* **AMS:** Detailed installation instructions for AMS can be found on SCM's website: https://www.scm.com/doc/Installation/Installation.html.
  Note that a valid license is required for AMS usage.
  A free trial license can be requested through inquiry at SCM.
  This example was tested using `ams2023.101`, but it should work with newer versions as well.

* **LAMMPS:** LAMMPS can be conveniently installed using `conda`.
  Assuming you have a working (mini)conda installation, refer to the installation instructions provided at LAMMPS' documentation: https://docs.lammps.org/Install_conda.html.
  This example was tested using `LAMMPS (2 aug 2023)`.

* **VASP:** The VASP calculations where done with vasp.6.4.2 20Jul23 (build Aug 25 2023 09:25:33).

## Detailed parameterization dataset

A larger ZIP archive with details of the parameterization can be accessed at: https://doi.org/10.5281/zenodo.10491516
