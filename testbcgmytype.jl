#comment

include("gT2.jl")
include("bicgstab.jl")

T=Complex128

srand(231)

#generate matrix:
n=1000
A=rand(T,n,n)
(Q,R)=qr(A)
for i in 1:n
    A[:,i]=A[:,i]/norm(A[:,i])
end
#Q=copy(A)
#L=diagm(1.0*(1:n))
L=diagm(rand(n))
A=Q*L*inv(Q)
#A=rand(n,n)

##A=matrixOp(A)

#right hand sides:
m=12
b=rand(T,n,m)
#b=5.0*ones(T,n)
##b=generalVec(rand(T,n))

#solve system:
#x=\(A,b)
##x0=generalVec(rand(T,n))
x0=rand(T,n,m)
maxit=50
eps=1e-5

options=Dict("n" => n, "nvctr" => m, "nvctrp" => m, "ptr" => A) #,"allow_mpi" => True)

#A=matrixOp(A)
A=userOp(options)
b=generalVec(b)
x0=generalVec(x0)

#x=zeros(x0)
#for i in 1:m
#    x[:,i]=zbicgstab(A,b[:,i],x0[:,i],maxit,eps)
#end
#@time x=crappyBlockBicgstab(A,b,x0,maxit,eps)
@time x=zbicgstabBlock(A,b,x0,maxit,eps)


println("Residual = ",norm(b-A*x)/norm(b))

finalize(A)
