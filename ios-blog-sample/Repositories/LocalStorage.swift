//
//  LocalStorage.swift
//  ios-blog-sample
//
//  Created by Pedro Brandão on 15/12/19.
//  Copyright © 2019 Pedro Brandão. All rights reserved.
//

import CoreData
import UIKit

private enum Entities {
    static let post = "LocalPost"
}

private enum PostKey {
    static let userId = "userId"
    static let id = "id"
    static let title = "title"
    static let body = "body"
}

protocol LocalStorageProtocol {
    func save(_ posts: [Post])
    func posts() -> [Post]
    func deleteAllPosts()
}

class CoreDataStorage: LocalStorageProtocol {
    private let errorHandler: ErrorProtocol
    private let managedContext: NSManagedObjectContext?
    
    init(errorHandler: ErrorProtocol) {
        self.errorHandler = errorHandler
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.managedContext = appDelegate.persistentContainer.viewContext
        } else {
            self.managedContext = nil
        }
    }
    
    func save(_ posts: [Post]) {
        if self.posts().count > 0 { return }
        
        guard let managedContext = self.managedContext else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: Entities.post, in: managedContext)!
        _ = posts.map { post in
            let localPost = NSManagedObject(entity: entity, insertInto: managedContext)
            localPost.setValue(post.userId, forKeyPath: PostKey.userId)
            localPost.setValue(post.id, forKeyPath: PostKey.id)
            localPost.setValue(post.title, forKeyPath: PostKey.title)
            localPost.setValue(post.body, forKeyPath: PostKey.body)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                self.errorHandler.handle(error)
            }
        }
    }
    
    func posts() -> [Post] {
        guard let managedContext = self.managedContext else {
            return []
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.post)
        do {
            let localPosts = try managedContext.fetch(fetchRequest)
            let posts = localPosts.map { post -> Post in
                guard
                    let userId = post.value(forKeyPath: PostKey.userId) as? Int,
                    let id = post.value(forKeyPath: PostKey.id) as? Int,
                    let title = post.value(forKeyPath: PostKey.title) as? String,
                    let body = post.value(forKeyPath: PostKey.body) as? String
                else { return Post() }
                return Post(userId: userId, id: id, title: title, body: body)
            }
            return posts
        } catch let error as NSError {
            self.errorHandler.handle(error)
        }
        
        return []
    }
    
    func deleteAllPosts() {
        deleteAllData(Entities.post)
    }
    
    private func deleteAllData(_ entity:String) {
        guard let managed = self.managedContext else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managed.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managed.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}
