
%The idea is to generate all permutations of the given operating sequence
%and store result form each one of them into a list and then find the max 
%element of that list.
%[hw2_1].
% maxval(tree(1,2),[minus],Max).

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

maxval(tree(X,Y),L,Max):-
	permute(L,L1),
	evaluate(tree(X,Y),L1,Max).

%Spliting the evaluate fuction into four cases
%when both sub trees are atoms
%when exactly one of them is atom
%when both of them are not atoms

%part1
evaluate(tree(X,Y),L,Max):-
	L=[H],
	integer(X),
	integer(Y),
	(
		H == 'plus' ->
			Max is X+Y
		; H =='minus' ->
			Max is X-Y
		; H == 'mult' ->
			Max is X*Y
	),
	!.

%part2
evaluate(tree(X,Y),L,Max):-
	L=[H|T],
	integer(X),
	evaluate(Y,T,M1),
	(
		H == 'plus' ->
			Max is X+M1
		; H =='minus' ->
			Max is X-M1
		; H == 'mult' ->
			Max is X*M1
	),
	!.








