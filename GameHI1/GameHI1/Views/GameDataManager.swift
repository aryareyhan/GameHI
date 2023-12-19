//
//  GameDataManager.swift
//  GameHI1
//
//  Created by Dierta Pasific on 19/12/23.
//

import Foundation
import UIKit
import CoreData


class GameDataManager {

    static let shared = GameDataManager() // Singleton pattern

    private init() {}

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    func clearGameData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "GameDatas")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("GameDatas cleared successfully.")
        } catch {
            print("Error clearing GameDatas: \(error)")
        }
    }
    
    func clearCartData(forUsername username: String) {
            let fetchRequest: NSFetchRequest<CartDatas> = CartDatas.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@", username)

            do {
                let cartDatas = try context.fetch(fetchRequest)

                for cartData in cartDatas {
                    context.delete(cartData)
                }

                try context.save()
            } catch {
                print("Error clearing cart data: \(error)")
            }
        }
    
    func saveGamesIfNeeded() {
            let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()

            do {
                let existingGames = try context.fetch(fetchRequest)

                // Check if Core Data already has games
                guard existingGames.isEmpty else {
                    print("Games already exist in Core Data. Skipping save.")
                    return
                }

                // Save games only if Core Data is empty
                saveGames()

            } catch {
                print("Error fetching games from Core Data: \(error)")
            }
        }


    func saveGames() {
        let games: [GameInfo] = [
            GameInfo(name: "PUBG Mobile", price: "IDR 53.000", minimumAge: "17+", size: "2.68 GB", category: "Action", description: "PUBG Mobile is a fast-paced, multiplayer battle royale game that has taken the mobile gaming world by storm. Based on the immensely popular PC title, it drops 100 players onto a vast island where they must scavenge for weapons, equipment, and resources while striving to be the last person or team standing. The game is renowned for its realistic graphics, intense gameplay, and strategic elements.", ratingText: "5.0", logo: "pubgLogo", bannerImage: "pubgBanner", ratingImage: "fiveRating", screenshot1: "pubg1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Fortnite", price: "IDR 86.000", minimumAge: "12+", size: "2.97 GB", category: "Action", description: "Fortnite has taken the gaming world by storm, and its mobile iteration delivers the same intense and thrilling experience on the go. As a free-to-play battle royale game, Fortnite drops you onto a vibrant island with 99 other players, and the last person or team standing emerges victorious. The mobile version of Fortnite maintains the same dynamic gameplay, where players skydive onto the island, scavenge for weapons and resources, and build structures to outmaneuver opponents.", ratingText: "4.0", logo: "fortniteLogo", bannerImage: "fortniteBanner", ratingImage: "fourRating", screenshot1: "fortnite1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Shadowgun Legends", price: "IDR 36.000", minimumAge: "17+", size: "1.2 GB", category: "Action", description: "Shadowgun Legends is a cutting-edge first-person shooter that thrusts players into a futuristic world overrun by intergalactic invaders and ruthless alien monsters. Developed by MADFINGER Games, this free-to-play mobile game stands out for its console-quality graphics, immersive storyline, and robust multiplayer features. In Shadowgun Legends, you step into the role of an elite Shadowgun, a mercenary charged with saving humanity from the impending alien threat.", ratingText: "5.0", logo: "shadowGunLogo", bannerImage: "shadowGunBanner", ratingImage: "fiveRating", screenshot1: "shadowGun1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Into the Dead 2", price: "IDR 67.000", minimumAge: "16+", size: "1.8 GB", category: "Action", description: "Step into a world overrun by the undead in \"Into the Dead 2,\" a gripping first-person shooter that challenges your survival instincts in the face of a relentless zombie apocalypse. As the protagonist, navigate through an ever-changing landscape filled with hordes of the living dead, desperate to make you their next meal. The game's atmospheric visuals and immersive sound design create an intense and haunting experience. Your journey is punctuated by suspenseful moments as you traverse diverse environments, from eerie forests to desolate fields and abandoned military bases.", ratingText: "3.0", logo: "intoDeadLogo", bannerImage: "intoDeadBanner", ratingImage: "threeRating", screenshot1: "intoDead1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "N.O.V.A Legacy", price: "IDR 83.000", minimumAge: "12+", size: "20 MB", category: "Action", description: "Embark on a thrilling sci-fi adventure with N.O.V.A. Legacy, a mobile first-person shooter that sets the bar high for intense action and futuristic storytelling. In this gripping sci-fi epic, you play the role of Kal Wardin, a retired N.O.V.A. veteran summoned once again to save humanity from an imminent alien threat. N.O.V.A. Legacy takes you to the depths of space, where you'll encounter alien forces plotting to destroy Earth.", ratingText: "4.0", logo: "novaLogo", bannerImage: "novaBanner", ratingImage: "fourRating", screenshot1: "nova1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Alto's Odyssey", price: "IDR 103.000", minimumAge: "4+", size: "280 MB", category: "Adventure", description: "Embark on an enchanting journey across the endless desert landscapes in Alto's Odyssey, a visually stunning and meditative mobile game. This sequel to the critically acclaimed Alto's Adventure takes the serene snow-capped mountains to the vast and mysterious desert, introducing players to a new realm of beauty and challenges. As Alto, the young sandboarder, and his companions, you'll slide gracefully down towering dunes, leap over mystical rock formations, and soar through the air as you navigate the ever-changing terrain.", ratingText: "5.0", logo: "altoLogo", bannerImage: "altoBanner", ratingImage: "fiveRating", screenshot1: "alto1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Monument Valley 2", price: "IDR 78.000", minimumAge: "4+", size: "556 MB", category: "Adventure", description: "In this enchanting puzzle-adventure, players are introduced to a brand new story that weaves together the themes of motherhood, connection, and discovery. Guide Ro and her child through a series of optical illusion-like architectural marvels, each more intricate and awe-inspiring than the last. The game's minimalist yet breathtaking aesthetics draw inspiration from impossible geometry and M.C. Escher's optical illusions, creating a world that defies conventional reality.", ratingText: "3.0", logo: "monumentValleyLogo", bannerImage: "monumentValleyBanner", ratingImage: "threeRating", screenshot1: "monumentValley1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "The Room", price: "IDR 68.900", minimumAge: "4+", size: "391 MB", category: "Adventure", description: "The Room, the game that started it all, invites players into a mysterious world where they discover a peculiar and intricately designed box known as \"the Null.\" As you explore the enigmatic mechanisms of this box, you encounter a series of cryptic puzzles that seamlessly blend with atmospheric visuals and haunting music. The tactile nature of the puzzles, which often involve manipulating intricate mechanisms, provides a deeply immersive experience. The Room sets the stage for a journey filled with secrets, suspense, and a touch of the supernatural.", ratingText: "4.0", logo: "roomLogo", bannerImage: "roomBanner", ratingImage: "fourRating", screenshot1: "room1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Oceanhorn", price: "IDR 108.000", minimumAge: "9+", size: "403 MB", category: "Adventure", description: "As the protagonist, your journey begins as you set sail in search of your lost father, an explorer who vanished mysteriously. The game unfolds as you explore the vast seas, encounter mythical creatures, and unravel the secrets of the ancient kingdom of Arcadia. The narrative weaves a tale of heroism, friendship, and the timeless struggle between good and evil.", ratingText: "2.0", logo: "oceanhornLogo", bannerImage: "oceanhornBanner", ratingImage: "twoRating", screenshot1: "oceanhorn1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Swordigo", price: "IDR 28.000", minimumAge: "9+", size: "68 MB", category: "Adventure", description: "The core gameplay of \"Swordigo\" revolves around dynamic platforming and exhilarating combat. Players navigate through intricate levels, overcoming obstacles, solving puzzles, and battling a variety of enemies. The hero's journey is complemented by a progressive system that allows for character customization and skill development, enhancing both combat prowess and magical abilities.", ratingText: "4.0", logo: "swordigoLogo", bannerImage: "swordigoBanner", ratingImage: "fourRating", screenshot1: "swordigo1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Clash Royale", price: "IDR 42.000", minimumAge: "10+", size: "490 MB", category: "Strategy", description: "Success in Clash Royale hinges on careful deck construction and strategic decision-making. With a vast collection of cards at your disposal, ranging from mighty warriors and mystical spells to formidable siege weapons, every battle becomes a dynamic chess match where adaptability and foresight are crucial. As you progress, unlock and upgrade cards to enhance your arsenal, crafting a deck that reflects your preferred playstyle and tactics.", ratingText: "5.0", logo: "clashRoyaleLogo", bannerImage: "clashRoyaleBanner", ratingImage: "fiveRating", screenshot1: "clashRoyale1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Plants vs. Zombies 2", price: "IDR 55.000", minimumAge: "10+", size: "170 MB", category: "Strategy", description: "It's About Time takes the wildly popular tower defense gameplay of the original game and catapults it into new dimensions and eras. In this highly anticipated sequel, Crazy Dave, your lovable yet eccentric neighbor, is at it again – this time, he's equipped with a time-traveling hot tub. Your mission? Defend your brain across different historical epochs from the zombie onslaught using an arsenal of quirky plants armed with unique abilities.", ratingText: "4.0", logo: "pvz2Logo", bannerImage: "pvz2Banner", ratingImage: "fourRating", screenshot1: "pvz21", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Rise of Kingdoms", price: "IDR 37.000", minimumAge: "12+", size: "1.56 GB", category: "Strategy", description: "Rise of Kingdoms is not merely a game of conquest; it's a test of leadership, resource management, and tactical brilliance. Train armies, research technologies, and unlock the secrets of advanced military tactics to lead your civilization to greatness. One of the game's defining features is the real-time strategy combat system, where you command armies in thrilling battles that unfold on your screen.", ratingText: "3.0", logo: "riseKingdomLogo", bannerImage: "riseKingdomBanner", ratingImage: "threeRating", screenshot1: "riseKingdom1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Hearthstone", price: "IDR 24.000", minimumAge: "12+", size: "534 MB", category: "Strategy", description: "In Hearthstone, players step into the shoes of powerful heroes representing the various classes of Azeroth, each with a unique set of cards and abilities. Assemble your deck with cunning strategy, summon legendary creatures, and cast powerful spells to outsmart your opponents in turn-based battles. The game boasts a rich and vibrant visual design that brings the iconic Warcraft characters and locales to life.", ratingText: "4.0", logo: "hearthstoneLogo", bannerImage: "hearthstoneBanner", ratingImage: "fourRating", screenshot1: "hearthstone1", screenshot2: "", screenshot3: ""),
            GameInfo(name: "Civilization VI", price: "IDR 58.000", minimumAge: "12+", size: "4.13 GB", category: "Strategy", description: "Civilization VI brings the beloved PC strategy game to mobile devices, allowing players to build and lead their own civilization from ancient times to the modern era. With complex systems for diplomacy, technology, culture, and warfare, Civilization VI offers a deep and immersive 4X strategy experience. The game challenges players to make strategic decisions, interact with historical leaders, and shape the course of their civilization's history on a global scale.", ratingText: "5.0", logo: "civilizationLogo", bannerImage: "civilizationBanner", ratingImage: "fiveRating", screenshot1: "civilization1", screenshot2: "", screenshot3: ""),
            GameInfo(
                name: "Two Dots",
                price: "IDR 13.000",
                minimumAge: "4+",
                size: "50.3 MB",
                category: "Puzzle",
                description: "In Two Dots, players traverse through a world of visually striking environments, each punctuated by delightful animations and a soothing soundtrack. The game's premise is simple yet deceptively challenging — connect dots of the same color vertically and horizontally to clear them from the grid. As you progress through the levels, the complexity of the puzzles increases, introducing new elements such as anchors, fire, and ice, adding layers of strategy to your gameplay.",
                ratingText: "3.0",
                logo: "twoDotsLogo",
                bannerImage: "twoDotsBanner",
                ratingImage: "threeRating",
                screenshot1: "twoDots1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Threes!",
                price: "IDR 43.000",
                minimumAge: "4+",
                size: "98 MB",
                category: "Puzzle",
                description: "More than just a puzzle game; it's a delightful and intellectually stimulating experience that rewards both casual and dedicated players. Its intuitive controls, combined with a deceptively simple premise, make it accessible to players of all ages. Whether you're a puzzle enthusiast or a casual gamer looking for a thought-provoking yet relaxing experience, Threes! stands as a testament to the power of elegant design and engaging gameplay on the mobile platform.",
                ratingText: "3.0",
                logo: "thressLogo",
                bannerImage: "thressBanner",
                ratingImage: "threeRating",
                screenshot1: "thress1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Brain It On!",
                price: "IDR 53.000",
                minimumAge: "4+",
                size: "43 MB",
                category: "Puzzle",
                description: "The game introduces players to a visually minimalist yet intellectually stimulating environment where each level presents a unique conundrum. Your objective? Solve puzzles by drawing shapes and structures that interact with the game's physics engine in creative and unexpected ways. It's a delightful blend of ingenuity and experimentation as you draw, tweak, and iterate your way through increasingly complex and imaginative puzzles.",
                ratingText: "4.0",
                logo: "brainItOnLogo",
                bannerImage: "brainItOnBanner",
                ratingImage: "fourRating",
                screenshot1: "brainItOn1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Flow Free",
                price: "IDR 13.000",
                minimumAge: "4+",
                size: "50.3 MB",
                category: "Puzzle",
                description: "Flow Free introduces players to a grid-based puzzle world where the objective is to connect matching colored dots without crossing or overlapping the paths. The game starts with a straightforward concept that progressively evolves into a complex mosaic of interconnected lines, requiring strategic thinking and spatial reasoning.",
                ratingText: "3.0",
                logo: "flowFreeLogo",
                bannerImage: "flowFreeBanner",
                ratingImage: "threeRating",
                screenshot1: "flowFree1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Candy Crush Saga",
                price: "IDR 52.000",
                minimumAge: "4+",
                size: "322 MB",
                category: "Puzzle",
                description: "Candy Crush Saga is a wildly popular match-three puzzle game that has captivated millions of players worldwide. Swap colorful candies to create matches and achieve objectives across a variety of levels. With its easy-to-learn gameplay, vibrant graphics, and social features, Candy Crush Saga offers a sweet and addictive puzzle experience suitable for players of all ages.",
                ratingText: "5.0",
                logo: "candyCrushLogo",
                bannerImage: "candyCrushBanner",
                ratingImage: "fiveRating",
                screenshot1: "candyCrush1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Asphalt 9: Legends",
                price: "IDR 41.000",
                minimumAge: "10+",
                size: "3.2 GB",
                category: "Racing",
                description: "Asphalt 9: Legends sets the standard for mobile arcade racing with its breathtaking visuals and high-speed gameplay. This free-to-play title offers an extensive roster of real hypercars, including Ferrari, Porsche, and Lamborghini. Engage in intense, multiplayer races or embark on a thrilling Career mode where you can unlock and upgrade your dream cars. The game's stunning graphics and easy-to-learn controls make it a must-play for racing enthusiasts seeking an adrenaline-packed experience on their mobile devices.",
                ratingText: "4.0",
                logo: "asphaltLogo",
                bannerImage: "asphaltBanner",
                ratingImage: "fourRating",
                screenshot1: "asphalt1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Real Racing 3",
                price: "IDR 81.000",
                minimumAge: "4+",
                size: "743 MB",
                category: "Racing",
                description: "Real Racing 3 is a top-tier racing simulation that brings realism to the mobile platform. Featuring an extensive selection of licensed cars and real tracks, the game immerses players in a dynamic racing experience. Its free-to-play model offers a comprehensive career mode, real-time multiplayer races, and visually stunning graphics. Real Racing 3 continues to be a benchmark for mobile racing games, combining authenticity with accessible gameplay.",
                ratingText: "5.0",
                logo: "realRacingLogo",
                bannerImage: "realRacingBanner",
                ratingImage: "fiveRating",
                screenshot1: "realRacing1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "CSR Racing 2",
                price: "IDR 32.000",
                minimumAge: "4+",
                size: "3.42 GB",
                category: "Racing",
                description: "CSR Racing 2 is a drag racing game that excels in both visual fidelity and gameplay depth. The game focuses on the customization and upgrading of high-end cars, offering a wide array of options for players to enhance their vehicles. With its stunning graphics and competitive multiplayer races, CSR Racing 2 delivers an immersive experience.",
                ratingText: "3.0",
                logo: "csrLogo",
                bannerImage: "csrBanner",
                ratingImage: "threeRating",
                screenshot1: "csr1",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "F1 Mobile Racing",
                price: "IDR 132.000",
                minimumAge: "4+",
                size: "1.42 GB",
                category: "Racing",
                description: "F1 Mobile Racing brings the excitement of Formula 1 to the palm of your hand. Featuring official teams, drivers, and circuits, this game lets you dive into the world of high-stakes, precision racing. Compete in time trials, engage in multiplayer races, and participate in official F1 Esports events. With its realistic graphics and immersive gameplay, F1 Mobile Racing offers a genuine Formula 1 experience for mobile gamers with a passion for the pinnacle of motorsports.",
                ratingText: "5.0",
                logo: "f1Logo",
                bannerImage: "f1Banner",
                ratingImage: "fiveRating",
                screenshot1: "f11",
                screenshot2: "",
                screenshot3: ""
            ),

            GameInfo(
                name: "Mario Kart Tour",
                price: "IDR 68.000",
                minimumAge: "4+",
                size: "198 MB",
                category: "Racing",
                description: "Mario Kart Tour brings the beloved Mario Kart series to mobile devices, allowing players to race with their favorite Mario characters in a variety of iconic courses. The game features intuitive controls, a plethora of characters and karts to unlock, and challenging courses that will test your racing skills. Whether competing against friends or racing against players worldwide, Mario Kart Tour captures the fun and excitement of the classic series in a mobile-friendly format.",
                ratingText: "3.0",
                logo: "marioLogo",
                bannerImage: "marioBanner",
                ratingImage: "threeRating",
                screenshot1: "mario1",
                screenshot2: "",
                screenshot3: ""
            ),
            
            GameInfo(
                name: "Call of Duty: Mobile",
                price: "IDR 93.400",
                minimumAge: "17+",
                size: "1.6 GB",
                category: "Action",
                description: "No one can resist the allure of Call of Duty®: Mobile’s Season 11: Siren Song! Dive into the holiday-themed Miami Blitz MP map for some yuletide mayhem! Hit the high notes with the Mythic Siren – Siren Song and her Legendary BK57 - Spectral Song or be destroyed by the Epic Foxtrot - Unseen Angel and her Mythic Grau 5.56 - Phantom's Core! Two Mythic Draws appear in one season for the first time ever! Stay off the naughty list or get sleighed by the Epic Lerch",
                ratingText: "5.0",
                logo: "codmLogo",
                bannerImage: "codmBanner",
                ratingImage: "fiveRating",
                screenshot1: "codm1",
                screenshot2: "",
                screenshot3: ""
            ),
            
            GameInfo(
                name: "Dead Trigger 2",
                price: "IDR 53.000",
                minimumAge: "16+",
                size: "978 MB",
                category: "Action",
                description: "Get ready for the ultimate zombie game. It is time for you to rise up and fight for your survival in a zombie apocalypse in this heart-stopping First Person Shooter (FPS) adventure! Build your personal Hideout and meet the Gunsmith, Scientist, Smuggler, Medic, and Engineer. It's not only an fps shooter, but it's also game for months. Unlock 10 regions and plan a strategy for 33 different battlefields. Save the world against zombies! Over 600 gameplay war scenarios and intensive storytelling campaigns. More than in any zombie game!",
                ratingText: "3.0",
                logo: "deadTriggerLogo",
                bannerImage: "deadTriggerBanner",
                ratingImage: "threeRating",
                screenshot1: "deadTrigger1",
                screenshot2: "",
                screenshot3: ""
            ),
            
            GameInfo(
                name: "Garena Free Fire",
                price: "IDR 78.000",
                minimumAge: "12+",
                size: "405 MB",
                category: "Action",
                description: "Free Fire is a world-famous survival shooter game available on mobile. Each 10-minute game places you on a remote island where you are pit against 49 other players, all seeking survival. Players freely choose their starting point with their parachute, and aim to stay in the safe zone for as long as possible. Drive vehicles to explore the vast map, hide in the wild, or become invisible by proning under grass or rifts. Ambush, snipe, survive, there is only one goal: to survive and answer the call of duty.",
                ratingText: "4.0",
                logo: "freeFireLogo",
                bannerImage: "freeFireBanner",
                ratingImage: "fourRating",
                screenshot1: "freeFire1",
                screenshot2: "",
                screenshot3: ""
            ),
            
            GameInfo(
                name: "FR Legends",
                price: "IDR 101.000",
                minimumAge: "7+",
                size: "405 MB",
                category: "Racing",
                description: "FR LEGENDS is all about drifting! From driving legendary FR (front-engine, rear-wheel-drive) drift cars at world’s most iconic circuits, to customize everything on your car including engine swaps and wide-body kits. For the first time ever, a mobile game that lets you have tandem drift battles with AI drivers, unique scoring systems based on real world competition judging rules.",
                ratingText: "5.0",
                logo: "frLogo",
                bannerImage: "frBanner",
                ratingImage: "fiveRating",
                screenshot1: "fr1",
                screenshot2: "",
                screenshot3: ""
            )
        ]

        for gameData in games {
            let newGame = GameDatas(context: context)
            newGame.name = gameData.name
            newGame.price = gameData.price
            newGame.minimumAge = gameData.minimumAge
            newGame.size = gameData.size
            newGame.category = gameData.category
            newGame.gameDescription = gameData.description
            newGame.ratingText = gameData.ratingText
            newGame.logo = gameData.logo
            newGame.bannerImage = gameData.bannerImage
            newGame.ratingImage = gameData.ratingImage
            newGame.screenshot1 = gameData.screenshot1
            newGame.screenshot2 = gameData.screenshot2
            newGame.screenshot3 = gameData.screenshot3
        }

        do {
            try context.save()
            print("Games saved to Core Data successfully!")
        } catch {
            print("Error saving games to Core Data: \(error)")
        }
    }
}
