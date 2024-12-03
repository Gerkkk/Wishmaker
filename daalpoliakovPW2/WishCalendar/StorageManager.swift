import UIKit
import CoreData


public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init () {}
    
    private var appdDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appdDelegate.persistentContainer.viewContext
    }
    
    public func createEvent(id: Int, name: String, startDate: Date, endDate: Date, notes: String?) {
        guard let eventEntityDescription = NSEntityDescription.entity(forEntityName: "Event", in: context) else {return}
        
        let event = Event(entity: eventEntityDescription, insertInto: context)
        event.name = name
        event.startDate = startDate
        event.endDate = endDate
        event.note = notes
        appdDelegate.saveContext()
    }
    
    public func fetchEvents() -> [Event] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        
        do {
            return try context.fetch(fetchRequest) as! [Event]
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
