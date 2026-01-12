# Car Rental System – MongoDB NoSQL Project

This project is a **Car Rental System** developed as part of the **Database Programming (SECP3623)** course. The system is designed using **MongoDB**, a NoSQL document-oriented database, to manage core rental operations such as vehicles, customers, bookings, and payments. The project demonstrates how NoSQL databases can be used to build scalable and flexible backend systems for real-world applications.

## Project Overview

The system models a typical car rental workflow where customers can book vehicles for a specified period, track booking status, and complete payments including deposits and refunds. Instead of using a traditional relational database, MongoDB is used to take advantage of its flexible schema, embedded documents, and efficient handling of hierarchical data.

The database consists of four main collections:
- **Vehicles** – Stores vehicle details, availability status, mileage, and location  
- **Customers** – Stores customer information such as contact details and driving license  
- **Bookings** – Records rental transactions and links customers with vehicles  
- **Payments** – Manages payment records, deposits, and refund status  

## Key Features

- **NoSQL Data Modeling**
  - Embedded documents for tightly related data (e.g. pickup, return, deposit details)
  - References for independent entities (e.g. customers, vehicles, bookings)
  - Use of arrays and appropriate MongoDB data types

- **CRUD Operations**
  - Insert, query, update, and delete operations implemented using MongoDB commands
  - Conditional filtering, projections, and update operators

- **Advanced MongoDB Operations**
  - Indexing (single-field and compound indexes) to improve query performance
  - Aggregation pipelines for analytics such as revenue calculation and vehicle popularity
  - Sorting operations for structured and readable query results

- **Security and Limitations Analysis**
  - Basic access control considerations
  - Awareness of NoSQL injection risks
  - Discussion of MongoDB limitations and consistency trade-offs

## Learning Outcomes

Through this project, we gained practical experience in NoSQL database design, performance optimization, and data analysis using MongoDB. We also developed a deeper understanding of how database architecture decisions affect scalability, consistency, and real-world system performance.

This repository serves as a reference for implementing a structured and efficient MongoDB-based backend system for rental or booking-based applications.

