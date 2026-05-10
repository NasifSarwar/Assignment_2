#!/bin/bash
#SBATCH --job-name=cuda_renderer
#SBATCH --account=project_2018477
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=8G

module load gcc/13.2.0
module load cuda/12.6.0
module load python-data/3.12-25.09

cd render
make clean
make
echo "=== Test 1: CPU reference (should work) ==="
./render -r cpuref rgb 2>&1
echo "=== Test 2: CUDA renderer ==="
./render -r cuda -c rgb 2>&1