#! /bin/bash




DATA_PATH=''
OUT_PATH=''
MODEL=''
print_usage() {
  printf "\n\nUsage:\n\n"
  printf "\tRequired Parameters:\n\n" 
  printf "\t %s\n\n "  "[-d]: Path containing aligned nifti images" "[-o]: Output directory for prediciton csv" "[-m]: Specify Model files to use (.h5)"
  printf "\nExample: ./test.sh -d /myPath/ -o ./outputPath/ -m ../myModel.h5\n\n"
  exit 1
}

while getopts 'uhd:o:m:' flag; do
  case "${flag}" in
    u) print_usage ;;
    h) print_usage ;;
    d) DATA_PATH="${OPTARG}" ;;
    o) OUT_PATH="${OPTARG}" ;;
    m) MODEL="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done


CUDA_VISIBLE_DEVICES=$(get_CUDA_VISIBLE_DEVICES) || exit
export CUDA_VISIBLE_DEVICES




rm -r ../tmp/
mkdir ../tmp/
mkdir ../tmp/Test/

python Slicer.py $DATA_PATH ../tmp/

module load python/anaconda/3.5.6+tensorflow-gpu+pillow
python Model_Test.py ../tmp/ ${OUT_PATH}pred.csv $MODEL
