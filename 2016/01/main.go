package main

import (
	"flag"
	"fmt"
	"io"
	"math"
	"os"
	"strconv"
	"strings"
)

func readInput() string {
	stdin, _ := io.ReadAll(os.Stdin)
	return strings.TrimSpace(string(stdin))
}

func turnRight(dir complex128) complex128 {
	return dir * complex(0, -1)
}

func turnLeft(dir complex128) complex128 {
	return dir * complex(0, 1)
}

func move(pos complex128, dir complex128, steps int) complex128 {
	return pos + complex(float64(steps), 0)*dir
}

func manhattanDistance(pos complex128) int {
	return int(math.Abs(real(pos)) + math.Abs(imag(pos)))
}

func main() {

	partFlag := flag.Int("part", 1, "declare which part should be executed")
	flag.Parse()

	input := readInput()

	pos := complex(0, 0)
	dir := complex(0, 1)

	visited := make(map[complex128]bool)
	visited[pos] = true

	fmt.Println("Position:", pos, "Direction:", dir)

	instructions := strings.Split(input, ", ")

	for _, instruction := range instructions {
		fmt.Println("Instruction: ", instruction)

		turn := instruction[0]
		steps, _ := strconv.Atoi(instruction[1:])

		switch turn {
		case 'R':
			dir = turnRight(dir)
		case 'L':
			dir = turnLeft(dir)
		default:
			os.Exit(1)
		}

		switch *partFlag {
		case 1:
			pos = move(pos, dir, steps)
			fmt.Println("Position:", pos, "Direction:", dir)

		case 2:
			for i := 0; i < steps; i++ {
				pos = move(pos, dir, 1)
				fmt.Println("Position:", pos, "Direction:", dir)

				if visited[pos] {
					fmt.Println("Position:", pos, "Direction:", dir)
					fmt.Println("Distance from origin:", manhattanDistance(pos))
					os.Exit(0)
				}
				visited[pos] = true
			}
		}

	}

	fmt.Println("Distance from origin:", manhattanDistance(pos))
}
