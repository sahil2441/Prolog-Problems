%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%% sahjain@cs.stonybrook.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% IMPORTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 :- import is_list/1, append/3  from basics.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


flatten1(X,[X]) :- \+ is_list(X).
flatten1([],[]).
flatten1([X|Xs],Zs) :- flatten1(X,Y), flatten1(Xs,Ys), append(Y,Ys,Zs).

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
    Puzzle = [S11, S12, S13, S14, S15, S16,
              S21, S22, S23, S24, S25, S26,
              S31, S32, S33, S34, S35, S36,
              S41, S42, S43, S44, S45, S46,
              S51, S52, S53, S54, S55, S56,
              S61, S62, S63, S64, S65, S66
              ],

    Row1 = [S11, S12, S13, S14, S15, S16],
    Row2 = [S21, S22, S23, S24, S25, S26],
    Row3 = [S31, S32, S33, S34, S35, S36],
    Row4 = [S41, S42, S43, S44, S45, S46],
    Row5 = [S51, S52, S53, S54, S55, S56],
    Row6 = [S61, S62, S63, S64, S65, S66],

    Col1 = [S11, S21, S31, S41, S51, S61],
    Col2 = [S12, S22, S32, S42, S52, S62],
    Col3 = [S13, S23, S33, S43, S53, S63],
    Col4 = [S14, S24, S34, S44, S54, S64],
    Col5 = [S15, S25, S35, S45, S55, S65],
    Col6 = [S16, S26, S36, S46, S56, S66],

    Rectangle1 = [S11, S12, S13, S21, S22, S23],
    Rectangle2 = [S14, S15, S16, S24, S25, S26],
    Rectangle3 = [S31, S32, S33, S41, S42, S43],
    Rectangle4 = [S34, S35, S36, S44, S45, S46],
    Rectangle5 = [S51, S52, S53, S61, S62, S63],
    Rectangle6 = [S54, S55, S56, S64, S65, S66],

    RCS11 = (S11, [Row1, Col1, Rectangle1]),
    RCS12 = (S12, [Row1, Col2, Rectangle1]),
    RCS13 = (S13, [Row1, Col3, Rectangle1]),
    RCS14 = (S14, [Row1, Col4, Rectangle2]),
    RCS15 = (S15, [Row1, Col5, Rectangle2]),
    RCS16 = (S16, [Row1, Col6, Rectangle2]),

    RCS21 = (S21, [Row2, Col1, Rectangle1]),
    RCS22 = (S22, [Row2, Col2, Rectangle1]),
    RCS23 = (S23, [Row2, Col3, Rectangle1]),
    RCS24 = (S24, [Row2, Col4, Rectangle2]),
    RCS25 = (S25, [Row2, Col5, Rectangle2]),
    RCS26 = (S26, [Row2, Col6, Rectangle2]),


    RCS31 = (S31, [Row3, Col1, Rectangle3]),
    RCS32 = (S32, [Row3, Col2, Rectangle3]),
    RCS33 = (S33, [Row3, Col3, Rectangle3]),
    RCS34 = (S34, [Row3, Col4, Rectangle4]),
    RCS35 = (S35, [Row3, Col5, Rectangle4]),
    RCS36 = (S36, [Row3, Col6, Rectangle4]),


    RCS41 = (S41, [Row4, Col1, Rectangle3]),
    RCS42 = (S42, [Row4, Col2, Rectangle3]),
    RCS43 = (S43, [Row4, Col3, Rectangle3]),
    RCS44 = (S44, [Row4, Col4, Rectangle4]),
    RCS45 = (S45, [Row4, Col5, Rectangle4]),
    RCS46 = (S46, [Row4, Col6, Rectangle4]),

    RCS51 = (S51, [Row5, Col1, Rectangle5]),
    RCS52 = (S52, [Row5, Col2, Rectangle5]),
    RCS53 = (S53, [Row5, Col3, Rectangle5]),
    RCS54 = (S54, [Row5, Col4, Rectangle6]),
    RCS55 = (S55, [Row5, Col5, Rectangle6]),
    RCS56 = (S56, [Row5, Col6, Rectangle6]),

    RCS61 = (S61, [Row6, Col1, Rectangle5]),
    RCS62 = (S62, [Row6, Col2, Rectangle5]),
    RCS63 = (S63, [Row6, Col3, Rectangle5]),
    RCS64 = (S64, [Row6, Col4, Rectangle6]),
    RCS65 = (S65, [Row6, Col5, Rectangle6]),
    RCS66 = (S66, [Row6, Col6, Rectangle6]),

    RCS = [
            RCS11, RCS12, RCS13, RCS14, RCS15, RCS16,
            RCS21, RCS22, RCS23, RCS24, RCS25, RCS26,
            RCS31, RCS32, RCS33, RCS34, RCS35, RCS36,
            RCS41, RCS42, RCS43, RCS44, RCS45, RCS46,
            RCS51, RCS52, RCS53, RCS54, RCS55, RCS56,
            RCS61, RCS62, RCS63, RCS64, RCS65, RCS66
            ],

    subset(RCS, [1,2,3,4,5,6]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%% [sudoku6].
%%%%%%%%%%%% test(1,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(N,NewPuzzle) :- puzzle(N,P), sudoku(P,NewPuzzle).
testF(1,X):-         puzzle(1,P), flatten1(P,X).

puzzle(1,P) :- 
   P = [
        [_,_,_,_,_,_],
        [_,_,_,_,_,_],
        [_,_,_,_,_,_],
        [_,_,_,_,_,_],
        [_,_,_,_,_,_],
        [_,_,_,_,_,_]
       
       ].












