import Foundation

extension String {

    var length: Int {
        return self.characters.count
    }

    subscript(i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }

    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }

    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }

    subscript(r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }

    func rapidParsed() {
        // Filter all the custom commands.
    }

    func wordFilter(filteredWords: [String], replacement: String) -> Bool {
        // Filter all words etc.

        // Check if word is allowed
        return true // word allowed
    }
}