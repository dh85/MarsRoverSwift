import Foundation

public class Rover {
    private var orientation = Orientation.north
    private var coordinate = Coordinate(x: 0, y: 0)
    private let grid: Grid

    public init(grid: Grid) {
        self.grid = grid
    }

    public func execute(commands: String) -> (code: Int, message: String) {
        var obstacleString = ""
        for command in commands {
            switch command {
            case "R": orientation = orientation.right()
            case "L": orientation = orientation.left()
            case "M":
                if let nextCoordinate = grid.nextCoordinate(for: coordinate, and: orientation) {
                    coordinate = nextCoordinate
                } else {
                    obstacleString = "0:"
                }
            default: return (1, "Invalid commands entered.")
            }
        }

        return (0, "\(obstacleString)\(coordinate.x):\(coordinate.y):\(orientation.rawValue)")
    }
}
