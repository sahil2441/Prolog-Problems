%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%% sahjain@cs.stonybrook.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% IMPORTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rev([],[]).
rev([H|T],L):-
	rev(T,L1),
	append(L1,[H],L).

pivoting(_,[],_,_).
pivoting(H,[A|T],[A|L1],L2):-
	A=<H,
	pivoting(H,T,L1,L2).

pivoting(H,[A|T],L1,[A|L2]):-
	A>H,
	pivoting(H,T,L1,L2).

quick_sort([],[]).
quick_sort([H|T],L):-
	pivoting(H,T,L1,L2),
	quick_sort(L1,Result1),
	quick_sort(L2,Result2),
	append(Result1,[H|Result2],L).

length1([], 0).
length1([_|Xs], M):-
	length1(Xs, N),
	M is N+1.

member(X,[X|_]).
member(X,[_|Ys]):-
	member(X,Ys).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs) :- compress([X|Xs],Zs).
compress([X,Y|Ys],[X|Zs]) :- X \= Y, compress([Y|Ys],Zs).

getNameList([],[]).
getNameList([H|T], Names):-
	H=journey(X,_),
	getNameList(T,L1),
	append(L1,[X],Names).

getTravelList(_,[],[]).
getTravelList(Name,[H|T],[Y|L]):-
	H=journey(X,Y),
	X = Name,
	getTravelList(Name,T,L).
getTravelList(Name,[H|T],L):-
	H=journey(X,_),
	X \= Name,
	getTravelList(Name,T,L).

cartProduct([],_,[]):-!.
cartProduct(_,[],[]):-!.
cartProduct([H|T],L,Result):-
	makepairs(H,L,CurrentResult),
	cartProduct(T,L,Result1),
	append(Result1,CurrentResult,Result).

makepairs(_,[],[]):-!.
makepairs(X,[H|T],Result):-
	makepairs(X,T,Result1),
	append([X],[H],CurrentResult),
	append(Result1,[CurrentResult],Result).

calculatePleasure([],_,_,0).
calculatePleasure([H|T], TravellingPleasure, MeetingPleasure,Pleasure):-
	T=[X|_],
	calculatePleasureForTwoRoutes(H,X,TravellingPleasure,
		MeetingPleasure,Pleasure).

calculatePleasureForTwoRoutes([],_,_,_,0):-!.
calculatePleasureForTwoRoutes(_,[],_,_,0):-!.
calculatePleasureForTwoRoutes(A,B,TravellingPleasure,MeetingPleasure,Pleasure):-
	A=[H1|T1],
	B=[H2|T2],
	length1(T1,Len1),
	length1(T2,Len2),

	(
		H1=H2 ->
		(
			Len1>0 ->
				(
					Len2>0 ->
						T1=[H11|_],
						T2=[H22|_],
						(
							H11=H22 ->
							CurrentPleasure is 
							2*TravellingPleasure+2*MeetingPleasure 							
							;
							CurrentPleasure is 2*MeetingPleasure
						)
						;
						CurrentPleasure is 2*MeetingPleasure
				)
			;
			CurrentPleasure is 2*MeetingPleasure
		)
		;
		CurrentPleasure is 0
	),

	calculatePleasureForTwoRoutes(T1,T2,TravellingPleasure,
		MeetingPleasure,Pleasure1),
	Pleasure is Pleasure1 + CurrentPleasure.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% MAIN METHOD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

maximalpleasure([],_,_,0).
maximalpleasure(L,TravellingPleasure,MeetingPleasure,Pleasure):-
	getNameList(L,Names),
	compress(Names,Names1),
	Names1=[H,T|_],
	getTravelList(H,L,List1),
	getTravelList(T,L,List2),
	cartProduct(List1, List2, Pairs),
	obtainPleasureList(Pairs, TravellingPleasure, MeetingPleasure, Pleasures),
	quick_sort(Pleasures,SortedPleasures),
	rev(SortedPleasures,ReverseSortedPleasures),
	ReverseSortedPleasures= [Pleasure|_].

	
obtainPleasureList([],_,_,[]):-!.
obtainPleasureList(Pairs, TravellingPleasure, MeetingPleasure, Pleasures):-
	Pairs=[H|T],
	obtainPleasureList(T,TravellingPleasure,MeetingPleasure,L1),
	calculatePleasure(H,TravellingPleasure,MeetingPleasure,CurrentPleasure),
	append(L1,[CurrentPleasure],Pleasures).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%% [travel].
%%%%%%%%%%%% test(1,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(N,Result) :-   
	input(N,I),
	maximalpleasure(I,10,3,Result).

getL1(1,L):-
	L=[[heverlee, bertem, tervuren],
		[heverlee, korbeekdijle, tervuren]].

getL2(1,L):-
	L=[[hammemille, korbeekdijle, tervuren, sterrebeek],
		[hammemille, overijse, tervuren, sterrebeek]].

input(1,N):-
	N=[journey(bozo,[heverlee, bertem, tervuren]),
	journey(bozo,[heverlee, korbeekdijle, tervuren]),
	journey(dork,[hammemille, korbeekdijle, tervuren, sterrebeek]),
	journey(dork,[hammemille, overijse, tervuren, sterrebeek])].

input(2,N):-
	N=[
		journey(bozo,[heverlee, bertem, tervuren]),
		journey(dork,[hammemille, overijse, tervuren, sterrebeek])
		].

input(3,N):-
	N=[
		journey(bozo,[heverlee, bertem, tervuren]),
		journey(bozo,[heverlee, korbeekdijle, tervuren])
		].


