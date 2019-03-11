---
layout: post
current: post
cover: assets/images/java.png
navigation: True
title: "Refresher: Java Core"
date: 2019-01-08 10:18:00
tags: java
class: post-template
subclass: 'post tag-speeches'
author: rob
---

# Topics - Java Core Notes

> At my core, I know that the American Dream is about the opportunity to work hard and make your future - Tammy Duckworth

Editor Note:
- The material below was cobbled together for personal notes use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed Java material.

Sources: 
- Pluralsight
- Photo source by Alexander Gilbertson on Unsplash

## Input and Output with Streams and Files
### Streams Overview
- Streams provide a common i/o model
- Abstracts details of underlying source or destination
- Streams are unidirectional, either read-to or write from
- Two categories of streams
  - Byte streams - interact as binary data
  - Text streams - interact as Unicode characters
  - The interaction model is the same for both streams

### Reading an Writing with Streams
- Base class for working with Binary data is InputStream
- working with Text data - Reader class
- Read individual byte - int read() method
 
```java 
# Reading one byte at a time
InputStream input = 
int intVal;
while ((intVal = input.read()) >=0) { //indicates EOS with return val of -1
    byte byteVal = (byte) intVal;
    // do something
}

# Reading from a character stream/reading one character at a time
Reader reader = 
int intVal;
while ((intVal = reader.read()) >=0) {
    char charVal = (char) intVal;
    // do something
}

# Reading array of bytes
InputStream input = 
int length;
byte[] byteBuff = new byte[10];
while ((length = input.read(byteBuff)) >= 0) {
    for(int i=0; i < length; i++) {
        byte byteVal = byteBuff[i];
        // do something
    }
}

# Reading array of characters
Reader reader = 
int length;
char[] charBuff = new char[10];
while ((length = input.read(byteBuff)) >= 0) {
    for(int i=0; i < length; i++) {
        byte byteVal = byteBuff[i];
        // do something
    }
}

# Writing bytes
OutputStream output =

byte byteVal = 100;
output.write(byteVal);

byte[] byteBuff = {0,63,127};
output.write(byteBuff);

# Writing Characters
Writer writer =

char charVal = 'a';
writer.write(charVal);

char[] charBuff = {'a','b','c'};
writer.write(charBuff);

String stringVal = "Hello World";
writer.write(stringVal);

```
 

### Common Stream Classes
- Common Input/OutputStream derived classes
- InputStream
  - ByteArrayInputStream
  - PipedInputStream
  - FileInputStream
- OutputStream
  - ByteArrayOutputStream
  - PipedOutputStream
  - FileOutputStream
- Reader
  - CharArrayReader
  - StringReader
  - PipedReader
  - InputStreamReader - File Reader
- Writer
  - CharArrayWriter
  - StringWriter
  - PipedWriter
  - OutputStreamWriter - File Writer

### Stream Errors and Cleanup
- Realities
  - Error Handling
  - Cleanup
- Streams are backed by physical storage
  - Often exist outside Java runtime, may not reliably cleanup
  - Streams implement Closable interface, method .close()
  
```java 
Reader reader;
try {
    reader = //open reader
    // do something
} catch (IOException e) {
    // handle ex
} finally {
    try {
        if(reader != null)
            reader.close();
    } catch(IOException e2) {
        // handle
    }
}

```

- Provide support for try-with-resources, Closable interface implemented
- Streams implement Closable interface
- Try-with-resources
  - Automates cleanup of 1 or more resources
  - A resource is any type that implements AutoClosable
  - Syntax similar to try, optionally includes catch block

### Chaining Streams
- Streams are often chained together
  - One stream instance leverages another
  - Creates higher-level functionality
  - Simplifies reusability
  - Chain using constructor
- InputStreamReader leverages chaining
  - Provides Reader behavior over InputStream
  - Character behavior over binary
  
