from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import Normalizer
import nibabel as nib
# from nilearn import plotting
import re
import numpy as np
import pandas as pd
import os
from os import listdir, fsencode
import math
from PIL import Image
import sys
import os

myDirectory = str(sys.argv[1])
Destination = str(sys.argv[2])

y=0
directory = os.fsencode(myDirectory)
names = []

for file in os.listdir(directory):
    myFile = os.fsencode(file)
    myFile = myFile.decode('utf-8')
    myNifti = nib.load((myDirectory +myFile))
    print(y, 'Train')
    y = 1+y
    data = myNifti.get_data()
    data = data*(185.0/np.percentile(data, 97))

    scaler = StandardScaler()
    names.append(myFile)
    for sl in range(0,80):
        x = sl

        clipped = data[:,:,(45+x)]

        image_data = Image.fromarray(clipped).convert('RGB')
        image_data.save((Destination+ 'Test/'  + myFile[:-7] + '-'+str(x)+'.jpg'))
