//
//  ViewController.swift
//  SoccerCoordinator
//
//  Created by Adrian on 12/1/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    typealias Player = [String : String]
    
    var players:[Player] = [
        ["Name" : "Joe Smith",            "Height" : "42", "Experience" : "YES", "Guardians" : "Jim and Jan Smith"],
        ["Name" : "Jill Tanner",          "Height" : "36", "Experience" : "YES", "Guardians" : "Clara Tanner"],
        ["Name" : "Bill Bon",             "Height" : "43", "Experience" : "YES", "Guardians" : "Sara and Jenny Bon"],
        ["Name" : "Eva Gordon",           "Height" : "45", "Experience" : "NO",  "Guardians" : "Wendy and Mike Gordon"],
        ["Name" : "Matt Gill",            "Height" : "40", "Experience" : "NO",  "Guardians" : "Charles and Sylvia Gill"],
    
        ["Name" : "Kimmy Stein",          "Height" : "41", "Experience" : "NO",  "Guardians" : "Bill and Hillary Stein"],
        ["Name" : "Sammy Adams",          "Height" : "45", "Experience" : "NO",  "Guardians" : "Jeff Adams"],
        ["Name" : "Karl Saygan",          "Height" : "42", "Experience" : "YES", "Guardians" : "Heather Bledsoe"],
        ["Name" : "Suzane Greenberg",     "Height" : "44", "Experience" : "YES", "Guardians" : "Henrietta Dumas"],
        ["Name" : "Sal Dali",             "Height" : "41", "Experience" : "NO",  "Guardians" : "Gala Dali"],
        
        ["Name" : "Joe Kavalier",         "Height" : "39", "Experience" : "NO",  "Guardians" : "Sam and Elaine Kavalier"],
        ["Name" : "Ben Finkelstein",      "Height" : "44", "Experience" : "NO",  "Guardians" : "Aaron and Jill Finkelstein"],
        ["Name" : "Diego Soto",           "Height" : "41", "Experience" : "YES", "Guardians" : "Robin and Sarika Soto"],
        ["Name" : "Chloe Alaska",         "Height" : "47", "Experience" : "NO",  "Guardians" : "David and Jamie Alaska"],
        ["Name" : "Arnold Willis",        "Height" : "43", "Experience" : "NO",  "Guardians" : "Claire Willis"],
        
        ["Name" : "Phillip Helm",         "Height" : "44", "Experience" : "YES",  "Guardians" : "Thomas Helm and Eva Jones"],
        ["Name" : "Les Clay",             "Height" : "42", "Experience" : "YES",  "Guardians" : "Wynonna Brown"],
        ["Name" : "Herschel Krustofski",  "Height" : "45", "Experience" : "YES",  "Guardians" : "Hyman and Rachel Krustofski"]
    ]
    
    //Team Information
    let teamsInfo: [String : [String : String]] = [
        "teamSharks"  : ["TeamName" : "Sharks",  "TrainingTime" : "March 17, 3pm"],
        "teamDragons" : ["TeamName" : "Dragons", "TrainingTime" : "March 17, 1pm"],
        "teamRaptors" : ["TeamName" : "Raptors", "TrainingTime" : "March 18, 1pm"]
    ]
    
    //temporary teams to sort experienced from not
    var experiencedPlayers: [Player] = []
    var inExperiencedPlayers: [Player] = []
    
    //Final team collections
    var teamSharks:  [Player] = []
    var teamDragons: [Player] = []
    var teamRaptors: [Player] = []
    
    //Temporary variables to assist with allocations
    var teams: [[Player]] = Array(repeating: [], count: 3)
    var nextTeamForExperiencedPlayer: Int = 0
    
    //Set this to false for 'Meets Expectations' functionality only
    var withEqualHeights = true
    
    var letters: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignPlayers()
    
        teamSharks =  teams[0]
        teamDragons = teams[1]
        teamRaptors = teams[2]
        
        if withEqualHeights {
            print("Average ht of \(teamsInfo["teamSharks"]!["TeamName"]!) is: \(averageHeightOf(teamSharks))")
            print("Average ht of \(teamsInfo["teamDragons"]!["TeamName"]!) is: \(averageHeightOf(teamDragons))")
            print("Average ht of \(teamsInfo["teamRaptors"]!["TeamName"]!) is: \(averageHeightOf(teamRaptors))\n\n")
        }
        
        generateLetters(withTeamInfo: "teamSharks", withPlayers: teamSharks)
        generateLetters(withTeamInfo: "teamDragons", withPlayers: teamSharks)
        generateLetters(withTeamInfo: "teamRaptors", withPlayers: teamSharks)
        
        outputLetters()
    }
    
    func assignPlayers() {
        
        //Sort teams into experienced and not:
        for player in players {
            if player["Experience"] == "YES" {
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
        for playerIndex in 1..<players.count {
            greaterHeightFound = false
            let playerHeight = players[playerIndex]["Height"]!
            for index in 0..<sortedTeam.count {
                if playerHeight <= sortedTeam[index]["Height"]! {
                    greaterHeightFound = true
                    sortedTeam.insert(players[playerIndex], at: index)
                    break
                }
            }
            if !greaterHeightFound {    //No greater height found, so add to the end
                sortedTeam.append(players[playerIndex])
            }
        }
        
        //Cycles through array possitions 0,1,2 to allocate to teams
        var nextTeamForPlayer: Int = 0
        //Add the players in outside pairs to achieve as close to average height as possible
        while sortedTeam.count > teams.count {
            teams[nextTeamForPlayer].append(sortedTeam.removeFirst())
            teams[nextTeamForPlayer].append(sortedTeam.removeLast())
            nextTeamForPlayer = nextTeamForPlayer == 2 ? 0 : nextTeamForPlayer + 1
        }
        
        //add last set of players not able to be allocated in pairs (if any)
        addPlayersToTeams(sortedTeam)
    }
    
    func addPlayersToTeams(_ players: [Player]) {
        //Cycles through array possitions 0,1,2 to allocate to teams
        var nextTeamForPlayer: Int = 0
        
        for player in players {
            teams[nextTeamForPlayer].append(player)
            nextTeamForPlayer = nextTeamForPlayer == 2 ? 0 : nextTeamForPlayer + 1
        }
    }
    
    func averageHeightOf(_ players: [Player]) -> Double {
        var sum: Int = 0
        for player in players {
            sum += Int(player["Height"]!)!
        }
        return round((10 * Double(sum) / Double(players.count)))/10
    }
    
    //Function generateLetters simply adds a string per player to the letters collection
    func generateLetters(withTeamInfo team: String, withPlayers players: [Player]) {
        
        for player in players {
            letters.append ("Dear \(player["Guardians"]!) \n\n  This letter is to let you know that your child \(player["Name"]!) has been assigned to the soccer team: \(teamsInfo[team]!["TeamName"]!) \n  Please note that the first practice time is: \(teamsInfo[team]!["TrainingTime"]!) \n\nBest Regards \nTeam Tree House Soccer Academy \n")
        }
    }
    
    func outputLetters() {
        for letter in letters {
            print("\(letter) \n")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

