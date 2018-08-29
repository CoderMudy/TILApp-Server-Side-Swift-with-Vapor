import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
	
	// Acronyms route
	let acronymsController = AcronymsController()
	try router.register(collection: acronymsController)
	
	// User route
	let usersController = UserController()
	try router.register(collection: usersController)
	
	// Categories route
	let categoriesController = CategoriesController ()
	try router.register(collection: categoriesController)
}
