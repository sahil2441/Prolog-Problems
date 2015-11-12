% The idea is to group the given List L into subgroups based 
% on the friend. Then generate subsequences of the list and 
% find the max length subsequences of one list that is present in 
% other subsequences of some other friends group.

% maximalpleasure([journey(bozo,[heverlee, bertem, tervuren]),
% journey(bozo,[heverlee, korbeekdijle, tervuren]),
% journey(dork,[hammemille, korbeekdijle, tervuren, sterrebeek]),
% journey(dork,[hammemille, overijse, tervuren, sterrebeek])],
% 10,3,P).

maximalpleasure(L, TravelPleasure, NightPleasure, P):-

	% Make a list of names of friends
   	findall(X, generateFriendList(L,X), ListWithDuplicates),
	set(ListWithDuplicates,Friends),
%	write('\nFriends: '+Friends+'\n'),
	Friends=[H|T],
	T=[H1|T1],
	findall(Result,searchPath(L,H,Result),Set1),
	findall(Result,searchPath(L,H1,Result),Set2),

%	write('\nSet1: '+Set1+'\n'),
%	write('\nSet2: '+Set2+'\n'),

	Set1= [Head1|Tail1],
	Set2= [Head2|Tail2],

	append([Head1],[Head2],Pair1),
	append([Head1],Tail2,Pair2),
	append(Tail1,[Head2],Pair3),
	append(Tail1,Tail2,Pair4),
%	write('\nPair1: '+Pair1+'\n'),
%	write('\nPair2: '+Pair2+'\n'),
%	write('\nPair3: '+Pair3+'\n'),
%	write('\nPair4: '+Pair4+'\n'),

%	evaluate(Pair1,TravelPleasure,NightPleasure,Pleasure1),
%	evaluate(Pair2,TravelPleasure,NightPleasure,Pleasure2),
%	evaluate(Pair3,TravelPleasure,NightPleasure,Pleasure3),
%	evaluate(Pair4,TravelPleasure,NightPleasure,Pleasure4),

%	write('\nPleasure1: '+Pleasure1+'\n'),
	makeIntoList(Pleasure1,Pleasure2,Pleasure3,Pleasure4,P).


searchPath(L,X,Result):-
	member(Y,L),
	Y=journey(X,Result).

evaluate(Pair,TravelPleasure,NightPleasure,Pleasure):-
	Pair=[Route1|Route2],
	calculatePleasure(Route1,Route2,TravelPleasure,NightPleasure,Pleasure).

calculatePleasure([],_,_,_,0).
calculatePleasure(_,[],_,_,0).

calculatePleasure(Route1,Route2,TravelPleasure,NightPleasure,Pleasure):-
	Route1=[(H1,H2)|T1],
	Route2=[(H1,H2)|T2],
	calculatePleasure([H2,T1],[H2|T2],TravelPleasure,NightPleasure,Pleasure1),
	Pleasure is 2*NightPleasure+2*TravelPleasure + Pleasure1.

calculatePleasure(Route1,Route2,TravelPleasure,NightPleasure,Pleasure):-
	Route1=[(H1,X)|T1],
	Route2=[(H1,Y)|T2],
	calculatePleasure([X,T1],[Y|T2],TravelPleasure,NightPleasure,Pleasure1),
	Pleasure is 2*NightPleasure + Pleasure1.

calculatePleasure(Route1,Route2,TravelPleasure,NightPleasure,Pleasure):-
	Route1=[(_,X)|T1],
	Route2=[(_,Y)|T2],
	calculatePleasure([X,T1],[Y|T2],TravelPleasure,NightPleasure,Pleasure).

generateTravelLists(L,Friends,TravelList):-
	member(Friend,Friends),
	findall(TravelRoute,getTravelListForX(L,Friend,TravelRoute),TravelList).
	
getTravelListForX(L,Friend,TravelList):-
	member(X,L),
	X =journey(Friend,TravelList).
	
generateFriendList(L,Friend):-
	member(X,L),
	X =journey(Friend,_).	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Helper Functions 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member(X,[X|_]).
member(X,[_|Ys]):-
	member(X,Ys).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).
set([],[]).
set([H|T],[H|Out]) :-
    not(mymember(H,T)),
    set(T,Out).
set([H|T],Out) :-
    mymember(H,T),
    set(T,Out).

makeIntoList(A,B,C,D,List):-
	List is 4*4*2.

mymember(X,[X|_]).
mymember(X,[_|T]) :- mymember(X,T).