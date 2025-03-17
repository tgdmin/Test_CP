% Define the size of the chessboard
int: n = 8;

% Define the points for each piece
int: bishop_points = 3;
int: rook_points = 4;
int: queen_points = 5;

% Decision variables: 1 if a piece is placed on the square, 0 otherwise
array[1..n, 1..n] of var 0..1: bishops;
array[1..n, 1..n] of var 0..1: rooks;
array[1..n, 1..n] of var 0..1: queens;

% Constraints to ensure no two pieces attack each other
constraint forall(i in 1..n, j in 1..n) (
    bishops[i,j] + rooks[i,j] + queens[i,j] <= 1
);

% Bishops attack diagonally
constraint forall(i1 in 1..n, j1 in 1..n, i2 in 1..n, j2 in 1..n where (i1 != i2 \/ j1 != j2) /\ (abs(i1 - i2) == abs(j1 - j2))) (
    bishops[i1,j1] + bishops[i2,j2] <= 1
);

% Rooks attack horizontally and vertically
constraint forall(i1 in 1..n, j1 in 1..n, i2 in 1..n, j2 in 1..n where (i1 != i2 \/ j1 != j2) /\ (i1 == i2 \/ j1 == j2)) (
    rooks[i1,j1] + rooks[i2,j2] <= 1
);

% Queens attack horizontally, vertically, and diagonally
constraint forall(i1 in 1..n, j1 in 1..n, i2 in 1..n, j2 in 1..n where (i1 != i2 \/ j1 != j2) /\ (i1 == i2 \/ j1 == j2 \/ abs(i1 - i2) == abs(j1 - j2))) (
    queens[i1,j1] + queens[i2,j2] <= 1
);

% Ensure no piece attacks another piece
constraint forall(i1 in 1..n, j1 in 1..n, i2 in 1..n, j2 in 1..n where (i1 != i2 \/ j1 != j2) /\ (i1 == i2 \/ j1 == j2 \/ abs(i1 - i2) == abs(j1 - j2))) (
    queens[i1,j1] + rooks[i2,j2] <= 1
);

constraint forall(i1 in 1..n, j1 in 1..n, i2 in 1..n, j2 in 1..n where (i1 != i2 \/ j1 != j2) /\ (i1 == i2 \/ j1 == j2 \/ abs(i1 - i2) == abs(j1 - j2))) (
    queens[i1,j1] + bishops[i2,j2] <= 1
);

constraint forall(i1 in 1..n, j1 in 1..n, i2 in 1..n, j2 in 1..n where (i1 != i2 \/ j1 != j2) /\ (i1 == i2 \/ j1 == j2 \/ abs(i1 - i2) == abs(j1 - j2))) (
    rooks[i1,j1] + bishops[i2,j2] <= 1
);

% Objective: Maximize the total points
var int: total_points = sum(i in 1..n, j in 1..n) (
    bishops[i,j] * bishop_points + rooks[i,j] * rook_points + queens[i,j] * queen_points
);

solve maximize total_points;

% Output the solution
output [
    "Bishops:\n", show2d(bishops),
    "Rooks:\n", show2d(rooks),
    "Queens:\n", show2d(queens),
    "Total Points: ", show(total_points)
];