```java 
# Chaining Streams
void doChain(InputStream in) throws IOException {
    int length;
    char[] charBuff = new char[128];
    try (InputStreamReader rdr = new InputStreamReader(in)) {
        while((length = rdr.read(charBuff)) >= 0) {
            //do stuff
        }
    }  // Try-with-resources automatically closes InputStreamReader
       // InputStreamReader then closes InputStream
}

- Can create your own high-level streams
  - Most commonly chain similar streams
  - Chain a reader over a reader, etc
- Pattern so popluar that classes are available to simplify customization
  - FilterReader, FilterWriter, FilterInputStream, FilterOutputStream
  - Abstract classes
  - Methods call to contained stream methods
  - Override only customized methods

```

### File and Buffered Streams
- Often use streams for file-based i/o
- Class for each stream type in java.io package
  - FileReader
  - FileWriter
  - FileInputStream
  - FileOutputStream
- The java.io classes are now deprecated
  - Still widely used
- Direct file access is inefficient
- Buffered streams can improve efficiency
  - Buffers content in memory
  - Performs reads/writes in large chunks
  - Reduces underlying stream interaction
- Buffering available for all 4 stream types
  - BufferedReader
  - BufferedWriter
  - BufferedInputStream
  - BufferedOutputStream
- BufferedStreams handle line breaks (win/nix)
  - BufferedWriter - newLine()
  - BufferedReader - readLine()

```java 
# Buffered Streams
try (BufferedReader br =
        new BufferedReader(new FileReader("file1.txt"))) {
    int intVal;
    while((intVal = br.read()) >= 0) {
        char charVal = (char) intVal;
        //stuff
    }
}

# Writing with line breaks
void writeData(String[] data) throws IOException {
    try (BufferedWriter bw = 
            new BufferedWriter(new FileWriter("data.txt"))) {
        for(String d:data) {
            bw.write(d);
            bw.newLine();
        }
    }
}


```

### Accessing Files with the java.nio.file package
- Want you want to use.  File types have been deprecated, but reader/writers types are still around.
- Better exception handling, scalability, more file system support, simplify common tasks.
- Path
  - Used to locate a file system item
  - Can be a file or a directory
- Paths (type)
  - Static Path factory methods
  - Translate from common representation of file (string based file path, URI)
  
```java 
// Paths example
Path p1 = Paths.get("\\documents\\data\\foo.txt");
Path p2 = Paths.get("documents", "data", "foo.txt");

```

- Files (type)
  - Static methods for interacting with files
  - Create, copy, delete, etc.
  - Open file streams
    - newBufferedReader
    - newBufferedWriter
    - newInputStream
    - newOutputStream
  - Read/write file contents
    - readAllLines
    - write
  - Different than java.io in that we create a files type and then layer a reader over it.
  
```java 
// Example, reading lines with BufferedReader
void readData() throws IOException {
    try (BufferedReader br = 
            Files.newBufferedReader(Paths.get("data.txt"))) {
        String inValue;
        while((inValue = br.readLine()) != null {
            System.out.println(inValue);
        }
    }
}

// Example of a convenience method, readAllLines
void readThemAll() throws IOException {
    List<String> lines = 
        Files.readAllLines(Paths.get("data.txt"));
    for(String line:lines)
        System.out.println(line);
    }
}

```

- Be careful to have enough memory for large file

### Using Default File System and zip file system
- Has a default file system
- Specialized file systems are supported
  - Ex: zip file system
- Path instances are tied to a file system
  - Paths class works only for default
- File System Type
  - Represents an individual file system
  - Factory for Path instances
- FileSystems
  - Static FileSystem factory methods
  - Open or create a file system
  - newFileSystem
- File systems identified by URIs
  - Specifics vary greatly
  - Zip file system uses "jar.file" scheme
  - jar:file:/data/bar.zip
- File systems support custom properties
  - Different for each file system type
  - Examples - Whether to create if doesnt exist, String encoding

