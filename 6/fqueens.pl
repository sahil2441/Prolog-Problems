%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% IMPORTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

board_size(5).
pos(1,1).
pos(2,5).
pos(3,3).
pos(5,2).
pos(5,5).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete1([H|T],H,T).
delete1([H|Ys],X,[H|Zs]):-
	delete1(Ys,X,Zs).

append1(A-B, B-C, A-C).

permute([],[]).
permute([H|T],L):-
	permute(T,L1),
	delete1(L,H,L1).

get_List(0,[]):-!.
get_List(N,[N|T]):-
	M is N-1,
	get_List(M,T).

get_list_from_P(_,[],[]):-!.
get_list_from_P(X,[H|T],L):-
	A=(X,H),
	append(L1,[A],L),
	Y is X+1,
	get_list_from_P(Y,T,L1).

solve(P) :-
	board_size(N),
	get_List(N,L),
    permute(L,P), 
    combine(L,P,S,D),
    all_diff(S),
    all_diff(D).

combine([X1|X],[Y1|Y],[S1|S],[D1|D]) :-
     S1 is X1 +Y1,
     D1 is X1 - Y1,
     combine(X,Y,S,D).
combine([],[],[],[]).

all_diff([X|Y]) :-  \+member(X,Y), all_diff(Y).
all_diff([_]).

minl([Only], Only).
minl([Head|Tail], Minimum) :-
	minl(Tail, TailMin),
	Minimum is min(Head, TailMin).

length1([], 0).
length1([_|Xs], M):-
	length1(Xs, N),
	M is N+1.

remove_duplicates([],[]):- !.
remove_duplicates([H|T],R):- member(H,T),remove_duplicates(T,R),!.
remove_duplicates([_|T],[_|Rest]):- remove_duplicates(T,Rest).

print_permutations([]):-!.
print_permutations([H|T]):-
	write(H),
	nl,
	print_permutations(T),
	!.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

moves(X):-
	findall(A,solve(A),L),
%	write("All Solutions: "), write(L),nl,
%	length1(L,L2),
%	write("No of Solutions: "), write(L2),nl,
	convert(L,L1),
%	print_permutations(L1),
	get_all_permutations(L1,Permutations),
	length1(Permutations,N1),
%	write("No of Permutations: "), write(N1),nl ,
	findall((X,Y),pos(X,Y),INPUT),
	findall(D,get_all_distances(Permutations,INPUT,D),Distances),
	minl(Distances,X),
	!.

convert([],[]):-!.
convert([H|T],R):-
	convert_helper(1,H,R1),
	append(R2,[R1],R),
	convert(T,R2),
	!.

convert_helper(X,_,[]):-
	board_size(N),
	X>N,
	!.
convert_helper(I,[H|T],R):-
	A=(I,H),
	J is I + 1,
	convert_helper(J,T,R1),
	append(R1,[A],R),
	!.

get_all_permutations([],[]):-!.
get_all_permutations([H|T],R):-
	findall(X,permutation(H,X),R1),
	append(R1,R2,R),
	get_all_permutations(T,R2),
	!.
	
get_all_distances(L,INPUT,D):-
	member(X,L),
	calculate_distance(X,INPUT,D).
%	write(X), write(" : "),write(INPUT),write(" : "), write(D), nl.

calculate_distance([],[],0):-!.
calculate_distance([H1|T1],[H2|T2],D):-
	H1=(X1,Y1),
	H2=(X2,Y2),
	DX is abs(X1-X2),
	DY is abs(Y1-Y2),
	D1 is max(DX,DY),
	calculate_distance(T1,T2,D2),
	D is D1+D2,
	!.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(X):-	
%	get_input(INPUT),
%	get_all_permutations(INPUT,P),
%	length1(P,X).
	moves(X).

get_input(INPUT):-
	INPUT =[
	[ (6,3), (5,6), (4,2), (3,5), (2,1), (1,4)],
[ (6,2), (5,4), (4,6), (3,1), (2,3), (1,5)],
[ (6,5), (5,3), (4,1), (3,6), (2,4), (1,2)],
[ (6,4), (5,1), (4,5), (3,2), (2,6), (1,3)]
].


getX(X):-
	X =  [ (1,2), (2,4), (3,1), (4,3)].

