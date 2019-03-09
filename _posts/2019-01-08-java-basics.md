---
layout: post
current: post
cover: assets/images/java.png
navigation: True
title: "Refresher: Java Basics"
date: 2019-01-08 10:18:00
tags: java
class: post-template
subclass: 'post tag-speeches'
author: rob
---

# Topics - Java Basics Notes

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
  - Passed into method, as copies.  Those copies don't affect original variables (outer scope).  
    - Garbage collected when return/control passed back to calling object.
- Classes
  - Example:
  ```java 
  Flight val1 = new Flight(10)
  Flight val2 = new Flight(20)
  swap(val1, val2)
  void swap(Flight i, Flight j) {
    Flight k = i;
    i = j;
    j = k;
  }
  ```
  - In the above, references val1/val2 are not altered
    - New memory is allocated for reference type: i, j, k.
    - The pointers inside those reference type memory locations are swapped by the code.
    - When the method completes, and control passes back: i,j,k are garbage collected. 
  - Note **Important**, changes made inside of method to members of passes class instances do stick.

### Overloading
- Signature
  - Number of params
  - Type of params
  - Name
- Variable Number of params
  - See below

```java 
public void addPassengers(Passenger[] list) {
  if(hasSeating(list.length)) {
    passengers += list.length;
    for (Passenger passenger : list)
        ...
  }
}
```
  - Or

```java  
public void addPassengers(Passenger... list) {
```

## Class Inheritance
### Inheritance Basics and Typed References
- Java is an OO language and allows inherit/derive from other classes
- extends keyword

```java 
Flight f = new CargoFlight();
```
- In the above CargoFlight extends Flight
- In the above, you can't use any CargoFlight specific methods, only Flight methods.
  - Due to reference type of Flight, pointing to class instance of CargoFlight.
- Why do the above pattern? (aka instead of the more normal CargoFlight cf = new CargoFlight();)
  - This could be valuable when you have an unknown assortment of Flight instances and derived instances.
  - You don't have to do extra work to see what each type is before calling something.
  - You can depend on Flight based stuff being available.  Example:

```java 
Flight[] squadron = new Flight[5]
squadron[0] = new Flight();
squadron[1] = new CargoFlight();
...
```

### Member Hiding and Overriding
- Fields
  - If derived class has same field name, it can hide base class field if new'd with a base class type.
  - This can bite you if you call a base class method on a derived class instance.  
    - That base method only can see its local and class vars, so it will miss the derived classes hiding var.
  - See below

```java 
public class Flight {
    ...
    int seats = 150;
    ...
}
public class CargoFlight extends Flight {
    ...
    int seats = 12;
    ...
}
Flight f1 = new Flight();
// print f1.seats = 150
CargoFlight cf = new CargoFlight();
// print cf.seats = 12

// !!
Flight f2 = new CargoFlight();
// print f2.seats = 150
// Not 12, cargoflight derived class member var of name seats.
```

- Methods
  - A workaround to the above, use a overriding method definition that returns the desired value.
  - Example:
 
```java 
public class Flight {
    ...
    int getSeats() { return 150; };
    ...
}
public class CargoFlight extends Flight {
    ...
    int getSeats() { return 12; };
    ...
}
Flight f1 = new Flight();
// print f1.getSeats() = 150
CargoFlight cf = new CargoFlight();
// print cf.getSeats() = 12

// !!
Flight f2 = new CargoFlight();
// print f2.getSeats() = 12
// Not 12, cargoflight derived class member var of name seats.
```

  - We didn't have to do anything special to override.  In Java, override happens automagically.
    - Use @override annotation to be explicit and intentional.
  - You can do something special if you don't want it overridden.

### Object Class
- Root of Java class hierarchy
- Every class has characteristics of the Object class
- Useful for declaring variables, fields, and parameters that can reference any class or array instance
- Defines a number of methods that are inherited by all objects
- Every class inherits directly or indirectly from object class
- Examples:

```java 
Object[] stuff = new Object[3]
stuff[0] = new Flight();
stuff[1] = new Passenger(0, 2);
stuff[2] = new CargoFlight();

Object o = new Passenger();
o = new Flight[5];
o = new CargoFlight();
```
- Won't work
```java 
o.addPackage(1.0,2.5,3.0) //Nope
```
- Options

