
#! /bin/bash
echo "What's the name of the OF-project you'd like to run?"
read name
cd /home/henrikg/OpenFOAM/henrikg-8/run/$name
#blockMesh
#surfaceFeatureExtract
#snappyHexMesh -overwrite
#topoSet 
#createPatch -overwrite
decomposePar -force
mpirun -np 4 pimpleFoam -parallel 
# > pimpleFoam.log
reconstructPar
rm -r /home/henrikg/OpenFOAM/henrikg-8/run/$name/processor*
#postProcess -func "totalPressureIncompressible(p, U, rho=rhoInf, rhoInf=1000)"
postProcess -func "staticPressure(p, rho=rhoInf, rhoInf=1000)"
postProcess -func sampleDict
postProcess -func sampleTrace3
postProcess -func samplePatch
postProcess -func functionInletAverage
postProcess -func functionOutletAverage
