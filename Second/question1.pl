
%The idea is to generate all permutations of the given operating sequence
%and store result form each one of them into a list and then find the max 
%element of that list.
%[hw2_1].
% maxval(tree(1,2),[minus],Max).

maxval(tree(X,Y),L,Max):-
	permute(L,L1),
	evaluate(tree(X,Y),L1,Max),
	

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

%part3
evaluate(tree(X,Y),L,Max):-
	L=[H|T],
	integer(Y),
	evaluate(X,T,M1),
	(
		H == 'plus' ->
			Max is M1+Y
		; H =='minus' ->
			Max is M1-Y
		; H == 'mult' ->
			Max is M1*Y
	),
	!.

%FinalPart
%We need to keep H and split T between two subtrees
evaluate(tree(X,Y),L,Max):-
	L=[H|T],
	integers(X,N1),

	Size1 is N1-1,
	rev(T,RT),
	length1(RT,N),
	Size2 is N- Size1,

	sublist(T,Size1,Temp1),
	rev(Temp1,L1),
	sublist(RT,Size2,Temp2),
	rev(Temp2,L2),


	evaluate(X,L1,R1),
	evaluate(Y,L2,R2),
	evaluate(tree(R1,R2),[H],Max),
	
	!.

%Helper
integers(tree(X,Y),2):-
	integer(X),
	integer(Y),
	!.

integers(tree(X,Y),N):-
	integer(X),
	N is M+1,
	integers(Y,M),
	!.

integers(tree(X,Y),N):-
	integer(Y),
	N is M+1,
	integers(X,M),
	!.

integers(tree(X,Y),N):-
	N is M1 + M2,
	integers(X,M1),
	integers(Y,M2),
	!.

%Helper
sublist([_|_],0,[]).
sublist([H|_],1,[H]).
sublist(L,N,L1):-
	L=[H|T],
	N1 is N-1,
	sublist(T,N1,L2),
	append(L2,H,L1).


%Helper Functions
rev([],[]).
rev([H|T],L):-
	rev(T,L1),
	append(L1,[H],L).

length1([], 0).
length1([_|Xs], M):-
	length1(Xs, N),
	M is N+1.

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

delete1([H|T],H,T).
delete1([H|Ys],X,[H|Zs]):-
	delete1(Ys,X,Zs).

permute([],[]).
permute([H|T],L):-
	permute(T,L1),
	delete1(L,H,L1).