```java 
CargoFlight cf = o; //Compiler Nope
CargoFlight cf = (CargoFlight) o; //Yes.  Make sure it will actually be a CargoFlight everytime.
cf.addPackage(1.0,2.5,3.0) //Yes
```
- "Make sure it will actually be a CargoFlight everytime"
```java 
if(o instanceof CargoFlight) {
    ...
}
```

- Popular object class methods
  - clone - Create a new object instance that duplicates the current instance
  - hashCode - Get a hash code for the current instance
  - getClass - Return type information for the current instance
  - toString - Return string of characters representing the current instance.

### Equality
- Careful
- Example below.  f1/f2 point to two separate instances of flight class.
  - == operator only true if with reference types if both pointing to the same object.
    - Reference comparisons are very inexpensive
  - equals method from Object (base) class.  Need to override to use your business logic/problem space.
  
```java 
Flight f1 = new Flight(175)
Flight f2 = new Flight(175)

if(f1==f2) { //False.  Reference equals test.  Do these references both point to exact same instance?
    ...

if(f1.equals(f2)) { //False.  Using equals method from Object class, so doing same reference test above.
    ...
```
- Override equals method

```java 
class Flight {
    ...
    private int flightNumber;
    private int flightClass;
    
    @Override
    public boolean equals(Object o) {
        ... //check instanceof Flight
        Flight other = (Flight) o;
        return
            flightNumber == other.flightNumber &&
            flightClass == other.flightClass;
    }
```
- Now this is true 
```java 
if(f1.equals(f2)) 
```

### Special Reference: Super
- Similar to _this_, _super_ is an implicit reference to the current object
  - super treats the object as if it is an instance of its base class
  - Useful for accessing base class members that have been overridden 

### Using Final and Abstract
- By default, all classes can be extended
- Derived classes have the option to use or override inherited methods
  - A class can change these defaults
- Use **final** to prevent overriding

```java 
public final class Passenger { //No extending/derived classes on this
    ...
```
- More commonly, we do want to allow derived classes, we just want to control overriding certain methods
  - Mark method definition as final
- Conversely, abstract keyword requires inheriting and/or overriding
  - Mark method as abstract and don't provide a body, just end with a semicolon.

### Inheritance and Constructors
- Constructors are not inherited
- A derived class must always call one of the base class constructors
- As you define the derived class's constructor, it will call back to the base class
  - If you don't provide one, the no-arg constructor on the base class will be called by default
- You can explicitly call a base class constructor using super followed by parameter list
  - Must be first line in constructor
- Chaining is fine

## More About Data Types
### String Class
- The String class stores a sequence of Unicode characters
- Stored using UTF-16 encoding
- Literals are enclosed in double quotes
- String objects are immutable.  If you are doing alot of string work, will be inefficient with memory.
  - Each time you edit the string (ie add a space), a new memory allocation occurs for the entire new string
    - And the string reference type is repointed to the new string class instance
  - Use a string builder
- Equality
  - Two strings with same characters fail reference check ==
  - Equals method for string class would work, does a character by character comparison.
- Intern method to allow reference check to work

### String Representation of Non-String Values
- String.valueOf provides overrides to handle most types
- Conversions often happen implicitly
- Class conversions controlled by the class' toString method
  - If you drop a class reference into a string, you'll get the string representation of the class.
    - com.mydomain.foo.Flight@761337
  - Override to create more solution adapted output for class description.

### StringBuilder Class
- For optimal performance, set to a large value initially, growing buffer is not cheap.
```java 
StringBuilder sb = new StringBuilder(40)
Flight myFlight = new Flight(175);
String value = "strongbad";
sb.append(value)
sb.append("great")
sb.insert(11, "is "
String message = sb.toString();
```

### Primitive Wrapper Classes and Type Conversions
- Classes vs Primitives
  - Classes provide convenience
    - Common interaction through Object class
    - Fields and methods specific to the type
    - Con: Incurs an overhead cost
  - Primitives provide efficiency
    - Can't be treated as Object
    - Can't expose fields or methods
    - Pro: Lightweight
