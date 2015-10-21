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

 %:- import append/3  from basics.
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs) :- compress([X|Xs],Zs).
compress([X,Y|Ys],[X|Zs]) :- X \= Y, compress([Y|Ys],Zs).

getNameList([H],[X]):-
	H=journey(X,_).
getNameList([H|T], Names):-
	H=journey(X,_),
	getNameList(T,L1),
	append(L1,[X],Names).

getTravelList(_,[],[]).
getTravelList([],_,[]).
getTravelList(Name,[H|T],L):-
	H=journey(X,Y),
	(
		X = Name ->
		append(L1,[Y],L)
		;
		true
	),
	getTravelList(Name,T,L1).




	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% MAIN METHOD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%% [travel].
%%%%%%%%%%%% test(1,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(N,Result) :-   input(N,P), 
					getTravelList(bozo,P,Result).

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



