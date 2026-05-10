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

cd render
make

for scene in rgb rand10k rand100k pattern snowsingle biglittle rand1M micro2M; do
    echo "=== $scene ==="
    ./render -r cuda -c $scene 2>&1
    echo ""
done