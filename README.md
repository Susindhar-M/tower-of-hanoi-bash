# Tower of Hanoi - Bash Script
 
A recursive Tower of Hanoi implementation in bash with ASCII peg-and-disk graphics rendered after each move.
 
## Usage
 
```bash
chmod +x tower_of_hanal.sh
./tower_of_hanal.sh
```
 
Enter the number of disks when prompted.
 
## How It Works
 
The core algorithm is a classic recursive function `hanai_exchange`. Given N disks and three pegs (src, dst, aux), it:
 
1. Recursively moves N-1 disks from `src` to `aux`
2. Moves the largest disk from `src` to `dst`
3. Recursively moves N-1 disks from `aux` to `dst`
The base case is N=0 — do nothing and return. This produces the optimal `2^N - 1` moves.
 
## Graphics
 
After each move, `graphic_gen` renders the current state of all three pegs as ASCII art, showing disk sizes as `=` characters centered on each rod.
 
## Example - 3 disks (7 moves)
 

<img width="231" height="799" alt="image" src="https://github.com/user-attachments/assets/2631f250-5c21-45c6-a738-576274a1b4dc" />


## Author
 
Susindhar Manivasagan  

