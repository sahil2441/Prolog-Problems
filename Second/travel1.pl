% The idea is to group the given List L into subgroups based 
% on the friend. Then generate subsequences of the list and 
% find the max length subsequences of one list that is present in 
% other subsequences of some other friends group.

% maximalpleasure([journey(bozo,[heverlee, bertem, tervuren]),
% journey(bozo,[heverlee, korbeekdijle, tervuren]),
% journey(dork,[hammemille, korbeekdijle, tervuren, sterrebeek]),
% journey(dork,[hammemille, overijse, tervuren, sterrebeek])],
% 10,3,P).

maximalPleasure(L, TravelPleasure, NightPleasure, P):-
	L=[H|T],
	T=[H1|T1],
	mmproduct(H,T1,X),
	mmproduct(H1,T1,Y).

mmproduct(M,N,R):- findall([X,Y],(member(X,M),member(Y,N)),R).

