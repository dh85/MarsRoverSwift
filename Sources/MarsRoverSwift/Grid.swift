public struct Grid {
    private let height: Int
    private let width: Int
    private let obstacles: [Coordinate]

    public init(height: Int = 10, width: Int = 10, obstacles: [Coordinate] = []) {
        self.height = height
        self.width = width
        self.obstacles = obstacles
    }

    func nextCoordinate(for coordinate: Coordinate, and orientation: Orientation) -> Coordinate? {
        var x = coordinate.x
        var y = coordinate.y

        switch orientation {
        case .north: y = (y + 1) % height
        case .south: y = (y > 0) ? y - 1 : height - 1
        case .west: x = (x > 0) ? x - 1 : width - 1
        case .east: x = (x + 1) % width
        }

        let newCoordinate = Coordinate(x: x, y: y)
        return !obstacles.contains(newCoordinate) ? newCoordinate : nil
    }
}
