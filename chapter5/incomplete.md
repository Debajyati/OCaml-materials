# Chapter 5 - Data Types
## Lists in OCaml
📜 List is a fundamental data type in OCaml. Lists are constructed using either square brackets ([]) or the double colon (::) operator, pronounced "nil" and "cons," respectively.
🔄 Lists are immutable, so creating a new list means adding elements to the beginning of another list.
🍬 The square brackets and semicolon syntax for lists is syntactic sugar for using nil and cons.
🧮 Evaluating lists involves evaluating the expressions within cons and handling type checking.
📝 List types are described using the "list" keyword and must contain elements of the same type.

### Facts
- Lists can be formed using square brackets ([]) or the double colon (::) operator.
- Square brackets represent the empty list, pronounced "nil".
- The double colon operator (e1 :: e2) prepends element e1 onto list e2, also known as "cons".
- Lists in programming are immutable, meaning they create new lists without altering existing ones.
- The square brackets and semicolon syntax for lists is a convenient way to use nil and cons.
- Evaluating lists involves evaluating expressions on both sides of the cons operator and returning the result.
- List types use the "list" keyword, describing lists with elements of the same type.
- The empty list can hold elements of any type, making it versatile for cons operations.
- Type checking ensures that the type of the element being consed matches the type of the list.
- The type of the resulting list in a cons operation is the same as the original list.

### Additional Information
- Lists can be nested within other lists.
- The "list" type keyword allows for type checking and ensures consistent element types within a list.
- The "cons" operator adds an element to the front of a list, maintaining the list's type integrity.


## Records & Tuples in Ocaml
📝 Records and tuples are two fundamental data types in OCaml. 

### Facts
- 📦 Records are a basic data type built into OCaml that allow the aggregation of data.
- 🛠️ Records are named and can contain fields with different data types.
- 💻 You can create a record type by defining its structure, like a "student" record with name (string) and graduation year (integer).
- 🧐 Records can be used to create values, like a student record including name & graduation year. Records are similar to structs in C.
- 🔄 You can load OCaml code into the interactive REPL environment (utop) using the "#use" directive followd by the filename inside double quotes.
- 🔄 Reloading a file in utop requires quitting and reopening utop to avoid confusion with old definitions.
- 📦 Tuples are another basic data type in OCaml used to aggregate data, but unlike records, their components are unnamed.
- 🧩 Tuples can be manually annotated with types, and their components can be accessed using "fst" and "snd" functions.


## Decision
🤔 When deciding between list, tuple, or record data types in OCaml, consider the data's length, access method (position or name), and whether it has bounded length.

### Facts
- 📋 If the data has unbounded length, choose a list, as lists are unbounded.
- 📏 Tuples and records have bounded lengths with a fixed number of components or fields.
- 🧐 For data with bounded length (e.g., representing camel attributes), consider using either a tuple or a record.
- 🕵️ Decide between tuple and record based on how you want to access the data:
  - 🔄 Tuple: Access by position (e.g., first or second component).
  - 📝 Record: Access by field name (e.g., "humps" or "riders" for camel attributes).


## Syntax & Semantics of Record
📜 This text introduces some facts about records, discussing their syntax, semantics, and type checking rules.

### Facts
- 📝 A new type definition is introduced using the `type` keyword, distinguishing between record types and tuple types.
- 🧱 Record types are defined inside curly braces with field names separated by semicolons and assigned expressions.
- ➡️ Field order in record types is irrelevant, and OCaml does not distinguish records based on field order.
- 📦 Records can have any number of fields, up to around four million.
- 🎯 Field access in records is achieved using the dot notation (e.g., `e.f`).
- 🧐 Field names in record access must be identifiers, not expressions.
- 📝 Evaluating records involves evaluating all expressions inside the record.
- 🔒 Record types must be defined before they are used for type checking.
- 🛠️ Type checking rules require sub-expressions in records to match the defined record type.
- ⚖️ Attempting to assign a value of the wrong type to a record field will result in a type error.
- 🔄 Record copy is a feature for creating a new record with updated field values, without mutating the original.
- 🍬 Record copy is syntactic sugar for rewriting the entire record with specified field updates.
- ❌ Record copy cannot be used to add new fields that would change the record's type.


