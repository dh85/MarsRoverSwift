enum Orientation: String {
    case north = "N"
    case south = "S"
    case west = "W"
    case east = "E"

    func left() -> Orientation {
        switch self {
        case .north: return .west
        case .south: return .east
        case .west: return .south
        case .east: return .north
        }
    }

    func right() -> Orientation {
        switch self {
        case .north: return .east
        case .south: return .west
        case .west: return .north
        case .east: return .south
        }
    }
}
