include "globals.mzn";

int: n = 10; % Size of the board 
int: max_bishops_per_row = 3; % Maximum bishops per row
int: max_bishops_per_col = 3; % Maximum bishops per column

% Decision variables
array[1..n, 1..n] of var 0..1: bishop; % 1 if bishop is placed, 0 otherwise

% No more than max_bishops_per_row bishops per row
constraint forall(i in 1..n) (
    sum(j in 1..n) (bishop[i, j]) <= max_bishops_per_row
);

% No more than max_bishops_per_col bishops per column
constraint forall(j in 1..n) (
    sum(i in 1..n) (bishop[i, j]) <= max_bishops_per_col
);

% No two bishops on the same diagonal
% For each diagonal, ensure that no more than one bishop is placed
constraint forall(d in 2..2*n) (
    sum(i in 1..n, j in 1..n where i + j == d) (bishop[i, j]) <= 1
);

constraint forall(d in -(n-1)..(n-1)) (
    sum(i in 1..n, j in 1..n where i - j == d) (bishop[i, j]) <= 1
);

% Maximize the total number of bishops
var int: total_bishops = sum(i in 1..n, j in 1..n) (bishop[i, j]);
solve maximize total_bishops;

% Output 
output ["Total bishops: \(total_bishops)\n"] ++
       [if j == 1 then "\n" else "" endif ++
        if fix(bishop[i, j]) == 1 then "B " else ". " endif
        | i in 1..n, j in 1..n];