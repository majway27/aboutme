---
layout: post
current: post
cover: assets/images/sre.png
navigation: True
title: "Personal Notes: Site Reliability Eng. Book by Google"
date: 2019-01-08 10:18:00
tags: sre bookreport
class: post-template
subclass: 'post tag-speeches'
author: rob
---

# Topics - Site Reliability Eng. Book by Google, Personal Notes

> Our disaster recovery plan goes something like this "Help Help!" -Dilbert
> Implementations are ephemeral, but the documented reasoning is priceless. -Mark Burgess

Editor Note:
- The material below was cobbled together for personal notes use, from attributed sources, and endured some mild look/feel massage.
- Document Purpose: Personal notes on Site Reliability Eng. Book by Google.  Share experience and thoughts.

Sources: 
- https://landing.google.com/sre/sre-book/toc/index.html
  - “Site Reliability Engineering, edited by Betsy Beyer, Chris Jones, Jennifer Petoff, and Niall Richard Murphy (O’Reilly). Copyright 2016 Google, Inc., 978-1-491-92912-4.”
- Photo source by O'Reilly/Google

# Book
## Foreword
- Google grew at a time when the traditional role of the system administrator was being transformed
  - Many shops are facing this challenge, as they move into the cloud and find that an artisanal approach doesn't stretch. 
- wizard culture
  - It is always going to be a hard sell when the existing playbook is dialed in and trusty/comfortable
- The tribal nature of IT culture often entrenches practitioners in dogmatic positions that hold the industry back.
  - The traditional Ops team has endured much uncomfortable growth in the last 10 years, as bleeding edge stuff merged into the mainstream and pushed Admins forward.  But change is our North Star.
    - Big Iron/Cabinets to on-prem virtualization, software defined networking
    - Set and forget config to CM/State Management tools (ie Puppet)
    - On-prem virt to IAAS public cloud
    - Cattle not old bessie, Containerization concepts
    - Tip to tail automation/CICD.  No human touch.  The runtime platform is simply a software defined wrapper for the business logic that comes down the pipe.

## Preface
- Software engineering has this in common with having children: the labor before the birth is painful and difficult, 
but the labor after the birth is where you actually spend most of your effort. 
  - Yet software engineering as a discipline spends much more time talking about the first period as opposed to the second, despite estimates that 40–90% of the total costs of a system are incurred after birth.
- The popular industry model that conceives of deployed, operational software as being “stabilized” in production, and therefore needing much less attention from software engineers, is wrong.
- SREs expend effort in this direction only up to a point: when systems are “reliable enough,” we instead invest our efforts in adding features or building new products
  - Engineers, apply the principles of computer science and engineering to the design and development of computing systems: generally, large distributed ones
  - Build runtime platform pieces
  - Solve new problems with existing solutions
- Reliability is the most fundamental feature of any product: a system isn’t very useful if nobody can use it!
- "part of the culture was to learn from everyone and everything, including from that which one would least expect."
- "a thorough understanding of how to operate the systems was not enough to prevent human errors"

## Part I - Introduction
### 1. Introduction
- Hope is not a strategy
- The Sysadmin Approach to Service Management
  - Traditional - running the service and responding to events and updates as they occur
  - Scale to growth with bigger team
  - Dev and ops split due to industry prevalent skillsets
  - Advantages - familiar industry paradigm
  - Cons/pitfalls
    - Costly to grow team (includes siloing/training problems on large team)
    - Two teams’ goals are fundamentally in tension.  Both groups understand that it is unacceptable to state their interests in the baldest possible terms ("We want to launch anything, any time, without hindrance" versus "We won’t want to ever change anything in the system once it works").
    - Leads to Change Management theater
