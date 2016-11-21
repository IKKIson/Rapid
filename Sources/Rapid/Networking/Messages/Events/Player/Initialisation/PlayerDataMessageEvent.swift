import LoggerAPI

class PlayerDataMessageEvent: MessageEvent<PlayerDataMessageParser> {
    override func handle(_ parser: PlayerDataMessageParser) {
        guard let player = self.player else {
            return
        }

        player.getSession().send(PlayerObjectMessageComposer(playerData: player.getData()))

       // let 
    }
}