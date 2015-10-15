
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

tree(X,Y).

maxval(T,L,Max):-
	permute(L,L1),
	findValue(T,L1,Max).
	%Store in list //TODO

findValue(tree(X,Y),[H|T],R):-
	findValueHelper(tree(R1,R2),H,R,L2),
	findValueHelper(X,T,R1,L1),
	findValueHelper(Y,L1,R2,L2).

findValueHelper(tree(X,Y),[H],R,[]):-
	integer(X),
	integer(Y),
	(
		H == 'plus' ->
			R is X+Y
		; H =='minus' ->
			R is X-Y
		; H == 'mult' ->
			R is X*Y
	),
	!.

findValueHelper(tree(X,Y),[H|T],R,T):-
	integer(X),
	integer(Y),
	(
		H == 'plus' ->
			R is X+Y
		; H =='minus' ->
			R is X-Y
		; H == 'mult' ->
			R is X*Y
	).


% maxval(tree(tree(1,2),tree(3,4)),[plus,minus,mult],M).
	

























