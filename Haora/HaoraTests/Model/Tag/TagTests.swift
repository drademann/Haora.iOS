import XCTest
@testable import Haora

final class TagTests: XCTestCase {
    
    func testFormatted_givenNoTags_shouldReturnEmptyString() {
        let tags: [Tag] = []
        
        let string = formatted(tags, style: .spaceSeparated)
        
        XCTAssertEqual(string, "")
    }
    
    func testFormatted_givenSingleTag_shouldHashedTagName() {
        let tags = [ Tag("Haora") ]
        
        let string = formatted(tags, style: .spaceSeparated)
        
        XCTAssertEqual(string, "#Haora")
    }
    
    func testFormatted_givenMultipleTags_shouldReturnSingleSpaceSeparatedTagNames() {
        let tags = [ Tag("Haora"), Tag("Dinner") ]
        
        let string = formatted(tags, style: .spaceSeparated)
        
        XCTAssertEqual(string, "#Haora #Dinner")
    }
    
}
