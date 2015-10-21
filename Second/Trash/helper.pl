
%%%%%%%%%%%%%%%%%%%%%
%Helper Functions
%%%%%%%%%%%%%%%%%%

member(X,[X|_]).
member(X,[_|Ys]):-
	member(X,Ys).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

length1([], 0).
length1([_|Xs], M):-
	length1(Xs, N),
	M is N+1.

factorial(0,1).
factorial(N,F):-
	factorial(M,F1),
	F is N*F1,
	N is M+1.

delete1([H|T],H,T).
delete1([H|Ys],X,[H|Zs]):-
	delete1(Ys,X,Zs).

permute([],[]).
permute([H|T],L):-
	permute(T,L1),
	delete1(L,H,L1).

rev([],[]).
rev([H|T],L):-
	rev(T,L1),
	append(L1,[H],L).

revHelper([H|T],AccBefore,AccAfter):-
	revHelper(T,[H|AccBefore],AccAfter).
revHelper([],Acc,Acc).

rev2(L,L1):-
	revHelper(L,[],L1).

leaf(1).
leaf(2).
node(3,1,2).

%Inefficient Order n^2
preOrder(Root,[Root]):-
	leaf(Root).
preOrder(Root,[Root|L]):-	
	node(Root,LeftChild,RightChild),
	preOrder(LeftChild,L1),
	preOrder(RightChild,L2),
	append(L1,L2,L).

preOrder2(Root,L):-
	preOrderEfficient(Root,L,[]).

preOrderEfficient(Node,L,T):-
	node(Node,LeftChild,RightChild),
	L = [Node|L1],
	preOrderEfficient(LeftChild,L1,L2),
	preOrderEfficient(RightChild,L2,T).

preOrderEfficient(Node,[Node|T],T):-
	leaf(Node).

max(X,Y,Y):-
	Y>=X.

max(X,Y,X):-
	Y<X.

appendNew([H|T]-T,L,[H|NewTail]-NewTail):-
	NewTail =[T|L].

findLast([X],X).
findLast([_|T],X):-
	findLast(T,X).	

findK(_,[],'Nil').
findK(1,[H|_],H).
findK(K,[_|T],X):-
	findK(M,T,X),
	K is M+1.

reverse1([],[]).
reverse1([H|T],L):-
	reverse1(T,L1),
	append(L1,[H],L).

isPalindrome(L):-
	rev(L,L).

flatten([],[]).
flatten([H|T],L):-
	flatten(H,L1),
	flatten(T,L2),
	append(L1,L2,L).
flatten(L,[L]).	

%Inefficient-O(n^2)
postOrder(Root,[Root]):-
	leaf(Root).
postOrder(X,L):-
	node(X,LeftChild,RightChild),
	postOrder(LeftChild,L1),
	postOrder(RightChild,L2),
	append(L1,L2,Temp),
	append(Temp,[X],L).

%Inefficient-O(n^2)
inOrder(Root,[Root]):-
	leaf(Root).
inOrder(X,L):-
	node(X,LeftChild,RightChild),
	inOrder(LeftChild,L1),
	inOrder(RightChild,L2),
	append(L1,[X],Temp),
	append(Temp,L2,L).


postorder_dl(Root, L) :-
	postorder_dl(Root, L, []).
postorder_dl(Root, [Root|Tail], Tail) :-
	leaf(Root).
postorder_dl(Root, L, T) :-
	node(Root, C1, C2),
	postorder_dl(C1, L, T2),
	postorder_dl(C2, T2, [Root|T]).

preorder_dl(Root,L):-
	preorder_dl(Root,L,[]).
preorder_dl(Root,[Root|Tail],Tail):-
	leaf(Root).

preorder_dl(Root,L,T):-
	node(Root,LeftChild,RightChild),
	L = [Root|L1],
	preorder_dl(LeftChild,[L1|L2],L2),
	preorder_dl(RightChild,[L2|T],T).

range(Y,X,[]):-
	Y >X.
range(X,Y,[X|T]):-
	range(X1,Y,T),
	X is X1-1.


preorder_dnl(Root, L) :-
	preorder_d_l(Root, L-[]).
preorder_d_l(Root, [Root|L]-T) :-
	node(Root, C1, C2),
	preorder_d_l(C1, L-T1),
	preorder_d_l(C2, T1-T).
preorder_d_l(Root, [Root|T]-T).		

postorder_dnl(Root, L) :-
	postorder_d_l(Root, L-[]).
postorder_d_l(Root, L-T) :-
	node(Root, C1, C2),
	postorder_d_l(C1, L-T1),
	postorder_d_l(C2, T1-[Root|T]).
postorder_d_l(Root, [Root|T]-T).	


inorder_dnl(Root, L) :-
	inorder_d_l(Root, L-[]).
inorder_d_l(Root, L-T) :-
	node(Root, C1, C2),
	inorder_d_l(C1, L-[Root|T2]),
	inorder_d_l(C2, T2-T).
inorder_d_l(Root, [Root|T]-T).

append_dl(A-B, B-C, A-C).	

eliminate([],[]).
eliminate([H|T],[H|L]):-
	prefix(H,T,T2),
	eliminate(T2,L).

prefix(H,[H|T],L1):-
	prefix(H,T,L1).
prefix(_,L1,L1).

packList([],[]).
packList([H|T],[CurrentPack|L]):-
	Count is 1,
	get_count(H,T,Count),
	prefix(H,T,T2),
	CurrentPack=[H|Count],
	packList(T2,L).

pack_helper(H,[H|T],L1):-
	pack_helper(H,T,L1).
pack_helper(_,L1,L1).


divisible(M,X):-
	0 is X mod M,!.
divisible(M,X):-	
	N<X,
	divisible(N,X),
	M is N-1.
isPrime(2).
isPrime(X):-
	X<2,
	!,
	false.
isPrime(X):-
	not(divisible(2,X)).

primeList(0, []) :- !.
primeList(N, [N|L]) :-
    isPrime(N),
    !,
    primeList(NewN, L),
    N is NewN+1.

primeList(N, L) :-
    primeList(NewN, L),
    N is NewN+1.

naiveSort(X,L):-
	permute(X,L),
	isSorted(L).

isSorted([]).
isSorted([_]).
isSorted([H|T]):-
	T = [A|_],
	H=<A,
	isSorted(T).

quick_sort([],[]).
quick_sort([H|T],L):-
	pivoting(H,T,L1,L2),
	quick_sort(L1,Result1),
	quick_sort(L2,Result2),
	append(Result1,[H|Result2],L).

pivoting(_,[],_,_).
pivoting(H,[A|T],[A|L1],L2):-
	A=<H,
	pivoting(H,T,L1,L2).

pivoting(H,[A|T],L1,[A|L2]):-
	A>H,
	pivoting(H,T,L1,L2).

quick_sort2(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
	pivoting(H,T,L1,L2),
	q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

subsequence([H|T],[H|T2]) :- subsequence(T,T2).
subsequence([H|T],[H2|T2]) :- subsequence(T,[H2|T2]).
subsequence(_,[]).





