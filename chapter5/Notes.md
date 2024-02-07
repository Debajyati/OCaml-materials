## Tail Recursion

Tail recursion in OCaml is a recursive function where the recursive call is the last operation,

```ocaml
let rec factorial n acc =
  if n <= 0 then acc
  else factorial (n - 1) (n * acc)
```

### Variant Scope

```ocaml
type t1 = C | D
type t2 = D | E
let x = D
```

In this kind of case t2 will overwrite t1.

## and keyword

the and keyword is used to define mutually recursive types

```ocaml

type 'a tree =
  | Leaf
  | Node of 'a node
and 'a node = {
  value: 'a;
  left: 'a tree;
  right: 'a tree;
}
```

The and keyword is used here to indicate that the definitions of 'a tree and 'a node are mutually recursive. This means that the definition of one type refers to the other, and vice versa.

In this case, a 'a tree can contain 'a node instances, and a 'a node can contain 'a tree instances.

## Common Built in List Functions

- List.length: Returns the length of a list.
- List.hd: Returns the first element of a list.
- List.tl: Returns all but the first element of a list.
- List.nth: Returns the nth element of a list.
- List.rev: Returns a list with the elements in reverse order.
- List.append: Returns a list with the second list appended to the first.
- List.flatten: Returns a list of all the elements of all the lists in a list.
- List.map: Returns a list of the results of applying a function to all the elements of a list.
- List.concat: Concatenates a list of lists into a single list.
- List.filter: Returns a new list containing only the elements that satisfy a given predicate.
- List.exists: Checks if a predicate holds for at least one element in the list.
- List.for_all: Checks if a predicate holds for all elements in the list.

###

print_endline;;

- : string -> unit = <fun>

TIP: For Nested Match cases use "()"

### Map Implementation

```ocaml
let rec transform f = function
| [] -> []
| h :: t -> f h :: transform f t
(** [add1 lst] adds 1 to each element of [lst] *)
let add1 = transform (fun x -> x + 1)
(** [concat_bang lst] concatenates "!" to each element of [lst] *)
let concat_bang = transform (fun x -> x ^ "!")
```

Note: Instead of

```ocaml
let add1 lst = transform (fun x -> x + 1) lst
```

above we wrote

```ocaml
let add1  = transform (fun x -> x + 1)
```

### Filter Implelmentation

```ocaml
let rec filter p = function
| [] -> []
| h :: t -> if p h then h :: filter p t else filter p t

```

### Combine

```ocaml
let rec combine op init = function
| [] -> init
| h :: t -> op h (combine op init t)
let sum = combine ( + ) 0
let concat = combine ( ^ ) ""
```
