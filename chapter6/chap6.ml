(*Problem 1*)
let rec fold_right f lst acc =
  match lst with
  | []->acc
  | h::t -> f h (fold_right f t acc)
;;

let rec fold_left f acc = function
  | [] -> acc
  | hd::tl -> fold_left f (f acc hd) tl
;;

let product_right lst = fold_right (fun x y -> x *. y) lst 1.0;;
let product_left = fold_left (fun x y -> x *. y) 1.0;;

(*Problem 2*)
let terse_product_right lst = fold_right ( *. ) lst 1.0;;
let terse_product_left = fold_left ( *. ) 1.0;;

(*Problem 3 - sum_cube_odd function*)
let sum_cube_odd first last =
  let rec range i j = if i>j then [] else i :: range (i+1) j in
  fold_left (fun acc x -> acc + x*x*x) 0 (List.filter (fun x -> x mod 2 <> 0) (range first last));;

(* Problem 4 - sum_cube_odd function with pipeline operator *)
let psum_cube_odd i j =
  let rec from f l = if f>l then [] else f :: from (f+1) l in
  from i j
  |> List.filter (fun x -> x mod 2 <> 0)
  |> List.map (fun x -> x*x*x)
  |> fold_left (+) 0
;;

(*Problem 5*)
(*5.1*)
let rec exists_rec p li =
  match li with
  | [] -> false
  | x::xs -> p x || exists_rec p xs
;;

(*5.2*)
let exists_fold p li =
  fold_left (fun acc x -> acc || p x) false li
;;

(*5.3*)
let exists_lib p li =
  List.exists p li
;;

(*Problem 6 - Account Balance*)
(*6.1*)
let return_remaining_left debits balance =
  fold_left ( + ) 0 debits
  |> ( - ) balance
;;

(*6.2*)
let return_remaining_right debits balance =
  balance - (fold_right (+) debits 0)
;;

(*6.3*)
let return_remaining_rec debits balance =
  let rec sum = function
    | [] -> 0
    | h::t -> h + sum t
  in
  balance - (sum debits)
;;

(*Problem 7 - library uncurried*)
let uncurried_nth (lst, n) = List.nth lst n;;
let uncurried_append (augend,addend) = List.append augend addend;;
let uncurried_compare (ch1,ch2) = Char.compare ch1 ch2;;
let uncurried_max (num1,num2) = Stdlib.max num1 num2;;

(*Problem 8 - map composition*)
let combine (f,g) x = f (g x);;
let map_once (f,g) lst =
  List.map (combine (f,g)) lst
;;

(*Problem 9 - More list fun*)
let greaterThan3 li = List.filter (fun x -> x>3 = true) li;;
let add1 li = List.map (fun x -> x +. 1.0) li;;
let sentence strs sep =
  let hd = List.hd strs in
  let tl = List.tl strs in
  let lt = tl |> List.rev |> List.hd in
  let tl = tl |> List.rev |> List.tl |> List.rev in
  let accumulate lst = List.map (fun x -> x ^ sep) lst |> fold_left (^) "" in
  hd ^ sep ^ (accumulate tl) ^ lt
;;

(*Problem 10 - Association list keys*)
let uniq_keys assocli = assocli |> List.split |> (fun (x,y) -> x) |> List.sort_uniq Stdlib.compare;;

(*Problem 11 - valid matrix*)
type row_vector = int list;;
type matrix = row_vector list;;

let rec is_valid_matrix (mat:matrix) =
  match mat with
  | [] -> false
  | []::_ -> false
  | row::rows ->
      let num_of_cols = List.length row in
      let validity r = List.length r = num_of_cols in
      List.for_all validity rows
;;

(*Problem 12 - row vector addition*)
let add_row_vectors (v1:row_vector) (v2:row_vector) = if (List.length v1) <> (List.length v2) then failwith "Both Vectors must have same number of entries" else List.map2 (+) v1 v2;;

(*Unit Testing the function*)
let () =
  let row_vector1 = [1; 1; 1] in
  let row_vector2 = [9; 8; 7] in

  let result_vector = add_row_vectors row_vector1 row_vector2 in

  Printf.printf "Result vector: [%s]\n" (String.concat "; " (List.map string_of_int result_vector));;

(*Problem 13 - Matrix addition*)

let add_matrices matrix1 matrix2 =
  if (List.for_all is_valid_matrix [matrix1; matrix2]) &&
  (List.length (List.hd matrix1) = List.length (List.hd matrix2)) &&
  (List.length matrix2 = List.length matrix1) then
    List.map2 add_row_vectors matrix1 matrix2 else
      failwith "Both Matrix must be valid & of same order!"
;;

(* Example usage *)
let () =
  let matrix1 = [[1; 2; 3]; [4; 5; 6]] in
  let matrix2 = [[7; 8; 9]; [10; 11; 12]] in

  let result_matrix = add_matrices matrix1 matrix2 in

  Printf.printf "Result matrix:\n";
  List.iter (fun row ->
      Printf.printf "[%s]\n"
        (String.concat "; " (List.map string_of_int row))
  ) result_matrix;;

(*Problem 14 - Matrix Multiplication*)
let transpose matrix =
  match matrix with
  | [] -> []
  | [] :: _ -> []
  | _ ->
    let num_columns = List.length (List.hd matrix) in
    let rec transpose_helper matrix =
      match matrix with
      | [] -> List.init num_columns (fun _ -> [])
      | row :: rest ->
        List.map2 (fun x acc -> x :: acc) row (transpose_helper rest)
    in
    transpose_helper matrix
;;

let dot_product vector1 vector2 =
  List.fold_left2 (fun acc x y -> acc + x * y) 0 vector1 vector2
;;

let multiply_matrices matrix1 matrix2 =
  let transposed_matrix2 = transpose matrix2 in
  List.map (fun row1 ->
      List.map (fun col2 -> dot_product row1 col2) transposed_matrix2
    ) matrix1
;;

(* Unit Testing the function *)
let () =
  let matrix1 = [[1; 2; 3]; [4; 5; 6]] in
  let matrix2 = [[7; 8]; [9; 10]; [11; 12]] in

  let result_matrix = multiply_matrices matrix1 matrix2 in

  Printf.printf "Result matrix:\n";
  List.iter (fun row ->
      Printf.printf "[%s]\n"
        (String.concat "; " (List.map string_of_int row))
    ) result_matrix;
;;
