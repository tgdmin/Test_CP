
% Size
int: N = 8;  % Board size

% Points
int: bis_points = 1;
int: kni_points = 2;
int: ro_points = 3;

% Board representation
array[1..N, 1..N] of var 0..3: board;  % 0 = empty, 1 = bishop, 2 = knight, 3 = rook

% no two pieces attack each other

% at most one piece per row
constraint forall(i in 1..N) (
    sum([board[i, j] > 0 | j in 1..N]) <= 1
);

% at most one piece per column
constraint forall(j in 1..N) (
    sum([board[i, j] > 0 | i in 1..N]) <= 1
);

% Diagonal constraints for bishops
constraint forall(d in 2-N..N-2) (
    sum([board[i, j] == 1 | i in 1..N, j in 1..N where i-j == d]) <= 1
);
constraint forall(d in 2..2*N-2) (
    sum([board[i, j] == 1 | i in 1..N, j in 1..N where i+j == d]) <= 1
);

% Knight attack constraints
constraint forall(i1 in 1..N, j1 in 1..N, i2 in 1..N, j2 in 1..N where (i1 != i2 \/ j1 != j2)) (
    (abs(i1 - i2) == 2 /\ abs(j1 - j2) == 1) \/ (abs(i1 - i2) == 1 /\ abs(j1 - j2) == 2) -> (board[i1, j1] != 2 \/ board[i2, j2] != 2)
);

% Rook attack constraints (no two rooks in the same row or column)
constraint forall(i in 1..N) (
    sum([board[i, j] == 3 | j in 1..N]) <= 1
);
constraint forall(j in 1..N) (
    sum([board[i, j] == 3 | i in 1..N]) <= 1
);

% Maximize the total score
solve maximize sum(i in 1..N, j in 1..N) (
    if board[i, j] == 1 then bis_points
    elseif board[i, j] == 2 then kni_points
    elseif board[i, j] == 3 then ro_points
    else 0 endif
);

% Output the total points
output [ "Total Points: ", show(sum(i in 1..N, j in 1..N) (
        if board[i, j] == 1 then bis_points
        elseif board[i, j] == 2 then kni_points
        elseif board[i, j] == 3 then ro_points
        else 0 endif))];
