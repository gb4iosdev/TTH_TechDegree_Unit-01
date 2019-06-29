import Foundation

typealias Player = [String : String]

var players:[Player] = [
    ["name" : "Joe Smith",            "height" : "42", "isExperienced" : "YES", "guardians" : "Jim and Jan Smith"],
    ["name" : "Jill Tanner",          "height" : "36", "isExperienced" : "YES", "guardians" : "Clara Tanner"],
    ["name" : "Bill Bon",             "height" : "43", "isExperienced" : "YES", "guardians" : "Sara and Jenny Bon"],
    ["name" : "Eva Gordon",           "height" : "45", "isExperienced" : "NO",  "guardians" : "Wendy and Mike Gordon"],
    ["name" : "Matt Gill",            "height" : "40", "isExperienced" : "NO",  "guardians" : "Charles and Sylvia Gill"],
    
    ["name" : "Kimmy Stein",          "height" : "41", "isExperienced" : "NO",  "guardians" : "Bill and Hillary Stein"],
    ["name" : "Sammy Adams",          "height" : "45", "isExperienced" : "NO",  "guardians" : "Jeff Adams"],
    ["name" : "Karl Saygan",          "height" : "42", "isExperienced" : "YES", "guardians" : "Heather Bledsoe"],
    ["name" : "Suzane Greenberg",     "height" : "44", "isExperienced" : "YES", "guardians" : "Henrietta Dumas"],
    ["name" : "Sal Dali",             "height" : "41", "isExperienced" : "NO",  "guardians" : "Gala Dali"],
    
    ["name" : "Joe Kavalier",         "height" : "39", "isExperienced" : "NO",  "guardians" : "Sam and Elaine Kavalier"],
    ["name" : "Ben Finkelstein",      "height" : "44", "isExperienced" : "NO",  "guardians" : "Aaron and Jill Finkelstein"],
    ["name" : "Diego Soto",           "height" : "41", "isExperienced" : "YES", "guardians" : "Robin and Sarika Soto"],
    ["name" : "Chloe Alaska",         "height" : "47", "isExperienced" : "NO",  "guardians" : "David and Jamie Alaska"],
    ["name" : "Arnold Willis",        "height" : "43", "isExperienced" : "NO",  "guardians" : "Claire Willis"],
    
    ["name" : "Phillip Helm",         "height" : "44", "isExperienced" : "YES",  "guardians" : "Thomas Helm and Eva Jones"],
    ["name" : "Les Clay",             "height" : "42", "isExperienced" : "YES",  "guardians" : "Wynonna Brown"],
    ["name" : "Herschel Krustofski",  "height" : "45", "isExperienced" : "YES",  "guardians" : "Hyman and Rachel Krustofski"]
]

//Team Information
let teamsInfo: [String : [String : String]] = [
    "teamSharks"  : ["teamName" : "Sharks",  "trainingTime" : "March 17, 3pm"],
    "teamDragons" : ["teamName" : "Dragons", "trainingTime" : "March 17, 1pm"],
    "teamRaptors" : ["teamName" : "Raptors", "trainingTime" : "March 18, 1pm"]
]

//temporary teams to sort experienced from not
var experiencedPlayers: [Player] = []
var inExperiencedPlayers: [Player] = []

//Final team collections
var teamSharks:  [Player] = []
var teamDragons: [Player] = []
var teamRaptors: [Player] = []

//Temporary variables to assist with allocations
var teams: [[Player]] = [teamSharks, teamDragons, teamRaptors]

//Set this to false for 'Meets Expectations' functionality only
var withEqualHeights = true

var letters: [String] = []

func assignPlayers() {
    
    //Sort teams into experienced and not:
    for player in players {
        if player["isExperienced"] == "YES" {
            experiencedPlayers.append(player)
        } else {
            inExperiencedPlayers.append(player)
        }
    }
    
    //Assign experienced players first
    if withEqualHeights {
        addPlayersToTeamsEqualHeights(experiencedPlayers)
        addPlayersToTeamsEqualHeights(inExperiencedPlayers)
    } else {    //Just allocate to the teams
        addPlayersToTeams(experiencedPlayers)
        addPlayersToTeams(inExperiencedPlayers)
    }
    
}

func addPlayersToTeamsEqualHeights(_ players: [Player]) {
    //Used to assist in sorting case where player is appended to end of sortedTeam array (ie no greater height is found)
    var greaterHeightFound: Bool
    
    //Simply add the first element
    var sortedTeam: [Player] = []
    sortedTeam.append(players[0])
    
    //Sort the players in asc order of height
    for player in players {
        greaterHeightFound = false
        let playerHeight = player["height"]!
        for index in 0..<sortedTeam.count {
            if playerHeight <= sortedTeam[index]["height"]! {
                greaterHeightFound = true
                sortedTeam.insert(player, at: index)
                break
            }
        }
        if !greaterHeightFound {    //No greater height found, so add to the end
            sortedTeam.append(player)
        }
    }
    
    //Cycles through array positions to allocate to teams
    var nextTeamForPlayer: Int = 0
    //Add the players in outside pairs to achieve as close to average height as possible
    while sortedTeam.count > teams.count {
        teams[nextTeamForPlayer % teams.count].append(sortedTeam.removeFirst())
        teams[nextTeamForPlayer % teams.count].append(sortedTeam.removeLast())
        nextTeamForPlayer += 1
    }
    
    //add last set of players not able to be allocated in pairs (if any)
    addPlayersToTeams(sortedTeam)
}

func addPlayersToTeams(_ players: [Player]) {
    
    for (index, player) in players.enumerated() {
        teams[index % teams.count].append(player)
    }
}

func averageHeightOf(_ players: [Player]) -> Double {
    var sum: Int = 0
    for player in players {
        sum += Int(player["height"]!)!
    }
    return round((10 * Double(sum) / Double(players.count)))/10
}

//Function generateLetters simply adds a string per player to the letters collection
func generateLetters(withTeamInfo team: String, withPlayers players: [Player]) {
    
    for player in players {
        letters.append ("Dear \(player["guardians"]!) \n\n  This letter is to let you know that your child \(player["name"]!) has been assigned to the soccer team: \(teamsInfo[team]!["teamName"]!) \n  Please note that the first practice time is: \(teamsInfo[team]!["trainingTime"]!) \n\nBest Regards \nTeam Tree House Soccer Academy \n")
    }
}

func outputLetters() {
    for letter in letters {
        print("\(letter) \n")
    }
}

assignPlayers()

teamSharks =  teams[0]
teamDragons = teams[1]
teamRaptors = teams[2]

if withEqualHeights {
    print("Average ht of \(teamsInfo["teamSharks"]!["teamName"]!) is: \(averageHeightOf(teamSharks))")
    print("Average ht of \(teamsInfo["teamDragons"]!["teamName"]!) is: \(averageHeightOf(teamDragons))")
    print("Average ht of \(teamsInfo["teamRaptors"]!["teamName"]!) is: \(averageHeightOf(teamRaptors))\n\n")
}

generateLetters(withTeamInfo: "teamSharks", withPlayers: teamSharks)
generateLetters(withTeamInfo: "teamDragons", withPlayers: teamSharks)
generateLetters(withTeamInfo: "teamRaptors", withPlayers: teamSharks)

outputLetters()

