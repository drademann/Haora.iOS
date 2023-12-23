import XCTest
@testable import Haora

final class TagTests: XCTestCase {
  
  func testAsString_givenNoTags_shouldReturnEmptyString() {
    let tags: [Tag] = []
    
    let string = asString(tags, style: .spaceSeparated)
    
    XCTAssertEqual(string, "")
  }
  
  func testAsString_givenSingleTag_shouldHashedTagName() {
    let tags = [ Tag("Haora") ]
    
    let string = asString(tags, style: .spaceSeparated)
    
    XCTAssertEqual(string, "#Haora")
  }
  
  func testAsString_givenMultipleTags_shouldReturnSingleSpaceSeparatedTagNames() {
    let tags = [ Tag("Haora"), Tag("Dinner") ]
    
    let string = asString(tags, style: .spaceSeparated)
    
    XCTAssertEqual(string, "#Haora #Dinner")
  }
}