- Google’s Approach to Service Management: Site Reliability Engineering
  - Hire blended team of devs and sysadmins with good dev skillsets
  - Make transferring easy to cross-pollinate early and often
    - "results in clever, high-quality systems that are clearly the product of the synthesis of several skill sets"
    - SREs also end up sharing academic and intellectual background with the rest of the development organization
  - Strong aversion to manual work (not allowed)
  - The **Safety Valve** - to avoid this fate, the team tasked with managing a service needs to code or it will drown. Therefore, Google places a 50% cap on the aggregate "ops" work for all SREs—tickets, on-call, manual tasks, etc
    - This cap ensures that the SRE team has enough time in their schedule to make the service stable and operable
  - Other time is for doing dev work to improve the runtime platform
  - SRE teams are characterized by both rapid innovation and a large acceptance of change
  
- Tenets of SRE
  - Ensuring a Durable Focus on Engineering
    - Blame-Free postmortems should be written for all significant incidents, regardless of whether or not they paged
    - Goal is to fix, vs avoiding or minimizing
  - Pursuing Maximum Change Velocity Without Violating a Service’s SLO
    - Error budget
    - Marginal difference between 99.999% and 100%
    - Wisely designed availability target
    - The use of an error budget resolves the structural conflict of incentives between development and SRE. SRE’s goal is no longer "zero outages"; rather, SREs and product developers aim to spend the error budget getting maximum feature velocity. 
    - This change makes all the difference. An outage is no longer a "bad" thing—it is an expected part of the process of innovation, and an occurrence that both development and SRE teams manage rather than fear. 
  - Monitoring
    - Monitoring should never require a human to interpret any part of the alerting domain. 
    - Instead, software should do the interpreting, and humans should be notified only when they need to take action.
    - Alerts - human action immediately for current or impending bad condition
    - Tickets - Human can do it the next business day.  System can't auto-handle.
    - Logging - No expectation to read, there for diagnostic/forensic purpose
  - Emergency Response
    - Reliability is a function of mean time to failure (MTTF) and mean time to repair (MTTR).
    - The most relevant metric in evaluating the effectiveness of emergency response is how quickly the response team can bring the system back to health—that is, the MTTR.
    - Google SRE relies on pre-written on-call playbooks, in addition to exercises such as the "Wheel of Misfortune," to prepare engineers to react to on-call events.
  - Change Management
    - 70% of outages are due to changes in live system
    - Best practices in this domain use automation to accomplish progressive rollouts, problem detection, safe rollbacks
    - Release velocity and safety increase
  - Demand Forecasting and Capacity Planning
    - Capacity planning should take both organic growth (which stems from natural product adoption and usage by customers) and inorganic growth (which results from events like feature launches, marketing campaigns, or other business-driven changes) into account.
    - Accurate project of organic/inorganic growth, beyond change point.
    - Frequent recalibration of system fitness via load testing.
    - Because capacity is critical to availability, it naturally follows that the SRE team must be in charge of capacity planning, which means they also must be in charge of provisioning.
  - Provisioning
    - Provisioning must be conducted quickly and only when necessary, as capacity is expensive
    - Risky due to config changes
  - Efficiency and Performance
    - Money matters, Provisioning/Utilization
    - Resource use is a function of demand (load), capacity, and software efficiency
    - A slowdown in a service equates to a loss of capacity
    - SREs provision to meet a capacity target at a specific response speed
  
### 2. The Production Environment at Google, from the Viewpoint of an SRE
- Hardware 
  - Homogeneous commodity hardware.  No special hardware clusters.  I like this.
  - Machine/server defs at Google
  - Borg cluster os/Kubernetes
  - Rack/row/cluster/DC/campus
  - Clos Network/Jupiter, B4 backbone network
