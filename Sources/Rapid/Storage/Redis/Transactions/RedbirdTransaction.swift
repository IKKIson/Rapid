import Redbird
import LoggerAPI

class RedbirdTransaction {
    private var redbirdClient: Redbird

    init(_ redbirdClient: Redbird) {
        self.redbirdClient = redbirdClient
    }

    public func object(forKey key: String) -> [String:String]? {
        var obj: [String: String] = [:]

        do {
            var lastKey: String?

            let response = try self.redbirdClient.command("HGETALL", params: [key]).toArray()

            for entry in response {
                let data = try entry.toString()

                if let key = lastKey {
                    obj[key] = data

                    lastKey = nil
                } else {
                    lastKey = data
                }
            }
        } catch {
            Log.error("Failed to fetch object by key \(key), \(error)")
        }

        return obj.isEmpty ? nil : obj
    }

    public func string(fromMap map: String, key: String) -> String? {
        do {
            let response = try self.redbirdClient.command("HGET", params: [map, key])

            return try response.toMaybeString()
        } catch {
            Log.error("Failed to fetch string from map: \(map) by key: \(key), \(error)")
        }

        return nil
    }

    public func storeObject(key: String, object: [String: String]) {
        var params: [String] = [key]

        for (key, value) in object {
            params.append(key)
            params.append(value)
        }

        do {
            let response = try self.redbirdClient.command("HMSET", params: params)

            print(try response.toString())
        } catch {
            Log.error("Failed to set object for key \(key), error \(error)")
        }
    }

    public func client() -> Redbird {
        return self.redbirdClient
    }
}
