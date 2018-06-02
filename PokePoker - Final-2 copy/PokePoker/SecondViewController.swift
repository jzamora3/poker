//
//  SecondViewController.swift
//  PokePoker
//
//  Created by A on 2/14/18.
//  Copyright © 2018 A. All rights reserved.
//

import UIKit
import AVFoundation

var isAlreadyPlayed = false

class SecondViewController: UIViewController{
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        
        imgOutletPokerHand.isHidden = true
        btnOutletBackToGame.isHidden = true
        
        
        btnOutletNextHand.isHidden = true
        lblOutletWinnerLabel.isHidden = true
        lblOutletNextBet.isHidden = true
        
        lblPlayerChips.text = String(playerChips)
        lblComputerChips.text = String(computerChips)
        lblPotChips.text = String(pot)
        
        if(isAlreadyPlayed == false){
            playWithSound(fileName: "Intro", fileExtension: "mp3")
        }
        isAlreadyPlayed = true
    }

    func playWithSound(fileName: String, fileExtension:String) -> Void {
        
        let audioSourceURL : URL!
        audioSourceURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if audioSourceURL == nil {
            print("Song cannot be played")
        } else {
            do {
                audioPlayer = try AVAudioPlayer.init(contentsOf: audioSourceURL!)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }

    // Dictionary from Index to Deck of Cards Image
    var cardDeckImages = [0: "2_of_spades",1: "3_of_spades",2: "4_of_spades",3: "5_of_spades", 4: "6_of_spades", 5: "7_of_spades", 6: "8_of_spades", 7: "9_of_spades",  8: "10_of_spades", 9: "jack_of_spades", 10: "queen_of_spades", 11: "king_of_spades", 12: "ace_of_spades",13: "2_of_diamonds",14: "3_of_diamonds",15: "4_of_diamonds",16: "5_of_diamonds", 17: "6_of_diamonds", 18: "7_of_diamonds", 19: "8_of_diamonds", 20: "9_of_diamonds", 21 : "10_of_diamonds", 22: "jack_of_diamonds", 23: "queen_of_diamonds", 24: "king_of_diamonds", 25: "ace_of_diamonds", 26: "2_of_clubs",27: "3_of_clubs",28: "4_of_clubs",29: "5_of_clubs", 30: "6_of_clubs", 31: "7_of_clubs", 32: "8_of_clubs", 33: "9_of_clubs", 34 : "10_of_clubs", 35: "jack_of_clubs", 36: "queen_of_clubs", 37: "king_of_clubs", 38: "ace_of_clubs",39: "2_of_hearts",40: "3_of_hearts",41: "4_of_hearts",42: "5_of_hearts", 43: "6_of_hearts", 44: "7_of_hearts", 45: "8_of_hearts", 46: "9_of_hearts", 47 : "10_of_hearts", 48: "jack_of_hearts", 49: "queen_of_hearts", 50: "king_of_hearts",51: "ace_of_hearts"]
    
    // Deck of Cards
    var cardDeck = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51]
    
    // Virtual Hands
    var computerHand = [Int]()
    
    var playerHand = [Int]()
    
    // Starting Chips
    var computerChips = 1000
    
    var playerChips = 1000
    
    var pot = 0
    
    var gameClock = 0
    
    
    @IBOutlet weak var btnOutletNextHand: UIButton!
    
    @IBOutlet weak var lblOutletNextBet: UILabel!
    
    @IBAction func btnActionNextButton(_ sender: UIButton) {
        
        btnOutletNextHand.isHidden = true
        lblOutletWinnerLabel.isHidden = true
        
        PlayerCardOne.image = UIImage(named: "back_red")
        PlayerCardTwo.image = UIImage(named: "back_red")
        PlayerCardThree.image = UIImage(named: "back_red")
        PlayerCardFour.image = UIImage(named: "back_red")
        PlayerCardFive.image = UIImage(named: "back_red")
        ComputerCardOne.image = UIImage(named: "back_red")
        ComputerCardTwo.image = UIImage(named: "back_red")
        ComputerCardThree.image = UIImage(named: "back_red")
        ComputerCardFour.image = UIImage(named: "back_red")
        ComputerCardFive.image = UIImage(named: "back_red")
        
        letsStartTheGame()
        
    }
    
    
    @IBOutlet weak var lblOutletWinnerLabel: UILabel!
    
    // Virtual Hand Computer
    @IBOutlet weak var ComputerCardOne: UIImageView!
    @IBOutlet weak var ComputerCardTwo: UIImageView!
    @IBOutlet weak var ComputerCardThree: UIImageView!
    @IBOutlet weak var ComputerCardFour: UIImageView!
    @IBOutlet weak var ComputerCardFive: UIImageView!
    
    // Virtual Hand Player
    @IBOutlet weak var PlayerCardOne: UIImageView!
    @IBOutlet weak var PlayerCardTwo: UIImageView!
    @IBOutlet weak var PlayerCardThree: UIImageView!
    @IBOutlet weak var PlayerCardFour: UIImageView!
    @IBOutlet weak var PlayerCardFive: UIImageView!
    
    // Label Counters
    @IBOutlet weak var lblComputerChips: UILabel!
    @IBOutlet weak var lblPlayerChips: UILabel!
    @IBOutlet weak var lblPotChips: UILabel!
    
    @IBOutlet weak var btnOutlet10Chip: UIButton!
    
    func computerFolds() {
        playWithSound(fileName: "ElizaFolded", fileExtension: "m4a")
        playerChips = playerChips + pot
        pot = 0
        gameClock = 0
        computerHand = [Int]()
        playerHand = [Int]()
        letsStartTheGame()
    }
    
    // If Player wants to Bet 10 Chips
    @IBAction func btnAction10Chip(_ sender: UIButton) {
        // Computer will always bet 10 and then place it into the pot
        computerChips = computerChips - 10
        playerChips = playerChips - 10
        pot = pot + 20
        
        // Chips will be Hidden
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        
        // Update Labels
        lblPlayerChips.text = String(playerChips)
        lblComputerChips.text = String(computerChips)
        lblPotChips.text = String(pot)
        
        
        
        if(gameClock == 0){
            gameClock = gameClock + 1
            
            if(playerChips <= 0 || computerChips <= 0){
                DealCards()
                winnerMethod()
            }else{
               continueAfterFirstBet()
            }
        }else{
            winnerMethod()
        }
        
    }
    
    @IBOutlet weak var btnOutlet50Chip: UIButton!
    
    @IBAction func btnAction50Chip(_ sender: UIButton) {
        //  Computer will bet 50 if it has highest card or anything else
        playerChips = playerChips - 50
        computerChips = computerChips - 50
        pot = pot + 100
        
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        
        lblPlayerChips.text = String(playerChips)
        lblComputerChips.text = String(computerChips)
        lblPotChips.text = String(pot)
        
        
        
        if(gameClock == 0){
            gameClock = gameClock + 1
            
            if(playerChips <= 0 || computerChips <= 0){
                DealCards()
                winnerMethod()
            }else{
                continueAfterFirstBet()
            }
        }else{
            winnerMethod()
        }
        
    }
    @IBOutlet weak var btnOutlet100Chip: UIButton!
    @IBAction func btnAction100Chip(_ sender: UIButton) {
        
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        
        if(gameClock == 0){
            gameClock = gameClock + 1
            var compChoice = ["no","yes","no","yes","no","yes","no","yes","no","yes"]
            let randomChoice = Int(arc4random_uniform(10))
            if(compChoice[randomChoice] == "yes"){
                computerChips = computerChips - 100
                playerChips = playerChips - 100
                pot = pot + 200
                
                if(playerChips <= 0 || computerChips <= 0){
                    DealCards()
                    winnerMethod()
                }else{
                    lblPlayerChips.text = String(playerChips)
                    lblComputerChips.text = String(computerChips)
                    lblPotChips.text = String(pot)
                    
                    continueAfterFirstBet()
                    
                }
            }else{
                computerFolds()
            }
            
        }else{
            if(myHighestTwoPair(hand: computerHand) != -1 || myHighestThreePair(hand: computerHand) != -1 || myHighestTwoPairTwoPair(hand: computerHand) != -1 || myHighestStraight(hand: computerHand) != -1 || myHighestFlush(hand: computerHand) != -1 || highestFullHouse(hand: computerHand) != -1 || highestFourOfAKind(hand: computerHand) != -1 || myHighestStraightFlush(hand: computerHand) != -1 || royalFlush(hand: computerHand) != -1){
                triggerWinnerOrLoserAlert()
                playerChips = playerChips - 100
                computerChips = computerChips - 100
                pot = pot + 200
                
                lblPlayerChips.text = String(playerChips)
                lblComputerChips.text = String(computerChips)
                lblPotChips.text = String(pot)
                
                winnerMethod()
                
            }else{
                computerFolds()
            }
        }
    }
    
    @IBOutlet weak var btnOutlet500Chip: UIButton!
    
    @IBAction func btnAction500Chip(_ sender: UIButton) {
        
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        
        
        if(gameClock == 0){
            var compChoice = ["no","yes","no","no","no","no","no","no","no","yes"]
            let randomChoice = Int(arc4random_uniform(10))
            if(compChoice[randomChoice] == "yes"){
                
                computerChips = computerChips - 500
                playerChips = playerChips - 500
                pot = pot + 1000
                
                if(playerChips <= 0 || computerChips <= 0){
                    DealCards()
                    winnerMethod()
                }else{
                    lblPlayerChips.text = String(playerChips)
                    lblComputerChips.text = String(computerChips)
                    lblPotChips.text = String(pot)
                    
                    continueAfterFirstBet()
                    
                }
                
                
                
            }else{
                computerFolds()
            }
        }else{
            if(myHighestThreePair(hand: computerHand) != -1 || myHighestTwoPairTwoPair(hand: computerHand) != -1 || myHighestStraight(hand: computerHand) != -1 || myHighestFlush(hand: computerHand) != -1 || highestFullHouse(hand: computerHand) != -1 || highestFourOfAKind(hand: computerHand) != -1 || myHighestStraightFlush(hand: computerHand) != -1 || royalFlush(hand: computerHand) != -1){
                
                computerChips = computerChips - 500
                playerChips = playerChips - 500
                pot = pot + 1000
                
                if(playerChips <= 0 || computerChips <= 0){
                    winnerMethod()
                }
                
                lblPlayerChips.text = String(playerChips)
                lblComputerChips.text = String(computerChips)
                lblPotChips.text = String(pot)
                
                winnerMethod()
                
                
            }else{
                computerFolds()
            }
        }
    }
    
    @IBOutlet weak var btnOutletAllIn: UIButton!
    
    @IBAction func btnActionAllIn(_ sender: UIButton) {
        
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        
        if(gameClock == 0){
            var compChoice = ["no","no","no","no","no","no","no","no","no","yes"]
            let randomChoice = Int(arc4random_uniform(10))
            if(compChoice[randomChoice] == "yes"){
                if(playerChips > computerChips){
                    
                    pot = pot + 2*computerChips
                    playerChips = playerChips - computerChips
                    computerChips = computerChips - computerChips
                    
                    lblPlayerChips.text = String(playerChips)
                    lblComputerChips.text = String(computerChips)
                    lblPotChips.text = String(pot)
                    
                }else{
                    
                    pot = pot + 2*playerChips
                    playerChips = playerChips - playerChips
                    computerChips = computerChips - playerChips
                    
                    
                    lblPlayerChips.text = String(playerChips)
                    lblComputerChips.text = String(computerChips)
                    lblPotChips.text = String(pot)
                    
                }
                DealCards()
                winnerMethod()
            }else{
                computerFolds()
            }
        }else{
            if(myHighestStraight(hand: computerHand) != -1 || myHighestFlush(hand: computerHand) != -1 || highestFullHouse(hand: computerHand) != -1 || highestFourOfAKind(hand: computerHand) != -1 || myHighestStraightFlush(hand: computerHand) != -1 || royalFlush(hand: computerHand) != -1){
                if(playerChips > computerChips){
                    
                    pot = pot + 2*computerChips
                    playerChips = playerChips - computerChips
                    computerChips = computerChips - computerChips
                    
                    
                    lblPlayerChips.text = String(playerChips)
                    lblComputerChips.text = String(computerChips)
                    lblPotChips.text = String(pot)
                    
                    winnerMethod()
                    
                }else{
                    
                    pot = pot + 2*playerChips
                    playerChips = playerChips - playerChips
                    computerChips = computerChips - playerChips
                    
                    
                    lblPlayerChips.text = String(playerChips)
                    lblComputerChips.text = String(computerChips)
                    lblPotChips.text = String(pot)
                    
                    winnerMethod()
                }
                
            }else{
                computerFolds()
            }
        }
    }
    

    
    func resetMe() {
        computerChips = 1000
        playerChips = 1000
        lblPlayerChips.text = String(playerChips)
        lblComputerChips.text = String(computerChips)
        lblOutletWinnerLabel.isHidden = true
        btnOutletNextHand.isHidden = true
        btnOutlet10Chip.isHidden = true
        btnOutlet50Chip.isHidden = true
        btnOutlet100Chip.isHidden = true
        btnOutlet500Chip.isHidden = true
        btnOutletAllIn.isHidden = true
        gameClock = 0
        pot = 0
        lblPotChips.text = String(pot)
        PlayerCardOne.image = UIImage(named: "back_red")
        PlayerCardTwo.image = UIImage(named: "back_red")
        PlayerCardThree.image = UIImage(named: "back_red")
        PlayerCardFour.image = UIImage(named: "back_red")
        PlayerCardFive.image = UIImage(named: "back_red")
        ComputerCardOne.image = UIImage(named: "back_red")
        ComputerCardTwo.image = UIImage(named: "back_red")
        ComputerCardThree.image = UIImage(named: "back_red")
        ComputerCardFour.image = UIImage(named: "back_red")
        ComputerCardFive.image = UIImage(named: "back_red")
        playWithSound(fileName: "Intro", fileExtension: "mp3")
        btnOutletStart.isUserInteractionEnabled = true
        btnOutletStart.alpha = 1.0;
        
    }
    @IBAction func resetButton(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Reset", message: "All game data will be lost.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            
            self.resetMe()
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var imgOutletPokerHand: UIImageView!
    
    @IBAction func btnBackToGame(_ sender: UIButton) {
        imgOutletPokerHand.isHidden = true
        btnOutletBackToGame.isHidden = true
    }
    
    @IBAction func btnActionFold(_ sender: UIButton) {
        computerChips = pot + computerChips
        pot = 0
        gameClock = 0
        computerHand = [Int]()
        playerHand = [Int]()
        triggerWinnerOrLoserAlert()
        letsStartTheGame()
        
    }
    @IBOutlet weak var btnOutletBackToGame: UIButton!
    
    @IBAction func btnActionHelp(_ sender: UIButton) {
        btnOutletBackToGame.isHidden = false
        imgOutletPokerHand.isHidden = false
        
    }
    
    @IBOutlet weak var btnOutletStart: UIButton!
    
    
    @IBAction func startTheGame(_ sender: UIButton) {
        btnOutletStart.isUserInteractionEnabled = false
        btnOutletStart.alpha = 0.5;
        letsStartTheGame()
    }
    
    func letsStartTheGame() {
        
        PlayerCardOne.image = UIImage(named: "back_red")
        PlayerCardTwo.image = UIImage(named: "back_red")
        PlayerCardThree.image = UIImage(named: "back_red")
        PlayerCardFour.image = UIImage(named: "back_red")
        PlayerCardFive.image = UIImage(named: "back_red")
        ComputerCardOne.image = UIImage(named: "back_red")
        ComputerCardTwo.image = UIImage(named: "back_red")
        ComputerCardThree.image = UIImage(named: "back_red")
        ComputerCardFour.image = UIImage(named: "back_red")
        ComputerCardFive.image = UIImage(named: "back_red")
        
        lblOutletNextBet.isHidden = false
        lblOutletWinnerLabel.isHidden = true
        lblPotChips.text = String(0)
        Ante()
        lblOutletNextBet.text = "First Bet"
        //playWithSound(fileName: "RaiseOrFold", fileExtension: "mp3")
        Bet()
    }
    
    func continueAfterFirstBet() {
        DealCards()
        lblOutletNextBet.text = "Second Bet"
        //playWithSound(fileName: "RaiseOrFold", fileExtension: "mp3")
        Bet()
    }
    
    func pickACard() -> Int {
        var randomCardIndex = Int(arc4random_uniform(52))
        var allCards : [Int]
        allCards = computerHand + playerHand
        var myCard = cardDeck[randomCardIndex]
        
        while(allCards.contains(myCard)) {
            randomCardIndex = Int(arc4random_uniform(52))
            myCard = cardDeck[randomCardIndex]
        }
        return myCard
    }
    
    func Bet() {
        btnOutlet10Chip.isHidden = false
        btnOutlet50Chip.isHidden = false
        btnOutlet100Chip.isHidden = false
        btnOutlet500Chip.isHidden = false
        btnOutletAllIn.isHidden = false
        if(playerChips < 500){
            btnOutlet500Chip.isUserInteractionEnabled = false
            btnOutlet500Chip.alpha = 0.5;
        }
        if(playerChips < 100){
            btnOutlet100Chip.isUserInteractionEnabled = false
            btnOutlet100Chip.alpha = 0.5;
        }
        if(playerChips < 50){
            btnOutlet50Chip.isUserInteractionEnabled = false
            btnOutlet50Chip.alpha = 0.5;
        }
        if(playerChips < 10){
            btnOutlet10Chip.isUserInteractionEnabled = false
            btnOutlet10Chip.alpha = 0.5;
        }
        if(playerChips > 500){
            btnOutlet500Chip.isUserInteractionEnabled = true
            btnOutlet500Chip.alpha = 1.0;
        }
        if(playerChips > 100){
            btnOutlet100Chip.isUserInteractionEnabled = true
            btnOutlet100Chip.alpha = 1.0;
        }
        if(playerChips > 50){
            btnOutlet50Chip.isUserInteractionEnabled = true
            btnOutlet50Chip.alpha = 1.0;
        }
        if(playerChips > 10){
            btnOutlet10Chip.isUserInteractionEnabled = true
            btnOutlet10Chip.alpha = 1.0;
        }
        
    }
    func Ante() {
        computerChips = computerChips - 10
        playerChips = playerChips - 10
        pot = pot + 20
       
        lblComputerChips.text = String(computerChips)
        lblPlayerChips.text = String(playerChips)
        lblPotChips.text = String(pot)
    }
    
    func triggerWinnerOrLoserAlert() {
        if(playerChips <= 0){
            let alertController = UIAlertController(title: "Sorry", message: "Maybe next time!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            pot = 0
            gameClock = 0
            computerHand = [Int]()
            playerHand = [Int]()
            computerChips = 1000
            playerChips = 1000
            letsStartTheGame()
        }else if(computerChips <= 0){
            let alertController = UIAlertController(title: "Congrats", message: "Great Job! Eliza is impressed.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
            pot = 0
            gameClock = 0
            computerHand = [Int]()
            playerHand = [Int]()
            computerChips = 1000
            playerChips = 1000
            letsStartTheGame()
        }
    }
    
    func DealCards() {
        playerHand.append(pickACard())
        PlayerCardOne.image = UIImage(named: cardDeckImages[playerHand[0]]!)
        playerHand.append(pickACard())
        PlayerCardTwo.image = UIImage(named: cardDeckImages[playerHand[1]]!)
        playerHand.append(pickACard())
        PlayerCardThree.image = UIImage(named: cardDeckImages[playerHand[2]]!)
        playerHand.append(pickACard())
        PlayerCardFour.image = UIImage(named: cardDeckImages[playerHand[3]]!)
        playerHand.append(pickACard())
        PlayerCardFive.image = UIImage(named: cardDeckImages[playerHand[4]]!)
        
        computerHand.append(pickACard())
        //ComputerCardOne.image = UIImage(named: cardDeckImages[computerHand[0]]!)
        computerHand.append(pickACard())
        //ComputerCardTwo.image = UIImage(named: cardDeckImages[computerHand[1]]!)
        computerHand.append(pickACard())
        //ComputerCardThree.image = UIImage(named: cardDeckImages[computerHand[2]]!)
        computerHand.append(pickACard())
        //ComputerCardFour.image = UIImage(named: cardDeckImages[computerHand[3]]!)
        computerHand.append(pickACard())
        //ComputerCardFive.image = UIImage(named: cardDeckImages[computerHand[4]]!)
    }
    
    
    
    func winnerMethod() {
        lblOutletNextBet.isHidden = true
        var computerRank = 0
        var playerRank = 0
        
        //Highest Card
        if(highestCard(hand : playerHand) > highestCard(hand : computerHand))
        {
            playerRank = 1
            
        }else if(highestCard(hand : playerHand) < highestCard(hand : computerHand)){
            
            computerRank = 1
        
        }else if(highestCard(hand : playerHand) == highestCard(hand : computerHand)){
            //Second Hand
            if(secondHighestCard(hand : playerHand) > secondHighestCard(hand : computerHand))
            {
                playerRank = 1
                
            }else if(secondHighestCard(hand : playerHand) < secondHighestCard(hand : computerHand)){
                
                computerRank = 1
                
            }else if(secondHighestCard(hand : playerHand) == secondHighestCard(hand : computerHand)){
            //Third Hand
                if(thirdHighestCard(hand : playerHand) > thirdHighestCard(hand : computerHand))
                {
                    playerRank = 1
                    
                }else if(thirdHighestCard(hand : playerHand) < thirdHighestCard(hand : computerHand)){
                    
                    computerRank = 1
                    
                }else if(thirdHighestCard(hand : playerHand) == thirdHighestCard(hand : computerHand)){
                    // Fourth Hand
                    if(fourthHighestCard(hand : playerHand) > fourthHighestCard(hand : computerHand))
                    {
                        playerRank = 1
                        
                    }else if(fourthHighestCard(hand : playerHand) < fourthHighestCard(hand : computerHand)){
                        
                        computerRank = 1
                        
                    }else if(fourthHighestCard(hand : playerHand) == fourthHighestCard(hand : computerHand)){
                        // Fifth Hand
                        if(fifthHighestCard(hand : playerHand) > fifthHighestCard(hand : computerHand))
                        {
                            playerRank = 1
                            
                        }else if(fifthHighestCard(hand : playerHand) < fifthHighestCard(hand : computerHand)){
                            
                            computerRank = 1
                            
                        }else if(fifthHighestCard(hand : playerHand) == fifthHighestCard(hand : computerHand)){
                            playerRank = 1
                            computerRank = 1
                        }
                    }
                }
            }
        }
        //Pair
        if(myHighestTwoPair(hand : playerHand) == -1){
            if(myHighestTwoPair(hand : computerHand) == -1){

            }else{
                computerRank = 2
            }
        }else if(myHighestTwoPair(hand : computerHand) == -1){
            if(myHighestTwoPair(hand : playerHand) == -1){
                
            }else{
                playerRank = 2
            }
        }else if(myHighestTwoPair(hand : computerHand) > myHighestTwoPair(hand : playerHand)){
            computerRank = 2
        }else if(myHighestTwoPair(hand : computerHand) < myHighestTwoPair(hand : playerHand)){
            playerRank = 2
        }else if(myHighestTwoPair(hand : computerHand) == myHighestTwoPair(hand : playerHand)){
            print("Kinda Tie")
        }
        //Two Pair
        if(myHighestTwoPairTwoPair(hand : playerHand) == -1){
            if(myHighestTwoPairTwoPair(hand : computerHand) == -1){
                
            }else{
                computerRank = 3
            }
        }else if(myHighestTwoPairTwoPair(hand : computerHand) == -1){
            if(myHighestTwoPairTwoPair(hand : playerHand) == -1){
                
            }else{
                playerRank = 3
            }
        }else if(myHighestTwoPairTwoPair(hand : computerHand) > myHighestTwoPairTwoPair(hand : playerHand)){
            computerRank = 3
        }else if(myHighestTwoPairTwoPair(hand : computerHand) < myHighestTwoPairTwoPair(hand : playerHand)){
            playerRank = 3
        }else if(myHighestTwoPairTwoPair(hand : computerHand) == myHighestTwoPairTwoPair(hand : playerHand)){
            print("Kinda Tie")
        }
        
        
        //Three Pair
        if(myHighestThreePair(hand : playerHand) == -1){
            if(myHighestThreePair(hand : computerHand) == -1){
                
            }else{
                computerRank = 4
            }
        }else if(myHighestThreePair(hand : computerHand) == -1){
            if(myHighestThreePair(hand : playerHand) == -1){
                
            }else{
                playerRank = 4
            }
        }else if(myHighestThreePair(hand : computerHand) > myHighestThreePair(hand : playerHand)){
            computerRank = 4
        }else if(myHighestThreePair(hand : computerHand) < myHighestThreePair(hand : playerHand)){
            playerRank = 4
        }else if(myHighestThreePair(hand : computerHand) == myHighestThreePair(hand : playerHand)){
            print("Kinda Tie")
        }
        
        //Straight
        if(myHighestStraight(hand : playerHand) == -1){
            if(myHighestStraight(hand : computerHand) == -1){
                
            }else{
                computerRank = 5
            }
        }else if(myHighestStraight(hand : computerHand) == -1){
            if(myHighestStraight(hand : playerHand) == -1){
                
            }else{
                playerRank = 5
            }
        }else if(myHighestStraight(hand : computerHand) > myHighestStraight(hand : playerHand)){
            computerRank = 5
        }else if(myHighestStraight(hand : computerHand) < myHighestStraight(hand : playerHand)){
            playerRank = 5
        }else if(myHighestStraight(hand : computerHand) == myHighestStraight(hand : playerHand)){
            print("Kinda Tie")
        }
        
        //Flush
        if(myHighestFlush(hand : playerHand) == -1){
            if(myHighestFlush(hand : computerHand) == -1){
                
            }else{
                computerRank = 6
            }
        }else if(myHighestFlush(hand : computerHand) == -1){
            if(myHighestFlush(hand : playerHand) == -1){
                
            }else{
                playerRank = 6
            }
        }else if(myHighestFlush(hand : computerHand) > myHighestFlush(hand : playerHand)){
            computerRank = 6
        }else if(myHighestFlush(hand : computerHand) < myHighestFlush(hand : playerHand)){
            playerRank = 6
        }else if(myHighestFlush(hand : computerHand) == myHighestFlush(hand : playerHand)){
            print("Kinda Tie")
        }
        
        //Full House
        if(highestFullHouse(hand : playerHand) == -1){
            if(highestFullHouse(hand : computerHand) == -1){
                
            }else{
                computerRank = 7
            }
        }else if(highestFullHouse(hand : computerHand) == -1){
            if(highestFullHouse(hand : playerHand) == -1){
                
            }else{
                playerRank = 7
            }
        }else if(highestFullHouse(hand : computerHand) > highestFullHouse(hand : playerHand)){
            computerRank = 7
        }else if(highestFullHouse(hand : computerHand) < highestFullHouse(hand : playerHand)){
            playerRank = 7
        }else if(highestFullHouse(hand : computerHand) == highestFullHouse(hand : playerHand)){
            print("Kinda Tie")
        }
        
        //Four of a Kind
        if(highestFourOfAKind(hand : playerHand) == -1){
            if(highestFourOfAKind(hand : computerHand) == -1){
                
            }else{
                computerRank = 8
            }
        }else if(highestFourOfAKind(hand : computerHand) == -1){
            if(highestFourOfAKind(hand : playerHand) == -1){
                
            }else{
                playerRank = 8
            }
        }else if(highestFourOfAKind(hand : computerHand) > highestFourOfAKind(hand : playerHand)){
            computerRank = 8
        }else if(highestFourOfAKind(hand : computerHand) < highestFourOfAKind(hand : playerHand)){
            playerRank = 8
        }else if(highestFourOfAKind(hand : computerHand) == highestFourOfAKind(hand : playerHand)){
            print("Kinda Tie")
        }
        
        //Straight Flush
        if(myHighestStraightFlush(hand : playerHand) == -1){
            if(myHighestStraightFlush(hand : computerHand) == -1){
                
            }else{
                computerRank = 9
            }
        }else if(myHighestStraightFlush(hand : computerHand) == -1){
            if(myHighestStraightFlush(hand : playerHand) == -1){
                
            }else{
                playerRank = 9
            }
        }else if(myHighestStraightFlush(hand : computerHand) > myHighestStraightFlush(hand : playerHand)){
            computerRank = 9
        }else if(myHighestStraightFlush(hand : computerHand) < myHighestStraightFlush(hand : playerHand)){
            playerRank = 9
        }else if(myHighestStraightFlush(hand : computerHand) == myHighestStraightFlush(hand : playerHand)){
            print("Kinda Tie")
        }
        
        //Royal Flush
        if(royalFlush(hand : playerHand) == -1){
            if(royalFlush(hand : computerHand) == -1){
                
            }else{
                computerRank = 10
            }
        }else if(royalFlush(hand : computerHand) == -1){
            if(royalFlush(hand : playerHand) == -1){
                
            }else{
                playerRank = 10
            }
        }else if(royalFlush(hand : computerHand) > royalFlush(hand : playerHand)){
            computerRank = 10
        }else if(royalFlush(hand : computerHand) < royalFlush(hand : playerHand)){
            playerRank = 10
        }else if(royalFlush(hand : computerHand) == royalFlush(hand : playerHand)){
            print("Kinda Tie")
        }
        
        lblOutletWinnerLabel.isHidden = false
        btnOutletNextHand.isHidden = false
    
        ComputerCardOne.image = UIImage(named: cardDeckImages[computerHand[0]]!)
        ComputerCardTwo.image = UIImage(named: cardDeckImages[computerHand[1]]!)
        ComputerCardThree.image = UIImage(named: cardDeckImages[computerHand[2]]!)
        ComputerCardFour.image = UIImage(named: cardDeckImages[computerHand[3]]!)
        ComputerCardFive.image = UIImage(named: cardDeckImages[computerHand[4]]!)
        
        
        if(computerRank > playerRank){
            lblOutletWinnerLabel.text = "!! Computer Wins !!"
            if(computerRank == 1){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 2){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 3){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 4){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 5){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 6){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 7){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 8){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 9){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }else if(computerRank == 10){
                playWithSound(fileName: "Lose", fileExtension: "mp3")
            }
            computerChips = computerChips + pot
            pot = 0
            gameClock = 0
            computerHand = [Int]()
            playerHand = [Int]()
            btnOutletNextHand.isHidden = false
            triggerWinnerOrLoserAlert()
        }else {
            lblOutletWinnerLabel.text = "!! Player Wins !!"
            if(playerRank == 1){
                playWithSound(fileName: "HighCard", fileExtension: "m4a")
            }else if(playerRank == 2){
                playWithSound(fileName: "Pair", fileExtension: "m4a")
            }else if(playerRank == 3){
                playWithSound(fileName: "TwoPair", fileExtension: "m4a")
            }else if(playerRank == 4){
                playWithSound(fileName: "ThreeOfAKind", fileExtension: "m4a")
            }else if(playerRank == 5){
                playWithSound(fileName: "Straight", fileExtension: "m4a")
            }else if(playerRank == 6){
                playWithSound(fileName: "Flush", fileExtension: "mp3")
            }else if(playerRank == 7){
                playWithSound(fileName: "FullHouse", fileExtension: "m4a")
            }else if(playerRank == 8){
                playWithSound(fileName: "FourOfAKind", fileExtension: "m4a")
            }else if(playerRank == 9){
                playWithSound(fileName: "StraightFlush", fileExtension: "m4a")
            }else if(playerRank == 10){
                playWithSound(fileName: "RoyalFlush", fileExtension: "m4a")
            }
            playerChips = playerChips + pot
            pot = 0
            gameClock = 0
            computerHand = [Int]()
            playerHand = [Int]()
            btnOutletNextHand.isHidden = false
            triggerWinnerOrLoserAlert()
            
        }
    }
    
    func royalFlush(hand: [Int]) -> Int {
        
        let spades_low = 0
        let spades_high = 12
        let diamonds_low = 13
        let diamonds_high = 25
        let clubs_low = 26
        let clubs_high = 38
        let hearts_low = 39
        let hearts_high = 51
        
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        var myHand = hand.sorted()
        
        if(spades_high >= hand[4] && hand[4] >= spades_low && spades_high >= hand[3] && hand[3] >= spades_low && spades_high >= hand[2] && hand[2] >= spades_low && spades_high >= hand[1] && hand[1] >= spades_low && spades_high >= hand[0] && hand[0] >= spades_low){
            if(myHand[4] == spades_high && myHand[3] == spades_high-1 && myHand[2] == spades_high-2 && myHand[1] == spades_high-3 && myHand[0] == spades_high-4){
                return modHand[4]
            }
        }
        
        if(diamonds_high >= hand[4] && hand[4] >= diamonds_low && diamonds_high >= hand[3] && hand[3] >= diamonds_low && diamonds_high >= hand[2] && hand[2] >= diamonds_low && diamonds_high >= hand[1] && hand[1] >= diamonds_low && diamonds_high >= hand[0] && hand[0] >= diamonds_low){
            if(myHand[4] == diamonds_high && myHand[3] == diamonds_high-1 && myHand[2] == diamonds_high-2 && myHand[1] == diamonds_high-3 && myHand[0] == diamonds_high-4){
                return modHand[4]
            }
        }
        
        if(clubs_high >= hand[4] && hand[4] >= clubs_low && clubs_high >= hand[3] && hand[3] >= clubs_low && clubs_high >= hand[2] && hand[2] >= clubs_low && clubs_high >= hand[1] && hand[1] >= clubs_low && clubs_high >= hand[0] && hand[0] >= clubs_low){
            if(myHand[4] == clubs_high && myHand[3] == clubs_high-1 && myHand[2] == clubs_high-2 && myHand[1] == clubs_high-3 && myHand[0] == clubs_high-4){
                return modHand[4]
            }
        }
        
        if(hearts_high >= hand[4] && hand[4] >= hearts_low && hearts_high >= hand[3] && hand[3] >= hearts_low && hearts_high >= hand[2] && hand[2] >= hearts_low && hearts_high >= hand[1] && hand[1] >= hearts_low && hearts_high >= hand[0] && hand[0] >= hearts_low){
            if(myHand[4] == hearts_high && myHand[3] == hearts_high-1 && myHand[2] == hearts_high-2 && myHand[1] == hearts_high-3 && myHand[0] == hearts_high-4){
                return modHand[4]
            }
        }
        return -1
    }
    
    
    
    func myHighestStraightFlush(hand: [Int]) -> Int {
        
        let spades_low = 0
        let spades_high = 12
        let diamonds_low = 13
        let diamonds_high = 25
        let clubs_low = 26
        let clubs_high = 38
        let hearts_low = 39
        let hearts_high = 51
        
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        
        if(spades_high >= hand[4] && hand[4] >= spades_low && spades_high >= hand[3] && hand[3] >= spades_low && spades_high >= hand[2] && hand[2] >= spades_low && spades_high >= hand[1] && hand[1] >= spades_low && spades_high >= hand[0] && hand[0] >= spades_low){
            if(modHand[4] - modHand[3] == 1 && modHand[3] - modHand[2] == 1 && modHand[2] - modHand[1] == 1 && modHand[1] - modHand[0] == 1){
                return modHand[4]
            }
        }
        
        if(diamonds_high >= hand[4] && hand[4] >= diamonds_low && diamonds_high >= hand[3] && hand[3] >= diamonds_low && diamonds_high >= hand[2] && hand[2] >= diamonds_low && diamonds_high >= hand[1] && hand[1] >= diamonds_low && diamonds_high >= hand[0] && hand[0] >= diamonds_low){
            if(modHand[4] - modHand[3] == 1 && modHand[3] - modHand[2] == 1 && modHand[2] - modHand[1] == 1 && modHand[1] - modHand[0] == 1){
                return modHand[4]
            }
        }
        
        if(clubs_high >= hand[4] && hand[4] >= clubs_low && clubs_high >= hand[3] && hand[3] >= clubs_low && clubs_high >= hand[2] && hand[2] >= clubs_low && clubs_high >= hand[1] && hand[1] >= clubs_low && clubs_high >= hand[0] && hand[0] >= clubs_low){
            if(modHand[4] - modHand[3] == 1 && modHand[3] - modHand[2] == 1 && modHand[2] - modHand[1] == 1 && modHand[1] - modHand[0] == 1){
                return modHand[4]
            }
        }
        
        if(hearts_high >= hand[4] && hand[4] >= hearts_low && hearts_high >= hand[3] && hand[3] >= hearts_low && hearts_high >= hand[2] && hand[2] >= hearts_low && hearts_high >= hand[1] && hand[1] >= hearts_low && hearts_high >= hand[0] && hand[0] >= hearts_low){
            if(modHand[4] - modHand[3] == 1 && modHand[3] - modHand[2] == 1 && modHand[2] - modHand[1] == 1 && modHand[1] - modHand[0] == 1){
                return modHand[4]
            }
        }
        return -1
    }
    
    
    func highestFourOfAKind(hand: [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        if(modHand[4] - modHand[3] == 0 && modHand[3] - modHand[2] == 0 && modHand[2] - modHand[1] == 0){
            return modHand[4]
        }
        if(modHand[3] - modHand[2] == 0 && modHand[2] - modHand[1] == 0 && modHand[1] - modHand[0] == 0){
            return modHand[3]
        }
        return -1
    }
    
    func highestFullHouse(hand: [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        if(modHand[4] - modHand[3] == 0 && modHand[3] - modHand[2] == 0){
            if (modHand[1] == modHand[0]){
                return modHand[4]
            }
            return -1
        }
        if(modHand[2] - modHand[1] == 0 && modHand[1] - modHand[0] == 0){
            if (modHand[4] == modHand[3]){
                return modHand[4]
            }
            return -1
        }
        
        if (modHand[4] - modHand[3] == 0){
            if (modHand[2] - modHand[1] == 0 && modHand[1] - modHand[0] == 0){
                return modHand[4]
            }
            return -1
        }
        return -1
    }
    

    
    func myHighestFlush(hand: [Int]) -> Int {
        
        let spades_low = 0
        let spades_high = 12
        let diamonds_low = 13
        let diamonds_high = 25
        let clubs_low = 26
        let clubs_high = 38
        let hearts_low = 39
        let hearts_high = 51
        
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        
        if(spades_high >= hand[4] && hand[4] >= spades_low && spades_high >= hand[3] && hand[3] >= spades_low && spades_high >= hand[2] && hand[2] >= spades_low && spades_high >= hand[1] && hand[1] >= spades_low && spades_high >= hand[0] && hand[0] >= spades_low){
            return modHand[4]
        }
        
        if(diamonds_high >= hand[4] && hand[4] >= diamonds_low && diamonds_high >= hand[3] && hand[3] >= diamonds_low && diamonds_high >= hand[2] && hand[2] >= diamonds_low && diamonds_high >= hand[1] && hand[1] >= diamonds_low && diamonds_high >= hand[0] && hand[0] >= diamonds_low){
            return modHand[4]
        }
        
        if(clubs_high >= hand[4] && hand[4] >= clubs_low && clubs_high >= hand[3] && hand[3] >= clubs_low && clubs_high >= hand[2] && hand[2] >= clubs_low && clubs_high >= hand[1] && hand[1] >= clubs_low && clubs_high >= hand[0] && hand[0] >= clubs_low){
            return modHand[4]
        }
        
        if(hearts_high >= hand[4] && hand[4] >= hearts_low && hearts_high >= hand[3] && hand[3] >= hearts_low && hearts_high >= hand[2] && hand[2] >= hearts_low && hearts_high >= hand[1] && hand[1] >= hearts_low && hearts_high >= hand[0] && hand[0] >= hearts_low){
            return modHand[4]
        }
        return -1
    }
    
    func myHighestStraight(hand: [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        
        if(modHand[4] - modHand[3] == 1 && modHand[3] - modHand[2] == 1 && modHand[2] - modHand[1] == 1 && modHand[1] - modHand[0] == 1){
            return modHand[4]
        }
        return -1
    }
    
    func myHighestTwoPairTwoPair(hand: [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        
        if (modHand[4] - modHand[3]==0){
            if (modHand[2] - modHand[1]==0){
                return modHand[4]
            }
            if (modHand[1] - modHand[0]==0){
                return modHand[4]
            }
            return -1
        }
        if (modHand[3] - modHand[2]==0){
            if (modHand[1] - modHand[0]==0){
                return modHand[3]
            }
            return -1
        }
        return -1
    }
    
    func myHighestThreePair(hand: [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        
        if (modHand[4] - modHand[3] == 0 && modHand[3] - modHand[2] == 0){
            return modHand[4]
        }
        if (modHand[3] - modHand[2] == 0 && modHand[2] - modHand[1] == 0){
            return modHand[3]
        }
        if (modHand[2] - modHand[1] == 0 && modHand[1] - modHand[0] == 0){
            return modHand[2]
        }
        
        return -1
    }
    
    func myHighestTwoPair(hand: [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        
        if (modHand[4] - modHand[3]==0){
            return modHand[4]
        }
        if (modHand[3] - modHand[2]==0){
            return modHand[3]
        }
        if (modHand[2] - modHand[1]==0){
            return modHand[2]
        }
        if (modHand[1] - modHand[0]==0){
            return modHand[1]
        }
        
        return -1
    }
    
    func findOccurences(hand: [Int]) -> [Int: Int]{
        var counts: [Int: Int] = [:]
        
        for item in hand {
            counts[item] = (counts[item] ?? 0) + 1
        }
        return counts
    }
    
    func highestCard(hand : [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        return modHand[4]
    }
    
    func secondHighestCard(hand : [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        return modHand[3]
    }
    
    func thirdHighestCard(hand : [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        return modHand[2]
    }
    
    func fourthHighestCard(hand : [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        return modHand[1]
    }
    
    func fifthHighestCard(hand : [Int]) -> Int {
        var modHand = [Int]()
        for card in hand {
            modHand.append(card%13)
        }
        modHand = modHand.sorted()
        return modHand[0]
    }

}
