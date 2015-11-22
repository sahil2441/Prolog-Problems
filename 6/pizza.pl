%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE

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
n_pizzas(4).
pizza(1,10).
pizza(2,15).
pizza(3,20).
pizza(4,15).
n_vouchers(7).
voucher(1,1,1).
voucher(2,2,1).
voucher(3,2,2).
voucher(4,8,9).
voucher(5,3,1).
voucher(6,1,0).
voucher(7,4,1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete1([H|T],H,T).
delete1([H|Ys],X,[H|Zs]):-
	delete1(Ys,X,Zs).


length1([], 0).
length1([_|Xs], M):-
	length1(Xs, N),
	M is N+1.

permute([],[]).
permute([H|T],L):-
	permute(T,L1),
	delete1(L,H,L1).

minl([Only], Only).
minl([Head|Tail], Minimum) :-
	minl(Tail, TailMin),
	Minimum is min(Head, TailMin).

quick_sort([],[]).
quick_sort([H|T],Sorted):-
	pivoting(H,T,L1,L2),quick_sort(L1,Sorted1),quick_sort(L2,Sorted2),
	append(Sorted1,[H|Sorted2],Sorted),
	!.
   
pivoting(_,[],[],[]):-!.
pivoting(H,[X|T],[X|L],G):-
	X=pizza(_,A),H=pizza(_,B),A>B,
	pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):-
	X=pizza(_,A),H=pizza(_,B),A=<B,
	pivoting(H,T,L,G).

get_sorted_list(Pizzas,Pizzas_Sorted):-
	quick_sort(Pizzas,Pizzas_Sorted).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cost(X):-
	findall(voucher(X,Y,Z),voucher(X,Y,Z),Vouchers),
	findall(L1,permute(Vouchers,L1),L),
	findall(pizza(A,B),pizza(A,B),Pizzas),
	get_sorted_list(Pizzas,Pizzas_Sorted),
	findall(Cost,cost(L,Pizzas_Sorted,Cost),Costs),
	minl(Costs,X),
	!.

cost(L,Pizzas,Cost):-
	member(X,L),
	cost_helper(X,Pizzas,Cost).

cost_helper(_,[],0):-!.
cost_helper(L,Pizzas,Cost):-
	length1(L,X),
	X>0,
	L=[Voucher|Vouchers],
	Voucher=voucher(_,B,F),
	get_Buying_Cost(Pizzas,B,C1),
	N is B +F,
	update_Pizza(Pizzas,N,Pizzas_updated),
	cost_helper(Vouchers,Pizzas_updated,C2),
	Cost is C1+C2.

cost_helper(_,Pizzas,Cost):-
	length1(Pizzas,B),
	get_Buying_Cost(Pizzas,B,Cost).

update_Pizza(P,0,P):-!.
update_Pizza([_|T],N,P):-
	M is N-1,
	update_Pizza(T,M,P).

get_Buying_Cost(_,0,0):-!.
get_Buying_Cost([H|T],B,Cost):-
	H=pizza(_,C1),
	M is B-1,
	get_Buying_Cost(T,M,C2),
	Cost is C1+C2.


	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(X):-
	cost(X).

%	get_input(Pizzas_Sorted),
%	L=[[voucher(1,1,1)]],
%	findall(Cost,cost(L,Pizzas_Sorted,Cost),Costs).

get_input(L):-
	L = [pizza(3, 20), pizza(4, 15), pizza(1, 10), pizza(2, 5)].

	


