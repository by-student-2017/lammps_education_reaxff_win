import argparse
from pathlib import Path

from scm.plams import AMSJob, Molecule, Settings, finish, init


def parse_args():
    """
    Parses the command line arguments and returns the parsed arguments.

    Returns
    -------
    argparse.Namespace
        The parsed command line arguments.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--forcefield", type=str)
    parser.add_argument("-t", "--temperature", type=int)
    parser.add_argument("-s", "--structure", type=str)
    parser.add_argument("--thermostat_tau", type=int)
    args = parser.parse_args()
    return args


def build_settings(
    temp: int, timestep: float, samplingfreq: int, thermostat_tau: int, forcefield: Path
):
    """
    Builds the settings for a molecular dynamics simulation.

    Parameters
    ----------
    temp : int
        The temperature of the initial velocities AND thermostat.
    timestep : float
        The time step of the simulation.
    samplingfreq : int
        The frequency at which to sample the trajectory.
    thermostat_tau : int
        The relaxation time for the thermostat.
    forcefield : Path
        The path to the force field file.

    Returns
    -------
    None
    """
    sett = Settings()

    # regular MD settings
    sett.input.ams.Task = "MolecularDynamics"
    sett.input.ams.moleculardynamics.initialvelocities.temperature = temp
    sett.input.ams.moleculardynamics.nsteps = 50000
    sett.input.ams.moleculardynamics.TimeStep = timestep
    sett.input.ams.moleculardynamics.Trajectory.SamplingFreq = samplingfreq

    # Thermostat settings
    sett.input.ams.moleculardynamics.thermostat.type = "NHC"
    sett.input.ams.moleculardynamics.thermostat.Temperature = temp
    sett.input.ams.moleculardynamics.thermostat.tau = thermostat_tau

    # ReaxFF settings
    sett.input.ReaxFF.ForceField = (
        forcefield.absolute().as_posix()
    )  # requires full path, not relative

    return sett


def build_job(molecule: Path, settings: Settings, name: str):
    """
    Build a job using the given molecule, settings, and name.

    Parameters
    ----------
    molecule : Path
        The path to the molecule file.
    settings : Settings
        The settings for the job.
    name : str
        The name of the job.

    Returns
    -------
    AMSJob
        The built job.
    """
    molecule = Molecule(molecule, inputformat="ase", format="cif")
    job = AMSJob(molecule=molecule, settings=settings, name=name)
    return job


def run_job(job: AMSJob):
    """
    Run a job.

    Parameters
    ----------
    job : AMSJob
        AMSJob object representing the job to be run.
    """
    init()
    job.run()
    finish()


def main():
    # Parse command line arguments
    args = parse_args()
    temp = args.temperature
    structure = Path(args.structure)
    ff = Path(args.forcefield)
    thermostat = args.thermostat_tau
    assert ff.is_file()
    assert structure.is_file()

    # build the settings
    settings = build_settings(
        temp=temp, timestep=0.2, samplingfreq=5000, thermostat_tau=thermostat, forcefield=ff
    )
    print(settings)

    print("building job")
    job = build_job(molecule=structure, settings=settings, name=f"110_{temp}")
    print("starting job")
    run_job(job)
    print("done")


if __name__ == "__main__":
    main()