- Primitive wrapper classes
  - Capabilities and overhead of classes
  - Hold primitive values, interact with primitive values
  - All wrapper classes are immutable
- Object
  - Boolean
  - Character
  - Number
    - Byte
    - Short
    - Integer
    - Long
    - Float
    - Double
- Conversions between wrapper class and primitive
- Most common operations are automatic
```java 
Integer a = 100;
int b = a;
Integer c = b;
```
- Wrapper classes provide methods for explicit conversions
- Primitive to wrapper - valueOf "Boxing", ```Integer d = Integer.valueOf(100) ```
- Wrapper to Primitive xxxValue, "Unboxing", ```int e = d.intValue(); ```
- String to primitive parsexxx
- Note

```java 
String s = "87.44"; 
double s1 = Double.parseDouble(s);  //you are getting back a primitive type
double s2 = Double.valueOf(s); //returns back a reference to a wrapper class that has that value inside of it.
```

### Using Primitive Wrapper Classes
- Take advantage of capabilities that all classes have, while working with primitive types
- We can now treat the primitive type as an object
```java 
Object[] stuff = new Object[1]
stuff[0] = 100;
```
- In the above, Java will go head and get a reference to an instance of the integer wrapper class 
  - with a value of 100 
  - and assign that reference into stuff[0]
- Get utility of null references (code can check for null against prim wrapper class value, vs just raw primitive)

Class | Select Members
 --- | ---
 Byte, Short Integer, Long | MIN_VALUE, MAX_VALUE, bitCount, toBinaryString
 Float, Double | MIN_VALUE, MAX_VALUE, isInfinite, isNaN
 Character | TRUE, FALSE
 

### Wrapper Class Equality
- Certain boxing conversions will always return same reference (for the same value)
- Grid below: Boxing conversions that always return the same wrapper class instance

Primitive Type | Values
 --- | ---
int | -128 to 127
short | -128 to 127
byte | -128 to 127
char | '\u0000' to '\u00ff'
boolean | true, false

### Final Fields and Enumeration Types
- Fields we don't allow to be set, once they are initialized
  - Simple final field must be set during creation of an object instance
    - Field initializer, initialization block, or constructor
  - Adding a **static** modifier makes a final field a named constant.  
    - Cant' be set by object instance, value is tied to class itself
    - Convention is all caps (used for magic numbers)
- Enumeration types
  - Useful for defining a type with a finite list of valid values
  - Declare with enum keyword
  - Provide a comma-separated value list

```java 
public enum FlightCrewJob {
    Pilot,
    CoPilot,
    FlightAttendant,
    AirMarshall
}

public class CrewMember {
    private FlightCrewJob;
    ...
    public CrewMember(FlightCrewJob job) {
        this.job = job;
    }
}

CrewMember judy = new CrewMember(FlightCrewJob.CoPilot);
Judy.setJob(FlightCrewJob.Pilot);

```

## Exceptions and Error Handling
### Error Handling with Exceptions
### Handling Exceptions by Type
- Throwable class inherits from Object
- Error Class (handled in JVM)
- Exception class
  - Runtime Exception - errors that occur in your program
  - Runtime inheritance is consider non-checked exceptions
- Checked exceptions
 - Compiler requires you to handle

### Exceptions and Methods
- Exceptions propagate up the call stack, to a catch marker
  - Can cross method boundaries
  - Exceptions are part of a methods contract
  - Method is responsible for any checked exceptions that might occur
    - Catch the exception
    - Document that the exception might occur (use the **throws** clause)
- Method overriding
  - The throws clause of an overriding method must be compatible with the throws clause of the overridden method
    - Can exclude exception (is already handled in base class)
    - Can have the same exception
    - Can have a derived exception

### Throwing Exceptions and Custom Exceptions
- Your code can throw exceptions (use throw keyword)
- Must create exception instance before throwing (provide meaningful detail)
- Most exception classes provide a constructor that accepts a String message or other detail
- When caused by another exception, include originating exception
  - All exception classes support initClause method
  - Many provide a constructor that accepts the originating exception
- Custom exception types
  - In many cases better to use existing exception type
  - Normally inherit directly from Exception class (makes them checked)
  - Constructors are often their only members
    - Most required functionality is inherited
    - Have constructor that access required detail
    - Have constructor that accepts required detail and originating exception

