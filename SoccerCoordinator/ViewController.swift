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
    
    var teamSharks:  [Player] = []
    var teamDragons: [Player] = []
    var teamRaptors: [Player] = []

    var teams: [[Player]] = []
    
    var nextTeamForExperiencedPlayer: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignPlayers()
        print(teams.count)
        print("Team0: \(teams[0].count) Team1: \(teams[1].count) Team2: \(teams[2].count)")
        teamSharks = teams[0]
        teamDragons = teams[1]
        teamRaptors = teams[2]
    }
    
    func assignPlayers() {
        
        let maxPlayersInTeam = players.count / teams.count
        
        //Allocate all experienced players first to meet requirement of same number of experienced players on each team
        for player in players {
            //Check for experience and assign to the next team that should receive an experienced player, then update to next team
            if player["Experience"] == "YES" {
                teams[nextTeamForExperiencedPlayer].append(player)
                nextTeamForExperiencedPlayer = nextTeamForExperiencedPlayer == 2 ? 0 : nextTeamForExperiencedPlayer + 1
                //print("Team0: \(teams[0].count) Team1: \(teams[1].count) Team2: \(teams[2].count)")
            }
        }//
        for player in players {
            if player["Experience"] == "NO" {
                for teamNum in 0..<teams.count {
                    if teams[teamNum].count < maxPlayersInTeam {
                        teams[teamNum].append(player)
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

