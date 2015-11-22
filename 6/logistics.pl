%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% IMPORTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% :- import sort/2, findall/3 from setof.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% INPUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_size(6).
start(1).
dest(6).
edge(1,2,4).
edge(1,3,2).
edge(2,3,5).
edge(2,4,10).
edge(3,5,3).
edge(4,5,4).
edge(4,6,11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

member(X,[X|_]).
member(X,[_|Ys]):-
	member(X,Ys).

%append([],[L],L).
%append([H|T],X,[H|Y]):-
%	append(T,X,Y).

edges(E):-
	E=edge(_,_,_).

get_all_vertices(V):-
	graph_size(Size),
	findall(X,between(1,Size,X),V). 

powerset([],[]).
powerset(L, [H|T]):-
  append([H|T], _, L).
powerset([_|L], P):-
  powerset(L, P).

confirm_vertex_present(Vertices,G,M):-
	member(M,G),
	M=edge(X,Y,_),
	member(X,Vertices),
	member(Y,Vertices).

%%%%% MS Tree


ms_tree(graph([N|Ns],GraphEdges),graph([N|Ns],TreeEdges),Sum) :- 
   predsort(compare_edge_values,GraphEdges,GraphEdgesSorted),
   transfer(Ns,GraphEdgesSorted,TreeEdgesUnsorted),
   sort(TreeEdgesUnsorted,TreeEdges),
   edge_sum(TreeEdges,Sum).

compare_edge_values(Order,e(X1,Y1,V1),e(X2,Y2,V2)) :- 
	compare(Order,V1+X1+Y1,V2+X2+Y2).

edge_sum([],0).
edge_sum([e(_,_,V)|Es],S) :- edge_sum(Es,S1), S is S1 + V. 

find_min([X],X):-!.
find_min([H|T],H):-
	H < Min,
	find_min(T,Min),
	!.
find_min([_|T],Min):-
	find_min(T,Min).

delete_destination(V,[],V):-!.
delete_destination(V,[H|T],R):-
	delete(V,H,V1),
	delete_destination(V1,T,R).

extend_power_set([],L,[L]):-!.
extend_power_set([H|T],L,R):-
	append(H,L,H1),
	append(R1,[H1],R),
	extend_power_set(T,L,R1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

min_cost(Powerset_Extended):-
	findall(edge(X,Y,Z),edge(X,Y,Z),G),
	get_all_vertices(V),
	start(Start),
	findall(D,dest(D),Destinations),
	delete(V,Start,V1),
	delete_destination(V1,Destinations,V2),
	findall(R,powerset(V2,R),Powerset),
	append([Start],Destinations,L),
	extend_power_set(Powerset,L,Powerset_Extended).
%	findall(Cost,min_cost_helper(Powerset,G,Cost),Costs),
%	find_min(Costs,Cost).

min_cost_helper(Powerset,G,S):-
	member(X,Powerset),
	findall(Member,confirm_vertex_present(X,G,Member),G1),
	append([X],[G1],Input),

	human_gterm(H,Input),
    write(H), nl, 
   	ms_tree(G,T,S),
	human_gterm(TH,T),
   	write(S), nl,
	write(TH).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(X):-
%	get_input(G),
%	extend_power_set(G,[1,6],X).
	min_cost(X).

get_input(G):-
	G=[[1],[1,2]].
%	G=graph(
%		[a, b, c, d, e, f, g, h], 
%		[e(a, b, 5), e(a, d, 3), e(b, c, 2), e(b, e, 4), e(c, e, 6),
%		 e(d, e, 7), e(d, f, 4), e(d, g, 3), e(e, h, 5), e(f, g, 4), 
%		 e(g, h, 1)]
%		 ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% HELPER FUNCTIONS (83)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


s_tree(graph([N|Ns],GraphEdges),graph([N|Ns],TreeEdges)) :- 
   transfer(Ns,GraphEdges,TreeEdgesUnsorted),
   sort(TreeEdgesUnsorted,TreeEdges).

transfer([],_,[]).
transfer(Ns,GEs,[GE|TEs]) :- 
   select(GE,GEs,GEs1),     
   incident(GE,X,Y),
   acceptable(X,Y,Ns),
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   transfer(Ns2,GEs1,TEs).

incident(e(X,Y),X,Y).
incident(e(X,Y,_),X,Y).

acceptable(X,Y,Ns) :- memberchk(X,Ns), \+ memberchk(Y,Ns), !.
acceptable(X,Y,Ns) :- memberchk(Y,Ns), \+ memberchk(X,Ns).

is_tree(G) :- s_tree(G,G), !.
is_connected(G) :- s_tree(G,_), !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% HELPER FUNCTIONS (80)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alist_gterm(Type,AL,GT):- nonvar(GT), !, gterm_to_alist(GT,Type,AL).
alist_gterm(Type,AL,GT):- atom(Type), nonvar(AL), alist_to_gterm(Type,AL,GT).

gterm_to_alist(graph(Ns,Es),graph,AL) :- memberchk(e(_,_,_),Es), ! ,
   lgt_al(Ns,Es,AL).
gterm_to_alist(graph(Ns,Es),graph,AL) :- !, 
   gt_al(Ns,Es,AL).
gterm_to_alist(digraph(Ns,As),digraph,AL) :- memberchk(a(_,_,_),As), !,
   ldt_al(Ns,As,AL).
gterm_to_alist(digraph(Ns,As),digraph,AL) :- 
   dt_al(Ns,As,AL).

% labelled graph
lgt_al([],_,[]).
lgt_al([V|Vs],Es,[n(V,L)|Ns]) :-
   findall(T,((member(e(X,V,I),Es) ; member(e(V,X,I),Es)),T = X/I),L),
   lgt_al(Vs,Es,Ns).

% unlabelled graph
gt_al([],_,[]).
gt_al([V|Vs],Es,[n(V,L)|Ns]) :-
   findall(X,(member(e(X,V),Es) ; member(e(V,X),Es)),L), gt_al(Vs,Es,Ns).

% labelled digraph
ldt_al([],_,[]).
ldt_al([V|Vs],As,[n(V,L)|Ns]) :-
   findall(T,(member(a(V,X,I),As), T=X/I),L), ldt_al(Vs,As,Ns).

% unlabelled digraph
dt_al([],_,[]).
dt_al([V|Vs],As,[n(V,L)|Ns]) :-
   findall(X,member(a(V,X),As),L), dt_al(Vs,As,Ns).


alist_to_gterm(graph,AL,graph(Ns,Es)) :- !, al_gt(AL,Ns,EsU,[]), sort(EsU,Es).
alist_to_gterm(digraph,AL,digraph(Ns,As)) :- al_dt(AL,Ns,AsU,[]), sort(AsU,As).

al_gt([],[],Es,Es).
al_gt([n(V,Xs)|Ns],[V|Vs],Es,Acc) :- 
   add_edges(V,Xs,Acc1,Acc), al_gt(Ns,Vs,Es,Acc1). 

add_edges(_,[],Es,Es).
add_edges(V,[X/_|Xs],Es,Acc) :- V @> X, !, add_edges(V,Xs,Es,Acc).
add_edges(V,[X|Xs],Es,Acc) :- V @> X, !, add_edges(V,Xs,Es,Acc).
add_edges(V,[X/I|Xs],Es,Acc) :- V @=< X, !, add_edges(V,Xs,Es,[e(V,X,I)|Acc]).
add_edges(V,[X|Xs],Es,Acc) :- V @=< X, add_edges(V,Xs,Es,[e(V,X)|Acc]).

al_dt([],[],As,As).
al_dt([n(V,Xs)|Ns],[V|Vs],As,Acc) :- 
   add_arcs(V,Xs,Acc1,Acc), al_dt(Ns,Vs,As,Acc1). 

add_arcs(_,[],As,As).
add_arcs(V,[X/I|Xs],As,Acc) :- !, add_arcs(V,Xs,As,[a(V,X,I)|Acc]).
add_arcs(V,[X|Xs],As,Acc) :- add_arcs(V,Xs,As,[a(V,X)|Acc]).

% ---------------------------------------------------------------------------

% ecl_to_gterm(GT) :- construct a graph-term from edge/2 facts in the
%    program database.

ecl_to_gterm(GT) :-
   findall(E,(edge(X,Y),E=X-Y),Es), human_gterm(Es,GT).

% acl_to_gterm(GT) :- construct a graph-term from arc/2 facts in the
%    program database.

acl_to_gterm(GT) :-
   findall(A,(arc(X,Y),A= >(X,Y)),As), human_gterm(As,GT).

% ---------------------------------------------------------------------------

% human_gterm(HF,GT) :- convert between human-friendly and graph-term
%    representation.
%    (list,gterm) (+,?) or (?,+)

human_gterm(HF,GT):- nonvar(GT), !, gterm_to_human(GT,HF).
human_gterm(HF,GT):- nonvar(HF), human_to_gterm(HF,GT).

gterm_to_human(graph(Ns,Es),HF) :-  memberchk(e(_,_,_),Es), !, 
   lgt_hf(Ns,Es,HF).
gterm_to_human(graph(Ns,Es),HF) :-  !, 
   gt_hf(Ns,Es,HF).
gterm_to_human(digraph(Ns,As),HF) :- memberchk(a(_,_,_),As), !, 
   ldt_hf(Ns,As,HF).
gterm_to_human(digraph(Ns,As),HF) :- 
   dt_hf(Ns,As,HF).

% labelled graph
lgt_hf(Ns,[],Ns).
lgt_hf(Ns,[e(X,Y,I)|Es],[X-Y/I|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   lgt_hf(Ns2,Es,Hs).

% unlabelled graph
gt_hf(Ns,[],Ns).
gt_hf(Ns,[e(X,Y)|Es],[X-Y|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   gt_hf(Ns2,Es,Hs).

% labelled digraph
ldt_hf(Ns,[],Ns).
ldt_hf(Ns,[a(X,Y,I)|As],[X>Y/I|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   ldt_hf(Ns2,As,Hs).

% unlabelled digraph
dt_hf(Ns,[],Ns).
dt_hf(Ns,[a(X,Y)|As],[X>Y|Hs]) :-
   delete(Ns,X,Ns1),
   delete(Ns1,Y,Ns2),
   dt_hf(Ns2,As,Hs).

% we guess that if there is a '>' term then its a digraph, else a graph

human_to_gterm(HF,digraph(Ns,As)) :- memberchk(_>_,HF), !, 
   hf_dt(HF,Ns1,As1), sort(Ns1,Ns), sort(As1,As).
human_to_gterm(HF,graph(Ns,Es)) :- 
   hf_gt(HF,Ns1,Es1), sort(Ns1,Ns), sort(Es1,Es).
% remember: sort/2 removes duplicates!

hf_gt([],[],[]).
hf_gt([X-Y/I|Hs],[X,Y|Ns],[e(U,V,I)|Es]) :- !, 
   sort0([X,Y],[U,V]), hf_gt(Hs,Ns,Es).
hf_gt([X-Y|Hs],[X,Y|Ns],[e(U,V)|Es]) :- !,
   sort0([X,Y],[U,V]), hf_gt(Hs,Ns,Es).
hf_gt([H|Hs],[H|Ns],Es) :- hf_gt(Hs,Ns,Es).

hf_dt([],[],[]).
hf_dt([X>Y/I|Hs],[X,Y|Ns],[a(X,Y,I)|As]) :- !, 
   hf_dt(Hs,Ns,As).
hf_dt([X>Y|Hs],[X,Y|Ns],[a(X,Y)|As]) :- !,
   hf_dt(Hs,Ns,As).
hf_dt([H|Hs],[H|Ns],As) :-  hf_dt(Hs,Ns,As).

sort0([X,Y],[X,Y]) :- X @=< Y, !.
sort0([X,Y],[Y,X]) :- X @> Y.