## Working with Packages
### What is a Package
- Create a namespace
- Provide an access boundary
- Act as a unit of distribution
- Package declaration must appear before any type declarations
- Applies to all types within that source file

### Packages Create a Namespace
- Type name is qualified by the package name

### Determining a Types's Package
- Explicitly qualifying a type would be cumbersome
- Types in java.lang package do not need to be qualified
- Use type imports (import keyword).  Import is just a mapping for the complier.
- Single type import or import on demand with *
  - Single type is preferred, modern IDEs will add automatically

### Packages Provide Access Boundaries
- Packages can serve as an access boundary
  - Often referred to as package private
  - Useful for creating types and features to support functionality provided by package
    - Types and features are not meant to be used standalone
  - Can apply to a type
    - Entire type is accessible outside of the package
  - Can apply to type members
    - Specific members of an otherwise accessible type are inaccessible outside of the package

Modifier | Visbility | Usable on types | Usable on Members
 --- | --- | --- | ---
 no access modifier | Only within its own package (aka package private) | Y | Y
 public | Everywhere | Y | Y
 private | Only within its own class | N | Y
 protected | Only within its own class and subclasses | N* | Y

* As applies to top-level classes; can be applied to nested-classes

### Packages Act as a Unit of Distribution
- Packages provide a predictable software structure
  - Simplifies distribution
- Class files organized in hierarchical folders reflecting the package name
  - Each part of the package name is in a separate folder
- Archive files (jar)
  - Optionally includes a manifest (can identify startup class)
  - Can be compressed

## Creating Abstract Relationships with Interfaces
### Introducing Interfaces and Implementing an Interface
- In java, an interface is a type that defines a contract
- Contrast to Classes, Interfaces don't provide an implementation
- Classes implement interfaces - Express that the class conforms to the contract
- Interfaces don't limit other aspects of he class' implementation

```java 
public class Passenger implements Comparable {
    ...
    public int compareTo(Object o) {
    ...
}
```

### Implementing a Generic Interface
- Some Interfaces require additional type information, a concept known as generics
- Example

```java 
public class Flight implements Comparable<Flight> {
    ...
```

```java 
public interface Comparable<T> {
    int compareTo(T o);
```

-Get rid of casts

### Implementing Multiple Interfaces
- Classes are free to implement multiple interfaces

```java 
public class flight
    implements Comparable<Flight>, Iterable<Person> {
    ...
```

### Declaring an Interface
- Supports a subset of features available to classes
- Methods
  - Name, parameters, and return type
  - Implicitly public
- Constants
  - Typed and named values
  - Implicitly public, final, static
- Extending interfaces
  - An interface can extend another interface
  - Implementing extended interface implies implementation of base

## Static Members, Nested Types, and Anonymous Classes
### Static Members
- Class variable.  Static members are shared class wide, not individual instance.
- Field
- Method
  - Performs an action not tied to a specific instance
  - Can access static fields only

### Static Initialization Blocks
- Static initialization blocks perform one-time type initialization
- Executed before type's first use
- Statements enclosed in brackets outside of any method of constructor
  - Precede with static keyword
  - Can't access instance members
  - Must handle all checked exceptions

### Nested Types
- A nested type is a type declared within another type
- Classes can be declared within classes and interfaces
- Interfaces can be declared within classes and interfaces
- Nested members are members of the enclosing type
  - Private members of the enclosing type are visible to the nested type
- Nested types support all member access modifiers
  - public, package private, protected, private
- Structure and scoping
  - No relationship between instances of nested and enclosing type
  - Static classes nested between classes
  - All classes nested within interfaces
  - all nested interfaces

### Inner Classes
- Each instance of the nested class is associated with an instance of the enclosing class
- Non-static classes nested within classes

### Anonymous Classes
- Anonymous classes are declared as part of their creation
- Useful for simple interface implementations or class extensions
- An. classes are inner classes
  - An. instnce is associated with the containing class instance
- Create as if you are constructing an instance of the interface or base class
- Place opening and closing brackets after the interface of base class
- Place implementation code within the brackets