- System Software That "Organizes" the Hardware
  - Borg
    - Borg Master
    - Cluster Scheduler, tools, config files
    - Borglets
    - Runs users jobs
  - Jobs
    - Consist of 1-many tasks.  Borg orchestrates, restarts failed tasks
    - BNS for extra layer of indirection (maps canon name to ip/dns of server running task)
    - Borg optimizes/binpacks jobs based on cpu/mem/resource requirements
  - Storage
    - Cluster storage (Hadoop Distributed File System/lustre/open source cluster fs)
    - Lowest layer - D, fileserver on each server
    - Colussus - cluster wide filesystem, replication, encryption.  Successor to GFS.
  - Databases (storage)
    - Bigtable
      - nosql, petabytes, sparse, distributed, persistent, multidimensional sorted map
      - indexed by row key, col key, timestamp  
      - Each value in map is an uninterpreted array of bytes
      - Eventually consistent, cross-dc replication
    - Spanner
      - sql like interface for users that require real consistency
    - Several other db systems, such as Blobstore, are available.  Each has own tradeoffs
  - Networking
    - Openflow, dumb switches.  Computationally intensive routing load off of switch hardware.
    - Bandwidth enforcer, tries to max average available bandwidth
    - For geo-dispersed jobs, minimize latency.  Global software load balancer
      - LB for DNS reqs (ex www.google.com)
      - LB at user service level (ex youtube)
      - RPC call LB
  - Other System Software
    - Lock service: chubby, FS like API for maintaining locks, across DCs.
      - Paxos protocol for async consensus
      - traffic cop for job replicas (reliability)
  - Monitoring and Alerting
     - Borgmon, many instances running.  Scrapes metrics from monitored servers.
     - Alerting for acute problems
     - Compare behavior - did an update make the server faster
     - Examine how resource consumption behavior evolves over time, which is essential for cap planning
  - Our Software Infrastructure
    - Code is heavily multithreaded, one task can easily use many cores.  Every server has http metrics dash.
    - All G services comm using RPC infrastructure named stubby.  Subroutines are aggressively split out as RPC calls.
    - Makes refactoring for modularity easy, or when codebase grows.
    - Protobufs, advantages in serialization
  - Our Development Environment
    - High velocity, shared repo.  PRs, built and tested. Testing protects dependent services.

## Part II - Principles
- Patterns, behaviors, and areas of concern that influence the general domain of SRE operations
- A complex system that works necessarily evolved from a simple system that works

### 3. Embracing Risk
- Balance the risk of unavailability with the goals of rapid innovation and efficient service operations, so that users’ overall happiness—with features, service, and performance—is optimized
- Managing Risk
  - The cost of redundant machine/compute resources
  - The opportunity cost (feature building vs hardening)
    - We give equal importance to figuring out how to engineer greater reliability into Google systems and identifying the appropriate level of tolerance for the services we run
    - We strive to make a service reliable enough, but no more reliable than it needs to be
    - Explicit, thoughtful risktaking
- Measuring Service Risk
  - Unplanned downtime
  - Time-based availability (service partially up in geo dispersed)
  - Aggregate availability (request success rate across all services)
- Risk Tolerance of Services
  - Identifying the Risk Tolerance of Consumer Services (with Product)
    - Easy for products, hard for shared infrastructure
    - What level of availability is required?
    - Do different types of failures have different effects on the service?
    - How can we use the service cost to help locate a service on the risk continuum?
    - What other service metrics are important to take into account?
      - Target level of availability
        - What level of service will the users expect?
        - Does this service tie directly to revenue (either our revenue, or our customers’ revenue)?
        - Is this a paid service, or is it free?
        - If there are competitors in the marketplace, what level of service do those competitors provide?
        - Is this service targeted at consumers, or at enterprises?
      - Types of failures 
        - Constant low rate of failures, or an occasional full-site outage
      - Cost
        - If we were to build and operate these systems at one more nine of availability, what would our incremental increase in revenue be?
        - Does this additional revenue offset the cost of reaching that level of reliability?
          - Proposed improvement in availability target: 99.9% → 99.99%
          - Proposed increase in availability: 0.09%
          - Service revenue: $1M
          - Value of improved availability: $1M * 0.0009 = $900
        - If cost of change is less than 900, gtg
      - Other service metrics
        - 3rd party external servicse performance, etc
  - Identifying the Risk Tolerance of Infrastructure Services
    - Target level of availability 
      - More stringent as a foundation service with many internal customers/products
      - Can be clever and have flavors (workhorse and racehorse platforms)  **Partition Infra**
    - Types of failures
      - Needs for sync or async customer usage profiles
    - Cost
      - Price out usage for flavors, put choice on internal customer
