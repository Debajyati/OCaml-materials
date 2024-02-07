### Higher Order Functions
📝 We are exploring the concept of functions as data and their higher-order capabilities in OCaml.

### Facts
- Functions in OCaml are considered values and can be used interchangeably with other data types.
- Functions can take other functions as arguments.
- Functions can also return other functions as results, making them higher-order.
- Various examples demonstrate different ways of defining functions, such as double, square, quad, and fourth.
- These functions can be composed using the pipeline operator or by factoring out repeated actions.
- A function 'twice' can be created, which takes a function 'f' and an argument 'x' and applies 'f' to 'x' twice, showcasing higher-order functionality.
- Functions like 'quad' and 'fourth' can be defined as compositions of 'twice' and other functions.
- Higher-order functions can yield functions as outputs, making them versatile and powerful for functional programming.


### The Map function
🗺️ Map function implementation, which transforms elements of a list using a specified function, is explained. The implementation demonstrates the abstraction principle, reducing code duplication.

### Facts
- The key idea of the map function is to transform elements of a list using a provided function.
- Functions like adding one to every element of an integer list and concatenating a string with list elements can be implemented using map.
- The map function factors out repeated code, making code more efficient and maintainable.
- Map takes a function as an argument, which specifies how to transform each element.
- The input and output types of the function used with map may differ.
- The abstraction principle is applied, emphasizing the importance of factoring out recurring code patterns for more elegant and maintainable code.


### map,combine
- 💡 When using the "map" function, each element of a list is transformed independently without changing the list's length.
- 🔄 To combine list elements together, functions like sum and concat are introduced.
- 📝 The commonality between sum and concat functions lies in their structure, with differences in names, return values, and operators used for combination.
- 🧩 The abstraction principle suggests factoring out the code for combining list elements into a function called "combine."
- 🏁 The "combine" function takes an initial value and an operator to perform the combination.
- ➕ A "sum" function can be written using "combine" with an initial value of 0 and the plus operator.
- ➿ A "concat" function can be implemented using "combine" with an initial value of an empty string and the concat operator.
- 📚 The code for "combine" serves as the foundation for OCaml library functions known as "fold" and "reduce."


### fold_left, fold_right
🧮 Fold right accumulates values from the right to the left of a list, applying a function repeatedly to elements and an accumulated result. It's not tail recursive and takes stack space linear to the list size.
🔀 Fold left accumulates values from the left to the right of a list, also using a function, and is tail recursive. The accumulator is on the left side of the list.

### Facts
- 🧮 Fold right accumulates values from the right to the left of a list, combining them with a given function.
- 🔀 Fold left accumulates values from the left to the right of a list, also using a function.
- 👥 You can implement fold right and fold left by pattern matching against an empty list and a non-empty list.
- 🤝 The choice between fold right and fold left depends on the associativity and commutativity of the operator used. It can yield different results.
- 🧽 Fold left is tail recursive, requiring constant stack space, while fold right is not, and takes linear stack space.
- ↩️ You can achieve a tail-recursive fold from the right by reversing the list first, but this adds extra traversal time without increasing asymptotic complexity.


### Fold Left vs. Fold Right:
fold_left and fold_right are functions for folding over lists, but they process elements in opposite orders.
fold_left is tail-recursive and processes the list from left to right.
fold_right is not tail-recursive and processes the list from right to left.

### Map and Fold on Trees:
Functions like map and fold can be applied to data structures other than lists, such as trees.

### Pipelining:
Pipelining is a programming technique that chains multiple function calls together, passing the result of one function as the input to the next.
It enhances code readability but may introduce intermediate data structures.

### Currying:
Currying is the technique of converting a function that takes multiple arguments into a series of functions, each taking one argument.
OCaml supports both curried and uncurried function styles.

### Filter Function:
The filter function selects elements from a list that satisfy a given condition, creating a new list with those elements.
It's a higher-order function that abstracts the process of selecting items based on a predicate.

Example codes for each of the topics covered :

