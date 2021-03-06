#!/bin/bash

#Script for installing Nalu on Mira using Spack with GCC compiler

# Function for printing and executing commands
cmd() {
  echo "+ $@"
  eval "$@"
}

set -e

export SPACK_ROOT=/projects/ExaWindFarm/spack
source ${SPACK_ROOT}/share/spack/setup-env.sh

cd /projects/ExaWindFarm/NaluSpack/spack_config && ./setup_spack.sh
#spack compilers

# Get general preferred Nalu constraints from a single location
cmd "source /projects/ExaWindFarm/NaluSpack/spack_config/shared_constraints.sh"

# Disable openmp on Mira
TRILINOS=$(sed 's/+openmp/~openmp/g' <<<"${TRILINOS}")

cmd "spack install --only dependencies nalu+hypre+openfast %gcc@4.8.4 arch=bgq-cnk-ppc64 ^${TRILINOS}@develop"