- Motivation for Error Budgets
  - Software fault tolerance
    - How hardened do we make the software to unexpected events? Too little, and we have a brittle, unusable product. Too much, and we have a product no one wants to use (but that runs very stably)
  - Testing
    - Not enough testing and you have embarrassing outages, privacy data leaks, or a number of other press-worthy events. Too much testing, and you might lose your market
  - Push frequency
    - Every push is risky. How much should we work on reducing that risk, versus doing other work?
  - Canary duration and size
  - Forming Your Error Budget
    - Goal is to define an objective metric, agreed upon by both sides, that can be used to guide the negotiations in a reproducible way. The more data-based the decision can be, the better
    - Product Management defines an SLO, which sets an expectation of how much uptime the service should have per quarter.
    - The actual uptime is measured by a neutral third party: our monitoring system.
    - The difference between these two numbers is the "budget" of how much "unreliability" is remaining for the quarter.
    - As long as the uptime measured is above the SLO—in other words, as long as there is error budget remaining—new releases can be pushed.
  - Benefits
    - The main benefit of an error budget is that it provides a common incentive that allows both product development and SRE to focus on finding the right balance between innovation and reliability
    - What happens if a network outage or datacenter failure reduces the measured SLO? Such events also eat into the error budget. As a result, the number of new pushes may be reduced for the remainder of the quarter. The entire team supports this reduction because everyone shares the responsibility for uptime.
    - The budget also helps to highlight some of the costs of overly high reliability targets, in terms of both inflexibility and slow innovation. If the team is having trouble launching new features, they may elect to loosen the SLO (thus increasing the error budget) in order to increase innovation.

### 4. Service Level Objectives
- It’s impossible to manage a service correctly, let alone well, without understanding which behaviors really matter for that service and how to measure and evaluate those behaviors.
- Service Level Terminology
  - Indicators
  - Objectives
  - Agreements
- Indicators in Practice
  - What Do You and Your Users Care About?
  - Collecting Indicators
  - Aggregation
  - Standardize Indicators
- Objectives in Practice
  - Defining Objectives
  - Choosing Targets
  - Don’t pick a target based on current performance
  - Keep it simple
  - Avoid absolutes
  - Have as few SLOs as possible
  - Perfection can wait
  - Control Measures
  - SLOs Set Expectations
  - Keep a safety margin
  - Don’t overachieve
- Agreements in Practice

### 5. Eliminating Toil
### 6. Monitoring Distributed Systems
### 7. The Evolution of Automation at Google
### 8. Release Engineering
### 9. Simplicity
- A well-designed distributed system consists of collaborators, each of which has a clear and well-scoped purpose

## Part III - Practices
### 10. Practical Alerting
- Aggregation is the cornerstone of rule evaluation in a distributed environment
- When collecting Borgmon-style data, it’s better to use counters, because they don’t lose meaning when events occur between sampling intervals
### 11. Being On-Call
### 12. Effective Troubleshooting
### 13. Emergency Response
### 14. Managing Incidents
### 15. Postmortem Culture: Learning from Failure
### 16. Tracking Outages
### 17. Testing for Reliability
### 18. Software Engineering in SRE
### 19. Load Balancing at the Frontend
### 20. Load Balancing in the Datacenter
### 21. Handling Overload
### 22. Addressing Cascading Failures
### 23. Managing Critical State: Distributed Consensus for Reliability
### 24. Distributed Periodic Scheduling with Cron
### 25. Data Processing Pipelines
### 26. Data Integrity: What You Read Is What You Wrote
### 27. Reliable Product Launches at Scale
## Part IV - Management
### 28. Accelerating SREs to On-Call and Beyond
### 29. Dealing with Interrupts
### 30. Embedding an SRE to Recover from Operational Overload
### 31. Communication and Collaboration in SRE
### 32. The Evolving SRE Engagement Model
## Part V - Conclusions
### 33. Lessons Learned from Other Industries
### 34. Conclusion
## Appendix A. Availability Table
## Appendix B. A Collection of Best Practices for Production Services
## Appendix C. Example Incident State Document
## Appendix D. Example Postmortem
## Appendix E. Launch Coordination Checklist
## Appendix F. Example Production Meeting Minutes

