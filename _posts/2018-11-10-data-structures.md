---
layout: post
current: post
cover:  assets/images/structure.png
navigation: True
title: Data Structures
date: 2018-11-10 05:00:00
tags: [code]
class: post-template
subclass: 'post tag-getting-started'
author: rob
topic-variable: Data Structures
---

# Topics - Data Structures

> In computer science, a data structure is a data organization, management and storage format that enables efficient access and modification. - Wikipedia

Editor Note:
- The material below was cobbled together for personal use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed {{page.topic-variable}}.

Sources: 
- [Data Structure - Wikipedia](https://en.wikipedia.org/wiki/Data_structure), [Array Data Type - Wikipedia](https://en.wikipedia.org/wiki/Array_data_type), 
  [Stack (Abstract Data Type) - Wikipedia](https://en.wikipedia.org/wiki/Stack_(abstract_data_type)), [Linked List - Wikipedia](https://en.wikipedia.org/wiki/Linked_list#Singly_linked_lists),
  [Tree (Data Structure](https://en.wikipedia.org/wiki/Tree_(data_structure)), [Hash Table](https://en.wikipedia.org/wiki/Hash_table),
  [Associative Array](https://en.wikipedia.org/wiki/Associative_array)
  
- [Data Structures - Wikibooks](https://en.wikibooks.org/wiki/Data_Structures)
- [Tutorials Point - Python](https://www.tutorialspoint.com/python/)
- Google
- Photo by Jacek Dylag on Unsplash

## Functional Concept - {{page.topic-variable}}
##### - Basics -
- Formal data structures enable a programmer to mentally structure large amounts of data into conceptually manageable relationships.
- Sometimes we use data structures to allow us to do more: for example, to accomplish fast searching or sorting of data. 
- Other times, we use data structures so that we can do less: for example, the concept of the stack is a limited form of a more general data structure. 
- These limitations provide us with guarantees that allow us to reason about our programs more easily. 
- Data structures also provide guarantees about algorithmic complexity — choosing an appropriate data structure for a job is crucial for writing good software.

##### - In the weeds -
### Arrays
- In computer science, an array data structure, or simply an array, is a data structure consisting of a collection of elements (values or variables), each identified by at least one array index or key. 
- An array is stored such that the position of each element can be computed from its index tuple by a mathematical formula.

### Linked Lists
- In computer science, a Linked list is a linear collection of data elements, whose order is not given by their physical placement in memory. Linked lists are among the simplest and most common data structures.
  - Instead, each element points to the next. It is a data structure consisting of a collection of nodes which together represent a sequence. 
- In its most basic form, each node contains: data, and a reference (in other words, a link) to the next node in the sequence. 
  - This structure allows for efficient insertion or removal of elements from any position in the sequence during iteration.
- They can be used to implement several other common abstract data types, including lists, stacks, queues, associative arrays, and S-expressions, though it is not uncommon to implement those data structures directly without using a linked list as the basis.

### Stacks
- In computer science, a stack is an abstract data type that serves as a collection of elements, with two principal operations:
  - push, which adds an element to the collection, and
  - pop, which removes the most recently added element that was not yet removed.

### Queues
- In computer science, a queue is a particular kind of abstract data type (ADT) or collection in which the entities in the collection are kept in order and the principal (or only) operations on the collection are the addition of entities to the rear terminal position, known as enqueue, and removal of entities from the front terminal position, known as dequeue.

### Hash-tables
- In computing, a hash table (hash map) is a data structure that implements an associative array abstract data type, a structure that can map keys to values. 
  - A hash table uses a hash function to compute an index into an array of buckets or slots, from which the desired value can be found.
- Python:
  - Hash tables are a type of data structure in which the address or the index value of the data element is generated from a hash function. 
  - That makes accessing the data faster as the index value behaves as a key for the data value. 
  - In other words Hash table stores key-value pairs but the key is generated through a hashing function.
  - Python
    - **Dictionary data types** represent the implementation of hash tables. 
    - The Keys in the dictionary satisfy the requirements.

### Dictionaries
- In computer science, an associative array, map, symbol table, or dictionary is an abstract data type composed of a collection of (key, value) pairs, such that each possible key appears at most once in the collection.

### Binary Trees
- In computer science, a tree is a widely used abstract data type (ADT)—or data structure implementing this ADT—that simulates a hierarchical tree structure, with a root value and subtrees of children with a parent node, represented as a set of linked nodes.
- A tree data structure can be defined recursively (locally) as a collection of nodes (starting at a root node).
  - Each node is a data structure consisting of a value, together with a list of references to nodes (the "children")
    - ..with the constraints that no reference is duplicated, 
    - .. and none points to the root.
- Python
  - Tree represents the nodes connected by edges. It is a **non-linear data structure**. It has the following properties:
    - One node is marked as Root node.
    - Every node other than the root is associated with one parent node.
    - Each node can have an arbiatry number of chid node.