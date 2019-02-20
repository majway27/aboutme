---
layout: post
current: post
cover: assets/images/java.png
navigation: True
title: Java Refresher Notes
date: 2019-01-08 10:18:00
tags: java
class: post-template
subclass: 'post tag-speeches'
author: rob
---

# Topics - Java Refresher Notes

> Knock knock... Who's there?... ... very long pause ... Java! -industry joke

Editor Note:
- The material below was cobbled together for personal notes use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed Java material.

Sources: 
- Pluralsight
- Wikibooks
- Photo source by Alexander Gilbertson on Unsplash

## Runtime Environment
- Configuration
- Security
- Threading
- Input/Output Variables, Data Types, and Math Operators
end

## Variables, Data Types, and Math Operators
### Variables
- Name and use variables
- Named Data Storage
- Strongly Typed
```java 
int dataValue;
dataValue = 100;
// or
int myInfo = 200;
```

- Naming
  - Rules allow use of letters, numbers, $ and _.  
  - Convention - letters and numbers.  Camel Case
  - First char not number
```java 
int total; int bankAccountBalance; int grade4; int level2Training;
```  

- Variable Assignment
  - Assign value to another, not reference
  - "Copy by Value"
```java 
int myVar = 50;
int anotherVar = 100;
myVar = anotherVar;
System.out.println(myVar); // 100
anotherVar = 200;
System.out.println(myVar); // 100
```
end

### Primitive Data Types
- Behavior
- Most fundamental data types built into the language.  Foundation of all other types used in programs.
- 4 categories of **Primitive** types
  - Integer
  - Floating Point
  - Character
  - Boolean
  
- _Integer Types_

Type | Size (bits) | Min Value | Max Value | Literal Format
--- | --- | --- | --- | ---
byte | 8 | -128 | 127 | 0
short | 16 | -32768 | 32767 | 0
int | 32 | -2147483648 | 2147483647 | 0
long | 64 | -9223372036854775808 | 9223372036854775807 | 0L

```java 
byte numberOfEnglishLetters = 26;
short feetInAMile = 5283;
int milesToSun = 92960000;
long nationalDebt = 18100000000000L;
```

- _Floating Point Types_
  - Stores values containing a fractional portion
  - Supports positive, negative, and zero values
  - If you just put a literal, with a decimal, complier assumes double

Type | Size (bits) | Smallest Possible Value | Largest Possible Value | Literal Format
--- | --- | --- | --- | ---
byte | 32 | 1.4x10<sup>-9</sup> | 3.4x10<sup>38</sup> | 0.0f
short | 64 | 4.9x10<sup>-324</sup> | 1.7x10<sup>308</sup> | 0.0d

```java 
float milesInAMarathon = 26.2f
double atomWidthInMeters = 0.000000000001d; 
```

- _Character and Boolean_
  - The char type stores a single unicode character
  - Literal values placed between single quotes
  - For Unicode code points, use \u followed by 4-digit value
  - Bool literal values are true and false

````java 
char regularU = 'U'
boolean iLoveJava = true;
````

### Primitive Data Types are Stored by Value
- Important to understand for apps when we assign values from one variable to another
- Each primitive type variable has its own copy of the data

