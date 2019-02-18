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
### Encapsulation and Access Modifiers
### Applying Access Modifiers
### Naming Classes
### Method Basics
### Exiting from a Method
### Method Return Values
### Special References: this and null
### Field Encapsulation, Accessors, and Mutators

## Class Initializers and Constructors
### Establishing Initial State
### Field Initial State and Initializers
### Constructor and Adding Multiple Constructors
### Chaining Constructors and Constructor Visibility
### Initialization Blocks
### Initialization and Construction Order

## A Closer look at Parameters
### Parameter Immutability
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