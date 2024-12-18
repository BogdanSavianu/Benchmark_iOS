# Benchmark_iOS

A Swift-based benchmarking application to evaluate CPU performance using various computational tasks, including floating-point arithmetic and Argon2 hashing. The app is designed to test both single-threaded and multithreaded workloads, making it suitable for comparing performance across different devices.

---

## **Features**

- Floating-point arithmetic tests:
  - Addition and subtraction.
  - Multiplication and division.
  - Multithreaded implementations for parallel processing.
- Argon2 hashing benchmarks:
  - Easy, medium, and hard configurations for varying workloads.
- 3D rendering:
  - Rendering of a sphere using the GPU.
- Memory read and write times.
- Device information display:
  - Total and active CPU cores.

---

## **Technologies Used**

- **SwiftUI** for the user interface.
- **Foundation** for core functionality.
- **Concurrency** using `TaskGroup` for multithreaded tests.

---

## **Getting Started**

### **Prerequisites**
- Xcode 15.0 or later.
- macOS 13.0 (Ventura) or later.
- iOS 16.0 or later for mobile testing.

### **Installation**
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/benchmark_app.git
   cd benchmark_app

2.	Open the project in Xcode:
    open Benchmark_app.xcodeproj

3.	Build and run the project on your desired device.

## **Usage**

**UI Overview**

	1.	CPU Info Section: Displays the total and active cores of the device’s processor.
	2.	Benchmark Tests Section: Includes a list of tests:
	    •	Floating-point addition/subtraction and multiplication/division.
	    •	Multithreaded floating-point operations.
	    •	Argon2 hashing tests.
        •   3D rendering of a sphere.
        •   Memory writing and reading from the heap.

**Running Benchmarks**

	•	Click on the corresponding test buttons to execute a benchmark.
	•	The results will display the execution time in seconds.

