import CoreData

@objc(Item)
public class Item: NSManagedObject {
    @NSManaged public var timestamp: Date
}

extension Item {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }
}

// Make Item conform to Identifiable
extension Item: Identifiable {
    // Use the Core Data-generated objectID as the identifier
    public var id: NSManagedObjectID {
        return self.objectID
    }
}
