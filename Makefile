#your shared BLAS library goes here:
atlaslibs=/usr/lib/libblas.so #$(HOME)/ATLAS/lib/libsatlas.so
all:
	gfortran matmul.f90 $(atlaslibs) -fPIC -g -fbacktrace -O2 -shared -o mymatmul.so
	gfortran matmul_futile.f90 $(atlaslibs) -I/local/binaries/gfortran-bindings/install/include \
	-fPIC -g -fbacktrace -O2 -shared -L/local/binaries/gfortran-bindings/install/lib -lfutile-1 -o mymatmul_futile.so