### Arithmetic Operators
- Basic operators +-/*%
- Prefix/Postfix operators ++ --
```java 
int myVal = 5;
System.out.println(++myVal) //6
System.out.println(myVal) //6
```
```java 
int myVal = 5;
System.out.println(myVal++) //5
System.out.println(myVal) //6
```

- Compound Assignment Operators +=, etc
  - Combines an operation and assignment
  - Applies result of right side to left side
  - Stores that result in variable on left side

### Operator Precedence
- Operators are evaluated in a well-defined order
  - Postfix x++
  - Prefix ++x 
  - Multiplicitive * / %
  - Additive +
- Operators of equal precedence are evaluated left-to-right
- Override with Parenthesis
- Nested Parens from inside out

### Type Conversion
- Implicit performed automatically by compiler
- Widening conversion are automatic
- Mixed Integer sides - Uses largest integer size in equation
- Mixed Floating Point sizes, uses double (largest FP size)
- Mixed integer and floating point, uses largest FP in equation
```java 
int iVal = 50;
long lVal = iVal;
```

- Explicit, performed explicitly with cast operator
- We take responsibility for result
- Can perform widening and narrowing
- Floating point to integer drops fraction.  Use caution with narrowing conversions.
- Integer to floating point can lose precision
```java 
long lVal = 50;
int iVal = (int) lVal;
```

## Conditional Logic, Looping, and Arrays
### Conditional Logic
- Relational Operators <, <=, ==, !=, etc
- Conditional Assignment, result = condition ? true-value : false-value;
- Block Statement

```java 
int v1 = 10, v2 = 4, diff
if (v1 > v2) {
  diff = v1 -v2;
  System.out.println("v1 is bigger");
  System.out.println(diff);
}
```

### Conditional Assignment

### if-else Statement

### Block Statements and Variable Scope
- A variable declared within a block is not visible outside of the block
  - A variable's range of visibility is known as the variable's scope.
- Variables that are in-scope, when the block starts, remain in scope.

### Logical Operators
- Note exclusive OR XOR, false^true true^false //true 
- Conditional Logic Operators -- note short-circuit eval

### Loops
- While.  Condition checked at loop start, may never execute code
- Do-while.  Condition checked at loop end.  Always executes at least once.
- For.  Convenience layout compared to while.  Cond checked at start.

### Arrays
- Provide an ordered collection of elements
```java 
float[] theVals = new float[3];
```

### For-each Loop
- Enhanced for loop
- Handles getting collection length, accessing each value

```java 
for (loop-variable-declaration:array)
  statement;
```

### Switch Stmt
- Only primitives supported are char and integer
- Don't forget breaks, or you'll fall through
- Cases and Default 

## Representing Complex Types with Classes
### Classes
- OO Lang encapsulates data, operations, and usage semantics (what you want to work on and how you want to work on it)
- Separates "what" is to be done from "how" it is done.  **Class implementer/author** focuses on _how_, **consumer/user** focuses on _what_.
- A Class is a template for creating an object.  
- Java source file name normally has same name as class.
- A class is made up of both state and executable code
  - **Fields**
    - Store object state
  - **Methods**
    - Executable code that manipulates state and performs operations
  - **Constructors**
    - Executable code used during object creation to set initial state

### Using Classes
- Use the new keyword to create a class instance (aka an object)
  - Declare variable.  Simply allocates space to store _reference_ to actual object we want to use.
  ```java 
  Flight nycToSf; 
  ```
  - Use new keyword, assign that the value of new flight.
  - The call to new flight allocates the memory associated with that class, **returns back** a reference to it.
  ```java 
  nycToSf = new Flight(); 
  ```
  - Variable nycToSf is not the object but a reference to it
  - All in one
  ```java 
  Flight nycToSf = new Flight();
  ```
  - Notice how created Flight object returns its reference, and is provided to reference constructor.
- **Classes are Reference Types**
  - Example1: Flight flight1 = new Flight();
    - Variable flight1 holds a **reference** to the newly created flight object.
  - Example2:
  ```java 
  Flight flight1 = new Flight();
  Flight flight2 = new Flight();
  flight2 = flight1;
  ```
  - In the above, the object flight1 isn't copied over flight2.  The reference variable is simply repointed.
- **So Reference Types and Primitive Types have some different behavior.**

### Encapsulation and Access Modifiers
- When using an object, a dev shouldn't need to know a whole lot about how it is built
- Encapsulation - hiding the internal representation of an object
- Java uses access modifiers to achieve encapsulation

 Modifier | Visibility | Usable on Classes | Usable on Members 
 --- | --- | --- | ---
 no access mod | Only within its own package (aka package private) | Y | Y 
 public | Everywhere | Y | Y 
 private | Only within its own class | N* | Y 
* As private applies to top level classes; private is available to nested classes

### Applying Access Modifiers
- Note: Once a class is marked as public, the file name must reflect the class name.
- ```java public class Flight { ... } // Flight.java ``` 

### Naming Classes
- Same rules as variable names
- Similar to variable naming convention, except:
  - Use only letters and numbers
  - First character is always a letter
  - Follow the style often referred to as "Pascal Case".  Start of each word, including first, is uppercase.  All others lower.
  - Use simple, descriptive nouns, avoid abbreviations.
  
### Method Basics
- Use verb or action statement
- Exiting: Unless there is an error, control returns to the method caller
- Returns
  - Single value
    - A primitive value
    - A reference to an object
    - A reference to an array (arrays are objects)
  - Example, see return value of a flight object
  ```java 
  public Flight createNewSpecialFlightBlah(...) {
    ...
    return newFlight;
  ```

### Special References: this and null
- Java provides special references with predefined meanings
- "this" is an implicit reference to the current object
  - Useful for reducing ambiguity
  - Allows an object to pass itself as a parameter
- "null" is a reference literal
  - Represents an uncreated object
  - Can be assigned to any reference variable
- Java Literals are syntactic representations of boolean, character, numeric, or string data. 
  - Literals provide a means of expressing specific values in your program.
- Both static and instance members of reference type not explicitly initialized are set to null by Java
- 0 for numeric values and false for booleans. 
- For variables declared in methods - Java requires them to be initialized
- **See Initializers below**

### Field Encapsulation, Accessors, and Mutators
- In most cases, a classes fields should not be directly accessible outside of the class.  Hide implementation details.
- Accessor/Mutator pattern  (ie getters and setters)

## Class Initializers and Constructors
### Establishing Initial State
- Field initializers
- Constructors
- Initialization blocks

### Field Initial State and Initializers
- A field's initial state is established as part of object construction
- Fields receive a 0 by default

byte, int, short, long | float, double | char | bool
--- | --- | --- | ---
0 | 0.0 | '\u0000' | false

- Field initializers allow you specify a field's initial value as part of it's declaration

### Constructor and Adding Multiple Constructors
- Differ by signatures, overloading

### Chaining Constructors and Constructor Visibility
- With multiple constructors, want to think about visibility
- Call to other constructor must be on first line

```java 
public class Passenger {
    ...
    public Passenger() {
    }
    public Passenger(int freeBags) {
        this(freeBags > 1 ? 25.0d : 50.0d);
        this.freeBags = freeBags;
    }
    public Passenger(int freeBags, int checkedBags) {
        this(freeBags);  // chained
        this.checkedBags = checkedBags;
    }
    private Passenger(double perBagFee) {
        this.perBagFee = perBagFee;
    }
}
```
- Note chaining above when a something like this happens: ```java Passenger jane = new Passenger(2,3); ```

### Initialization Blocks
- Initialization blocks shared across all constructors
  - Executed as if the code were placed at the start of each constructor

### Initialization and Construction Order
- Field Init (1)
- Init Block (2)
- Constructor (3)

```java 
public class OverInitClass {
    private int theField = 1; //first
    {
        theField = 2; //second
    }
    public OverInitClass() {
        theField = 3;  //last, what would print in a getter call.
    }
}
```

## A Closer look at Parameters
### Parameter Immutability
- In Java, when you call a method, you pass parameters into it.  Those parameter values are actually copied down into the parameter.
  - Passing by-value
- Because a copy is actually passed down there, any changes you make arn't visible outside of method.
- Primitive types
  - 
### Overloading
### Overloading Walkthrough
### Variable Number of Parameters

## Class Inheritance
### Inheritance Basics and Typed References
### Member Hiding and Overriding
### Object Class
### Equality
### Special Reference: Super
### Using Final and Abstract
### Inheritance and Constructors

## More About Data Types
### String Class
### String Equality
### String Representation of Non-String Values
### StringBuilder Class
### Primitive Wrapper Classes and Type Conversions
### Using Primitive Wrapper Classes
### Wrapper Class Equality
### Final Fields and Enumeration Types

## Exceptions and Error Handling
### Error Handling with Exceptions
### Handling Exceptions by Type
### Exceptions and Methods
### Throwing Exceptions and Custom Exceptions

## Working with Packages
### What is a Package
### Packages Create a Namespace
### Determining a Types's Package
### Packages Provide Access Boundaries
### Packages Act as a Unit of Distribution

## Creating Abstract Relationships with Interfaces
### Introducing Interfaces and Implementing an Interface
### Implementing a Generic Interface
### Implementing Multiple Intefaces
### Declaring an Interface

## Static Members, Nested Types, and Anonymous Classes
### Static Members
### Static Initialization Blocks
### Nested Types
### Inner Classes
### Anonymous Classes