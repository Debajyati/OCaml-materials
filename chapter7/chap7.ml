(* Problem 1 - Complex Synonym *)
module type ComplexSig = sig
  type t = float * float
  val zero : t
  val add : t -> t -> t 
end;;

(* Problem 2 - Complex Encapsulation *)
module Complex : ComplexSig = struct
  type t = float * float
  let zero = (0., 0.)
  let add (r1, i1) (r2, i2) = r1 +. r2, i1 +. i2
end;;

(* Problem 3 - big list queue *)
module type Queue = sig
(** An ['a t] is a queue whose elements have type ['a]. *)
type 'a t
(** Raised if [front] or [dequeue] is applied to the empty queue. *)
exception Empty
(** [empty] is the empty queue. *)
val empty : 'a t
(** [is_empty q] is whether [q] is empty. *)
val is_empty : 'a t -> bool
(** [enqueue x q] is the queue [q] with [x] added to the end. *)
val enqueue : 'a -> 'a t -> 'a t
(** [front q] is the element at the front of the queue. Raises [Empty]
if [q] is empty. *)
val front : 'a t -> 'a
(** [dequeue q] is the queue containing all the elements of [q] except the
front of [q]. Raises [Empty] is [q] is empty. *)
val dequeue : 'a t -> 'a t
(** [size q] is the number of elements in [q]. *)
val size : 'a t -> int
(** [to_list q] is a list containing the elements of [q] in order from
front to back. *)
val to_list : 'a t -> 'a list
end;;

module ListQueue : Queue = struct
(** The list [x1; x2; ...; xn] represents the queue with [x1] at its front,
followed by [x2], ..., followed by [xn]. *)
type 'a t = 'a list
exception Empty
let empty = []
let is_empty = function [] -> true | _ -> false
let enqueue x q = q @ [x]
let front = function [] -> raise Empty | x :: _ -> x
let dequeue = function [] -> raise Empty | _ :: q -> q
let size = List.length
let to_list = Fun.id
end;;
(* module ListQueue : Queue *)
(* Creates a ListQueue filled with [n] elements. *)

let fill_listqueue n =
  let rec loop n q =
    if n = 0 then q
    else loop (n - 1) (ListQueue.enqueue n q)
  in
  loop n ListQueue.empty;
;;
(* val fill_listqueue : int -> int ListQueue.t = <fun> *)

let time f x =
  let start = Unix.gettimeofday () in
  let _ = f x in
  let stop = Unix.gettimeofday () in
  stop -. start;;
