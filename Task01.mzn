include "globals.mzn";

var 0..9: O;
var 0..9: N;
var 0..9: E;
var 0..9: T;
var 0..9: W;
var 0..9: F;
var 0..9: U;
var 0..9: R;

constraint O != 0;
constraint T != 0;
constraint F != 0;

constraint all_different([O, N, E, T, W, F, U, R]);

var int: ONE = 100*O + 10*N + E;
var int: TWO = 100*T + 10*W + O;
var int: FOUR = 1000*F + 100*O + 10*U + R;

constraint ONE + TWO == FOUR;

solve maximize FOUR;

output ["ONE = \(ONE), TWO = \(TWO), FOUR = \(FOUR)\n",
        "O = \(O), N = \(N), E = \(E), T = \(T), W = \(W), F = \(F), U = \(U), R = \(R)"];