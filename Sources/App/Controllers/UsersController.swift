import Vapor

struct UserController: RouteCollection {
	
	func boot(router:  Router) throws {
		let userControllerRoute = router.grouped("api", "users")
		userControllerRoute.get(use: getAllHandler)
		userControllerRoute.get(User.parameter, use: getHandler)
		userControllerRoute.post(use: createHandler)
		userControllerRoute.get(User.parameter, "acronyms", use: getAcronymsHandler)
	}
	
	func createHandler(_ req: Request) throws -> Future<User> {
		return try req.content.decode(User.self).flatMap(to: User.self) { user in
			return user.save(on: req)
		}
	}
	
	func getAllHandler(_ req: Request) throws -> Future<[User]> {
		return User.query(on: req).all()
	}
	
	func getHandler(_ req: Request) throws -> Future<User> {
		return try req.parameters.next(User.self)
	}
	
	func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
		return try req.parameters.next(User.self).flatMap(to: [Acronym].self) { user in
			return try user.acronym.query(on: req).all()
		}
	}
	
}

extension User: Parameter {}