## String Formatting and Regular Expressions
### More Powerful Solutions to Create String Representations
- Need more powerful string creation
  - Concatenating strings is often not enough
  - Very focused on creation details
  - Numeric conversions awkward
  - StringBuilder has same issues
- StringJoiner 
  - Simplifies joining a sequence of values
- String formatting
 - Use format specifiers to closely control string formating
 - Can specify desired appearance without dealing with creation details 

### Joining Sequences of Values with StringJoiner
- Construct the StringJoiner
  - Specify string to separate values
  - Optionally specify start/end strings
- Add values
- Retrieve the resulting string

```java 
// StringJoiner ex
StringJointer sj = new StringJoiner(", ")
sj.add("alpha").add("theta").add("gamma");
String theResult = sj.toString();

// More involved separator
StringJoiner sj = new StringJoiner("], [", "[", "]");
sj.add("alpha").add("theta").add("gamma");
String theResult = sj.toString();
// [alpha], [theta], [gamma]

```

### StringJoiner Edge Case Handling
- toString when only one value added
  - When constructed with separator only - returns added value
  - When constructed with start/end strings - returns added value within start/end
- toString when no values added
  - When constructed with separator only - returns empty string
  - When constructed with start/end strings - returns string with start/end only
- You can customize empty case handling
  - Only considered empty string if add is never called

### Constructing String with Format Specifiers
- Focus is on describing the desired result
  - Not concerned with the how
- Can control many aspects of appearance
  - Positioning
  - Decimal places
  - Representation
- Some methods supporting format specifiers
  - String.format
  - System.out.printf
  - Formatter.format

```java 
# Concatenation vs Formatting
String s1 = String.format("The words are %d, %d, and %d", foo, bar, baz);

val=3.666665
String s2 = String.format("blah, blah %1f", val);
// blah, blah 3.7 

```

- All format specifiers start with a %, and then have a conversion, ie "d"
- You can specify precision, ie %.1f
- You can specify width, space-padded, right-justified by default

### Common Format Conversions


### Format Flags
### Argument Index
### Writing Formatted Content to a Stream
### String Matching with Regular Expressions
### String Class Support for RE
### Dedicated Regular Expression Classes

## Working with Collections
### Working with Collections
### Collections and Type Safety
### Collection Interface
### Java 8 Collection Features
### Converting between Collections and Arrays
### Collection Types
### Sorting
### Map Collections
### Sorted Map Collections
## Controlling App Execution and Environment
### Command line args
### Managing Persistable Key/Value Pairs
### Store and Load Property Values
### Properties Persisted as XML
### Properties Default Properties
### Specifying Class Path
### Class Path Structure
### Class Loading with -jar option
### Execution Environment Information
## Capturing Application Activity with the Java Log System
### Log System Management
### Making Log Calls
### Log Levels
### Types of Log Methods
### Parameterized Message Methods
### Creating/Adding Log Components
### Built-in Handlers
### Built-in Formatters
### Log Configuration File
### Making the most of the Log System
## Multithreading and Concurrency
### Basics
### The move to multithreading
### Java Threading Foundation
### Thread pools
### Creating a closer relationship between Thread Tasks
### Concurrency Issues
### Coordinating Method Access
### Manual synchronization
### Manually synchronized code
### More concurrency-related types, Collections
## Runtime Type Information and Reflection
### Overview
### Type as a Type
### Accessing a Type's Class Instance
### Accessing Type Information
### Accessing Type Member information
### Interacting with Object Instances
### Instance Creation with Reflection
## Adding Type Metadata with Annotations
### The need to express context and intent
### Using Annotations
### Declaring Annotations
### Accessing Annotatons
### Annotation Target and Retention
### A closer look at Elements
## Persisting Objects with Serialization
### Overview
### Being Serializable
### Serializing/Deserializing an object
### Class Version Incompatibility
### Creating Class version compatibility
### The need for custom serialization
### Transient Fields
