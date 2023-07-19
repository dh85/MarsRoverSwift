import XCTest
@testable import MarsRoverSwift

final class MarsRoverSwiftTests: XCTestCase {

    func testRotateRight() {
        let tests: Tests = [
            (makeCommands("R"), makePosition(0, 0, .east)),
            (makeCommands("RR"), makePosition(0, 0, .south)),
            (makeCommands("RRR"), makePosition(0, 0, .west)),
            (makeCommands("RRRR"), makePosition(0, 0, .north))
        ]

        runTests(tests)
    }

    func testRotateLeft() {
        let tests: Tests = [
            (makeCommands("L"), makePosition(0, 0, .west)),
            (makeCommands("LL"), makePosition(0, 0, .south)),
            (makeCommands("LLL"), makePosition(0, 0, .east)),
            (makeCommands("LLLL"), makePosition(0, 0, .north))
        ]

        runTests(tests)
    }

    func testMoveUp() {
        let tests: Tests = [
            (makeCommands("M"), makePosition(0, 1, .north)),
            (makeCommands("MMM"), makePosition(0, 3, .north))
        ]

        runTests(tests)
    }

    func testWrapFromTopToBottomWhenMovingNorth() {
        let tests: Tests = [
            (makeCommands("MMMMMMMMMM"), makePosition(0, 0, .north)),
            (makeCommands("MMMMMMMMMMMMMMM"), makePosition(0, 5, .north)),
        ]

        runTests(tests)
    }

    func testMoveRight() {
        let tests: Tests = [
            (makeCommands("RM"), makePosition(1, 0, .east)),
            (makeCommands("RMMM"), makePosition(3, 0, .east))
        ]

        runTests(tests)
    }

    func testWrapFromRightToLeftWhenMovingEast() {
        let tests: Tests = [
            (makeCommands("RMMMMMMMMMM"), makePosition(0, 0, .east)),
            (makeCommands("RMMMMMMMMMMMMMMM"), makePosition(5, 0, .east)),
        ]

        runTests(tests)
    }

    func testMoveLeft() {
        let tests: Tests = [
            (makeCommands("LM"), makePosition(9, 0, .west)),
            (makeCommands("LMMM"), makePosition(7, 0, .west))
        ]

        runTests(tests)
    }

    func testMoveSouth() {
        let tests: Tests = [
            (makeCommands("LLM"), makePosition(0, 9, .south)),
            (makeCommands("LLMMM"), makePosition(0, 7, .south))
        ]

        runTests(tests)
    }

    func testStopAtObstacle() {
        let obstacles: [Coordinate] = [
            Coordinate(x: 0, y: 4)
        ]
        let tests: Tests = [
            (makeCommands("MMMM"), makePosition(0, 3, .north, true))
        ]

        runTests(tests, obstacles: obstacles)
    }

    func testInvalidCommand() {
        let result = makeSUT(commands: "FISH")
        XCTAssertEqual(result.message, "Invalid commands entered.")
        XCTAssertEqual(result.code, 1)
    }


    // MARK: Helpers
    
    private typealias Tests = [(String, String)]

    private func runTests(_ tests: Tests, obstacles: [Coordinate] = []) {
        tests.forEach { commands, position in
            let result = makeSUT(commands: commands, obstacles: obstacles)
            XCTAssertEqual(result.message, position)
            XCTAssertEqual(result.code, 0)
        }
    }

    private func makeCommands(_ commands: String) -> String {
        commands
    }

    private func makePosition(_ x: Int, _ y: Int, _ orientation: Orientation, _ obstacleHit: Bool = false) -> String {
        let obstacleString = obstacleHit ? "0:" : ""
        return "\(obstacleString)\(x):\(y):\(orientation.rawValue)"
    }

    private func makeSUT(commands: String, obstacles: [Coordinate] = []) -> (code: Int, message: String) {
        let grid = Grid(obstacles: obstacles)
        let rover = Rover(grid: grid)
        return rover.execute(commands: commands)
    }
}
