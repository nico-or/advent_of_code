package main

import (
	"flag"
	"fmt"
	"io"
	"math"
	"os"
	"strings"
)

func readInput() (string, error) {
	stdin, err := io.ReadAll(os.Stdin)

	if err != nil {
		return "", err
	}

	return strings.TrimSpace(string(stdin)), nil
}

type point struct {
	x, y int
}

func (pt point) add(other point) point {
	return point{pt.x + other.x, pt.y + other.y}
}

func validate1(pos point) bool {
	absX := math.Abs(float64(pos.x))
	absY := math.Abs(float64(pos.y))

	if absX <= 1 && absY <= 1 {
		return true
	}

	return false
}

func move(pos point, dir string, validate func(point) bool) point {
	var delta point

	switch dir[0] {
	case 'U':
		delta = point{0, 1}
	case 'D':
		delta = point{0, -1}
	case 'R':
		delta = point{1, 0}
	case 'L':
		delta = point{-1, 0}
	}

	new_pos := pos.add(delta)

	if validate(new_pos) {
		return new_pos
	}

	return pos
}

func manhattanDistance(pos point) int {
	return int(math.Abs(float64(pos.x)) + math.Abs(float64(pos.y)))
}

func validate2(pos point) bool {
	if manhattanDistance(pos) <= 2 {
		return true
	}

	return false
}

func main() {
	partFlag := flag.Int("part", 1, "declare which part should be executed")
	flag.Parse()

	input, err := readInput()

	if err != nil || input == "" {
		fmt.Println("Error reading input")
		os.Exit(1)
	}

	var pos point
	m := make(map[point]string)

	switch *partFlag {
	case 1:
		pos = point{0, 0}

		m[point{-1, +1}] = "1"
		m[point{+0, +1}] = "2"
		m[point{+1, +1}] = "3"
		m[point{-1, +0}] = "4"
		m[point{+0, +0}] = "5"
		m[point{+1, +0}] = "6"
		m[point{-1, -1}] = "7"
		m[point{+0, -1}] = "8"
		m[point{+1, -1}] = "9"
	case 2:
		pos = point{-2, 0}
		m[point{+0, +2}] = "1"
		m[point{-1, +1}] = "2"
		m[point{+0, +1}] = "3"
		m[point{+1, +1}] = "4"
		m[point{-2, +0}] = "5"
		m[point{-1, +0}] = "6"
		m[point{+0, +0}] = "7"
		m[point{+1, +0}] = "8"
		m[point{+2, +0}] = "9"
		m[point{-1, -1}] = "A"
		m[point{+0, -1}] = "B"
		m[point{+1, -1}] = "C"
		m[point{+0, -2}] = "D"
	}

	var output string

	lines := strings.SplitSeq(input, "\n")

	for line := range lines {
		fmt.Println("line: ", line)
		instructions := strings.SplitSeq(line, "")
		for instruction := range instructions {
			fmt.Println("instruction: ", instruction)

			validator := validate1
			if *partFlag == 2 {
				validator = validate2
			}
			pos = move(pos, instruction, validator)

			fmt.Println("pos: ", pos)
		}
		fmt.Println("Pressing: ", m[pos])
		output += m[pos]
	}

	fmt.Println("Code: ", output)
}