1. **Higher-Order Programming**:

   Example 1: Defining a Higher-Order Function
   ```ocaml
   let apply_twice f x = f (f x)
   ```

   Example 2: Using a Higher-Order Function
   ```ocaml
   let square x = x * x
   let result = apply_twice square 3
   ```

2. **Abstraction Principle**:

   Example 1: Abstraction with Map
   ```ocaml
   let map_increment lst = List.map (fun x -> x + 1) lst
   ```

   Example 2: Abstraction with Filter
   ```ocaml
   let filter_even lst = List.filter (fun x -> x mod 2 = 0) lst
   ```

3. **Map Function**:

   Example 1: Using Map to Double Elements
   ```ocaml
   let double_list lst = List.map (fun x -> x * 2) lst
   ```

   Example 2: Mapping a Function to a List of Strings
   ```ocaml
   let add_hello names = List.map (fun name -> "Hello, " ^ name) names
   ```

4. **Filter Function**:

   Example 1: Filtering Odd Numbers
   ```ocaml
   let filter_odd_numbers lst = List.filter (fun x -> x mod 2 = 1) lst
   ```

   Example 2: Filtering Strings by Length
   ```ocaml
   let filter_long_strings strings = List.filter (fun s -> String.length s > 5) strings
   ```

5. **Fold Function**:

   Example 1: Summing a List Using Fold
   ```ocaml
   let sum_list lst = List.fold_left (fun acc x -> acc + x) 0 lst
   ```

   Example 2: Combining Strings with Fold
   ```ocaml
   let concat_strings strings = List.fold_left (fun acc s -> acc ^ s) "" strings
   ```

6. **Tail Recursion and Combine**:

   Example 1: Tail-Recursive Sum of a List
   ```ocaml
   let sum_tail_recursive lst =
     let rec aux acc = function
       | [] -> acc
       | x :: xs -> aux (acc + x) xs
     in
     aux 0 lst
   ```

   Example 2: Tail-Recursive Combine
   ```ocaml
   let combine_tail_recursive lst =
     let rec aux acc = function
       | [] -> acc
       | x :: xs -> aux (x :: acc) xs
     in
     aux [] lst |> List.rev
   ```

7. **Fold Left vs. Fold Right**:

   Example 1: Using Fold Left
   ```ocaml
   let sum_list_fold_left lst = List.fold_left (fun acc x -> acc + x) 0 lst
   ```

   Example 2: Using Fold Right
   ```ocaml
   let sum_list_fold_right lst = List.fold_right (fun x acc -> x + acc) lst 0
   ```

8. **Map and Fold on Trees**:

   Example 1: Mapping a Function on a Tree
   ```ocaml
   type 'a tree =
     | Leaf
     | Node of 'a * 'a tree * 'a tree

   let rec map_tree f = function
     | Leaf -> Leaf
     | Node (v, l, r) -> Node (f v, map_tree f l, map_tree f r)
   ```

   Example 2: Folding a Tree
   ```ocaml
   let rec fold_tree f acc = function
     | Leaf -> acc
     | Node (v, l, r) -> f v (fold_tree f acc l) (fold_tree f acc r)
   ```

9. **Pipelining**:

   Example 1: Pipelining with List Operations
   ```ocaml
   let result =
     [1; 2; 3; 4; 5]
     |> List.map (fun x -> x * 2)
     |> List.filter (fun x -> x mod 3 = 0)
     |> List.fold_left (fun acc x -> acc + x) 0
   ```

   Example 2: Pipelining with String Operations
   ```ocaml
   let result =
     "This is a sample string"
     |> String.split_on_char ' '
     |> List.map String.length
     |> List.fold_left (fun acc len -> acc + len) 0
   ```

10. **Currying**:

    Example 1: Curried Function
    ```ocaml
    let add x y = x + y
    ```

    Example 2: Uncurried Function
    ```ocaml
    let add_uncurried (x, y) = x + y
    ```

These examples illustrate various concepts and techniques discussed in the document,
from higher-order programming to functional operations on lists and trees, and from pipelining to currying.
