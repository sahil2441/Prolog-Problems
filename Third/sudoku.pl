%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% IMPORTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
member(X,[X|_]).
member(X,[_|Ys]):-
    member(X,Ys).

subset([], _).
subset([(P,RCS) | T], List):-
    member(P, List),
    valid(RCS),
    subset(T, List).

% Like \+member(H,T) but unbound cells are ignored
nonmember(_, []).
nonmember(H1, [H2|T]) :-
    (var(H2); H1 \= H2),
    nonmember(H1, T).

different([]).
different([H|T]):-
    (var(H); nonmember(H,T)),
    different(T),!.

valid([]).
valid([Head|Tail]) :- 
    different(Head), 
    valid(Tail),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hw3(InputListofLists, Output):-
    sudoku(InputListofLists,Output).

sudoku(Puzzle,Puzzle) :-
    Puzzle = [S11, S12, S13, S14,
              S21, S22, S23, S24,
              S31, S32, S33, S34,
              S41, S42, S43, S44],

    Row1 = [S11, S12, S13, S14],
    Row2 = [S21, S22, S23, S24],
    Row3 = [S31, S32, S33, S34],
    Row4 = [S41, S42, S43, S44],

    Col1 = [S11, S21, S31, S41],
    Col2 = [S12, S22, S32, S42],
    Col3 = [S13, S23, S33, S43],
    Col4 = [S14, S24, S34, S44],

    Square1 = [S11, S12, S21, S22],
    Square2 = [S13, S14, S23, S24],
    Square3 = [S31, S32, S41, S42],
    Square4 = [S33, S34, S43, S44],

    RCS11 = (S11, [Row1, Col1, Square1]),
    RCS12 = (S12, [Row1, Col2, Square1]),
    RCS13 = (S13, [Row1, Col3, Square2]),
    RCS14 = (S14, [Row1, Col4, Square2]),
    RCS21 = (S21, [Row2, Col1, Square1]),
    RCS22 = (S22, [Row2, Col2, Square1]),
    RCS23 = (S23, [Row2, Col3, Square2]),
    RCS24 = (S24, [Row2, Col4, Square2]),
    RCS31 = (S31, [Row3, Col1, Square3]),
    RCS32 = (S32, [Row3, Col2, Square3]),
    RCS33 = (S33, [Row3, Col3, Square4]),
    RCS34 = (S34, [Row3, Col4, Square4]),
    RCS41 = (S41, [Row4, Col1, Square3]),
    RCS42 = (S42, [Row4, Col2, Square3]),
    RCS43 = (S43, [Row4, Col3, Square4]),
    RCS44 = (S44, [Row4, Col4, Square4]),

    RCS = [RCS11, RCS12, RCS13, RCS14,
           RCS21, RCS22, RCS23, RCS24,
           RCS31, RCS32, RCS33, RCS34,
           RCS41, RCS42, RCS43, RCS44],

    subset(RCS, [1,2,3,4]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%% [sudoku].
%%%%%% test(2,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(N,NewPuzzle) :- puzzle(N,P), sudoku(P,NewPuzzle).

puzzle(1,P) :- 
   P = [3,4,1,_, 1,2,_,4, _,_,_,_, 4,3,2,_].
   

