import Dispatch

extension DispatchQueue {
	/**
	 * This is used to keep message handling away from the libuv loop
	 */
	public static let networkingDispatcher = DispatchQueue(label: "NetworkingDispatcher", attributes: .concurrent)

	/**
	 * This is used to keep message handling away from the libuv loop
	 */
	public static let messageDispatcher = DispatchQueue(label: "MessageDispatcher", attributes: .concurrent)

	/**
	 * This queue is used to keep the session-related stores in sync in a high-concurrency environment
	 */
	public static let sessionSyncDispatcher = DispatchQueue(label: "SessionSyncDispatcher")

	/**
	 * This queue is used to run session-related async operations
	 */
	public static let sessionDispatcher = DispatchQueue(label: "SessionDispatcher", attributes: .concurrent)

	/** 
	 *  Player authentication and other player-related async operations are executed on this queue
	 */
	public static let playerDispatcher = DispatchQueue(label: "PlayerDispatcher", attributes: .concurrent)

	/** 
	 * Player synchronisation is handled on this queue
	 */
	public static let playerSyncDispatcher = DispatchQueue(label: "PlayerSyncDispatcher")

	/**
	 * Player data saves are executed on this queue
	 */
	public static let playerSaveDispatcher = DispatchQueue(label: "PlayerSaveDispatcher")

	/**
	 * Room processing is dispatched to this queue
	 */
	public static let roomDispatcher = DispatchQueue(label: "RoomDispatcher", attributes: .concurrent)

	/**
	 * Room synchronisation is dispatched on this queue
	 */
	public static let roomSyncDispatcher = DispatchQueue(label: "RoomSyncDispatcher")

	/**
	 * Catalog synchronisation is dispatched to this queue
	 */
	public static let catalogSyncDispatcher = DispatchQueue(label: "CatalogDispatcher")

	/**
	 * Permission synchronisation is dispatched to this queue
	 */
	public static let permissionSyncDispatcher = DispatchQueue(label: "PermissionSyncDispatcher")

	/*
	 * Executes a method every chosen interval
	 */
	public func asyncAfter(everyInterval time: Double, execute: @escaping() -> Void) {
		self.asyncAfter(deadline: .now() + time) {
			[unowned self] in
			execute()

			self.asyncAfter(everyInterval: time) {
				execute()
			}
		}
	}

	/*
	 * Creates a timer that can be stopped. 
	 */
	public func createTimer(everyInterval interval: DispatchTimeInterval, block: @escaping() -> Void) -> DispatchSourceTimer {
		let timer = DispatchSource.makeTimerSource(queue: self)

		timer.scheduleRepeating(deadline: .now(), interval: interval)
		timer.setEventHandler {
			block()
		}

		return timer
	}
}