// Rules:
// The register file must be set to all 0s except that you
// can store the base address of A in X22.  Base address of A
// should be non-zero.  Everything else must be loaded from memory.
// This is a simple division problem where having a remainder will
// break it, so choose an x that is divisible by y.


int x = A[0];	 // dividend
int y = A[1];	 // divisor
int z = A[2];    // quotient, should initially be set to 0
int one = A[3];

while(x != 0)
{
	x = x - y;
	z = z + one;
}

A[2] = z;
