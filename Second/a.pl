
%The idea is to generate all permutations of the given operating sequence
%and store result form each one of them into a list and then find the max 
%element of that list.
%[hw2_1].
%maxval(tree(1,2),['minus','plus'],Max).

delete1([H|T],H,T).
delete1([H|Ys],X,[H|Zs]):-
	delete1(Ys,X,Zs).

permute([],[]).
permute([H|T],L):-
	permute(T,L1),
	delete1(L,H,L1).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

%tree(X,Y).

maxval(T,L,Max):-
	permute(L,L1),
	findValue(T,L1,Max).
	%Store in list //TODO

%findValue(_,_,_,[]).
findValue(A,[H|_],R):-
	A =tree(X,Y),
	integer(X),
	integer(Y),
	(
		H == 'plus' ->
			R is X+Y
		; H =:='minus' ->
			R is X-Y
		; H =:= 'mult' ->
			R is X*Y
	).

findValue(tree(X,Y),L):-
	L=[H|T],
	findValue(tree(R1,R2),H,R,L2),
	findValue(X,T,R1,L1),
	findValue(Y,L1,R2,L2).

	
























