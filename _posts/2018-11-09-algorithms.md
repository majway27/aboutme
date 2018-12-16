---
layout: post
current: post
cover: assets/images/algorithms.png
navigation: True
title: Algorithms
date: 2018-11-09 10:00:00
tags: code
class: post-template
subclass: 'post'
author: rob
---

# Topics - Algorithms

> In mathematics and computer science, an algorithm is an unambiguous specification of how to solve a class of problems. 
> Algorithms can perform calculation, data processing, and automated reasoning tasks. - Wikipedia

Editor Note:
- The material below was cobbled together for personal use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Conveniently scoped refresher on the listed Algorithms.

Sources: 
- [**<sup>KA</sup>** Khan Academy - Algorithms](https://www.khanacademy.org/computing/computer-science/algorithms), [Algorithms - Wikibooks](https://en.wikibooks.org/wiki/Algorithms)
- [Binary Search Algorithm - Wikipedia](https://en.wikipedia.org/wiki/Binary_search_algorithm), [Linear Search - Wikipedia](https://en.wikipedia.org/wiki/Linear_search)
  [Wikipedia - Algorithms](https://en.wikipedia.org/wiki/Algorithm)
- [Big O Cheatsheet](http://bigocheatsheet.com/), [Rob Bell - A beginners guide to big o notation](https://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/)
- Photo by Tom Hoppe on Unsplash

## Functional Concept - Algorithms
- Understanding sorting is a traditional first step towards mastery of algorithms and computer science.<sup>KA</sup>
- We think about the **running time** of the algorithm as a function of the size of its input.
  - Neat tip: Logarithms are the inverse of exponentials, which grow very rapidly.
- We must also focus on how fast a **function grows with the input size**. 
  - We call this the rate of growth of the running time. 
- Big O Theta - upper bound, Big O Omega - lower bound
- Recursion Technique - Solve a problem by solving a smaller instance of the same problem, unless the problem is so small that we can just solve it directly.

##### - In the weeds -
### Big O/Asymptotic Notation
- Big-oh notation is a common way of expressing a computer code's performance (see Asymptotic Notation below). 
- The notation creates a relationship between the number of items in memory and the average performance for a function. 
- For a set of {\displaystyle n} n items, {\displaystyle O(n)} O(n) indicates that a particular function will operate on the set {\displaystyle n} n times on average. 
- {\displaystyle O(1)} O(1) indicates that the function always performs a constant number of operations regardless of the number of items. 
- The notation only represents algorithmic complexity so a function may perform more operations but constant multiples of {\displaystyle n} n are dropped by convention.

##### - Searching -
### Linear search
  - _Best case: O(1), Worse case: O(n)_
  - **Brute force search**
  - Example if you had to find a number, in an array of numbers.  You would just start at the front of the array and read each element sequencially until you found it.

### Binary Search
- _Best case O(1), worst case O(log n)_.  [Khan Academy - Running time of binary search](https://www.khanacademy.org/computing/computer-science/algorithms/binary-search/a/running-time-of-binary-search)
- In computer science, binary search is a search algorithm that finds the position of a target value within a sorted array.
- Binary search compares the target value to the middle element of the array. 
- If they are not equal, the **half in which the target cannot lie is eliminated and the search continues on the remaining half**.
- Again taking the middle element to compare to the target value, and repeating this until the target value is found. 
- If the search ends with the remaining half being empty, the target is not in the array. 
- Psuedocode:
  - Let min = 0 and max = n-1.
  - Compute guess as the average of max and min, rounded down (so that it is an integer).
  - If array[guess] equals target, then stop. You found it! Return guess.
  - If the guess was too low, that is, array[guess] < target, then set min = guess + 1.
  - Otherwise, the guess was too high. Set max = guess - 1.
  - Go back to step 2.

##### - Sorting -
### Selection sort
- Simple, Slow on big arrays.  
  - _Best case comparisons: O(n<sup>2</sup>), best case swaps O(n)_.
  - _Worse case comparisons: O(n<sup>2</sup>), worst case swaps O(n)_.
- Psuedocode for cards:
  - Find the smallest card. Swap it with the first card.
  - Find the second-smallest card. Swap it with the second card.
  - Find the third-smallest card. Swap it with the third card.
  - Repeat finding the next-smallest card, and swapping it into the correct position until the array is sorted.

### Insertion Sort
- Simple, efficient for small data sets, better than selection sort.
  - _Best case comparisons: O(n), best case swaps O(1)_.
  - _Worse case comparisons: O(n<sup>2</sup>), worst case swaps O(n<sup>2</sup>)_.
- Psuedocode:
  - Call insert to insert the element that starts at index 1 into the sorted subarray in index 0.
  - Call insert to insert the element that starts at index 2 into the sorted subarray in indices 0 through 1.
  - Call insert to insert the element that starts at index 3 into the sorted subarray in indices 0 through 2.
  - …
  - Finally, call insert to insert the element that starts at index n-1 n−1 into the sorted subarray in indices 0 through n-2 n−2.

##### - Recursion - Functional Study -
### Factorials
- It's just the product of the integers 1 through n n. For example, 5! equals 1 x 2 x 3 x 4 x 5 or 120
- It's very useful for when we're trying to count how many different orders there are for things or how many different ways we can combine things.
  - For example, how many different ways can we arrange n n things?
- Another use for the factorial function is to count how many ways you can choose things from a collection of things.
  - Permutations and Combinations
- [Palindrome Exercise](https://github.com/majway27/dojo/blob/master/palindrome.py)

### Powers
- Python pow function

### Merge Sort
- Divide, conquer, combine

### Quick Sort
- Divide, conquer, combine

## Graph
- Like a social graph


## Breadth
- Breadth-first search, also known as BFS, finds shortest paths from a given source vertex to all other vertices, in terms of the number of edges in the paths.
- Breadth-first search assigns two values to each vertex v.
  - A distance, giving the minimum number of edges in any path from the source vertex to vertex v.
  - The predecessor vertex of v along some shortest path from the source vertex. 
  - The source vertex's predecessor is some special value, such as null, indicating that it has no predecessor.
  - If there is no path from the source vertex to vertex v, then v's distance is infinite and its predecessor has the same special value as the source's predecessor.

## Greediness

## Dynamic Programming/Memorization

