import cv2
import sys
from openpose import pyopenpose as op

# Paths to OpenPose model and image
image_path = "path/to/your/image.jpg"

# Set up parameters for OpenPose
params = {
    "model_folder": "path/to/openpose/models/",
    "face": True,
    "hand": True,
}

# Starting OpenPose
opWrapper = op.WrapperPython()
opWrapper.configure(params)
opWrapper.start()

# Process the image
datum = op.Datum()
imageToProcess = cv2.imread(image_path)
datum.cvInputData = imageToProcess
opWrapper.emplaceAndPop([datum])

# Display the image with detected poses
cv2.imshow("OpenPose 1.7.0 - Tutorial Python API", datum.cvOutputData)
cv2.waitKey(0)