(* val time : ('a -> 'b) -> 'a -> float = <fun> *)
time fill_listqueue 28000;;
(* - : float = 12.1186470985412598 *)
  
(* Problem 6 *)
type 'a bst =
  | Empty
  | Node of 'a bst * 'a * 'a bst;;

module type Map = sig
  (** [('k, 'v) t] is the type of maps that bind keys of type ['k] to
values of type ['v]. *)
  type ('k,'v) t 
  (** [empty] does not bind any keys. *)
  val empty : ('k,'v) t
  (** [insert k v m] is the map that binds [k] to [v], and also contains
all the bindings of [m]. If [k] was already bound in [m], that old
binding is superseded by the binding to [v] in the returned map. *)
  val insert : 'k ->'v  -> ('k,'v) t -> ('k,'v) t
  (** [lookup k m] is the value bound to [k] in [m]. Raises: [Not_found] if [k]
is not bound in [m]. *)
  val lookup : 'k -> ('k,'v) t -> 'v
  (** [bindings m] is an association list containing the same bindings as [m].
The keys in the list are guaranteed to be unique. *)
  val bindings : ('k,'v) t -> ('k * 'v) list

end;;

module BstMap : Map = struct
  type ('k, 'v) t =
    | Empty
    | Node of ('k * 'v) * ('k, 'v) t * ('k, 'v) t

  let empty : ('k, 'v) t = Empty

  let rec insert k v m =
    match m with
    | Empty -> Node ((k, v), Empty, Empty)
    | Node ((key, value), left, right) ->
      if k < key then
        Node ((key, value), insert k v left, right)
      else if k > key then
        Node ((key, value), left, insert k v right)
      else
        Node ((k, v), left, right)  (* Supersede the existing binding *)

  let rec lookup k m =
    match m with
    | Empty -> raise Not_found
    | Node ((key, value), left, right) ->
      if k = key then
        value
      else if k < key then
        lookup k left
      else
        lookup k right

  let rec bindings m =
    match m with
    | Empty -> []
    | Node ((key, value), left, right) ->
      bindings left @ [(key, value)] @ bindings right

end;;

(* Problem 7 - fraction *)
module type Fraction = sig
  (* A fraction is a rational number p/q, where q != 0.*)
  type t
  (** [make n d] is n/d. Requires d != 0. *)
  val make : int -> int -> t
  val numerator : t -> int
  val denominator : t -> int
  val to_string : t -> string
  val to_float : t -> float
  val add : t -> t -> t
  val mul : t -> t -> t
end;;

module Fraction : Fraction = struct
  type t = {numerator : int; denominator : int}

  let make n d = 
    if d = 0 then failwith "Denominator cannot be zero"
    else {numerator = n; denominator = d}

  let numerator f = f.numerator

  let denominator f = f.denominator

  let to_string f = 
    string_of_int f.numerator ^ "/" ^ string_of_int f.denominator

  let to_float f = 
    float_of_int f.numerator /. float_of_int f.denominator

  let add f1 f2 = 
    let n = f1.numerator * f2.denominator + f2.numerator * f1.denominator in
    let d = f1.denominator * f2.denominator in
    make n d

  let mul f1 f2 = 
    let n = f1.numerator * f2.numerator in
    let d = f1.denominator * f2.denominator in
    make n d
end
;;

(* Problem 8 - fraction reduced *)
module Fraction : Fraction = struct
  type t = {numerator : int; denominator : int}

  let rec gcd x y =
    if x = 0 then y
    else if (x < y) then gcd (y - x) x
    else gcd y (x - y)

  let make n d = 
    if d = 0 then failwith "Denominator cannot be zero"
    else 
      let divisor = gcd (abs n) (abs d) in
      let sign = if d < 0 then -1 else 1 in
      {numerator = sign * n / divisor; denominator = abs d / divisor}

  let numerator f = f.numerator

  let denominator f = f.denominator

  let to_string f = 
    string_of_int f.numerator ^ "/" ^ string_of_int f.denominator

  let to_float f = 
    float_of_int f.numerator /. float_of_int f.denominator

  let add f1 f2 = 
    let n = f1.numerator * f2.denominator + f2.numerator * f1.denominator in
    let d = f1.denominator * f2.denominator in
    make n d

  let mul f1 f2 = 
    let n = f1.numerator * f2.numerator in
    let d = f1.denominator * f2.denominator in
    make n d
end
;;

(* Problem 10 - use char map *)
module CharMap = Map.Make(Char);;
let charmap = CharMap.(empty |> add 'A' "Alpha" |> add 'E' "Echo" |> add 'S' "Sierra" |> add 'V' "Victor");;
(* val charmap : string CharMap.t = <abstr> *)
let e_binding = CharMap.find 'E' charmap;;
(* val e_binding : string = "Echo" *)
print_endline e_binding;;
(* - : unit = () *)
let charmap_without_a = CharMap.remove 'A' charmap;;
(* val charmap_without_a : string CharMap.t = <abstr> *)
let a_still_bound = CharMap.mem 'A' charmap_without_a;;
(* val a_still_bound : bool = false *)
print_endline (if a_still_bound then "A is still bound" else "A is not bound anymore");;
(* - : unit = () *)
let assoc_list = CharMap.bindings charmap;;
(* val assoc_list : (char * string) list =
  [('A', "Alpha"); ('E', "Echo"); ('S', "Sierra"); ('V', "Victor")] *)
List.iter (fun (key, value) -> Printf.printf "%c -> %s\n" key value) assoc_list;;
(* - : unit = () *)

(* Problem 12 - date order *)
type date = {month:int; day:int};;
module Date : Map.OrderedType with type t = date = struct
  type t = date
  (* Comparison function for dates *)

  let compare date1 date2 =
    if date1.month < date2.month then -1
    else if date1.month > date2.month then 1
    else if date1.day < date2.day then -1
    else if date1.day > date2.day then 1
    else 0

end
;;

(* Problem 13 - calendar *)
module DateMap = Map.Make(Date);;
type calendar = string DateMap.t;;
let new_Calendar:calendar = 
  let open DateMap in
    empty 
    |> add ({month=12;day=25}:date) "My Birthday"
    |> add ({month=8;day=15}:date) "Independence Day"
;;
(* Problem 14 - printing calendar *)
let print_calendar (cal : calendar) : unit =
  DateMap.iter (fun date event ->
    Printf.printf "%d/%d: %s\n" date.month date.day event
  ) cal
;;


