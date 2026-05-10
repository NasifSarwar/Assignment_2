#!/bin/bash
#SBATCH --job-name=cuda_renderer
#SBATCH --account=project_2018477
#SBATCH --partition=gputest
#SBATCH --time=00:15:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=16G

module load gcc/13.2.0
module load cuda/12.6.0
module load python-data/3.12-25.09

export LD_LIBRARY_PATH=$(dirname $(which nvcc))/../lib64:$LD_LIBRARY_PATH

cd render
echo "=== Testing render_ref_x86 directly ==="
ldd ./render_ref_x86
echo "---"
./render_ref_x86 -r cuda -b 0:4 rgb -s 1024 2>&1
echo "=== exit code: $? ==="