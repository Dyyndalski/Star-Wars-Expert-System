
;;; ***************************
;;; * STAR WARS EXPERT SYSTEM *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""
  =>
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))
;===========================================================
(defrule determine-why-travelling ""

   (logical (start))

   =>

   (assert (UI-state (display WhyYouTravelling)
                     (relation-asserted why-you-travel)
                     (response WantTeleport)
                     (valid-answers WantTeleport Vacation))))
   
   
;============================================================ 
(defrule vacation ""

   (logical (why-you-travel Vacation))

   =>

   (assert (UI-state (display BreakFromQuestion)
                     (relation-asserted breaks-from)
                     (response Cantina)
                     (valid-answers Cantina TheCity Work))))
;============================================================
(defrule want-teleport ""
   
   (logical (why-you-travel WantTeleport))
   
   =>

   (assert (UI-state (display TravelFarQuestions)
                     (relation-asserted travel-far)
                     (response Yes)
                     (valid-answers Yes No))))
;============================================================
(defrule no-go-far ""

   (logical (travel-far No))

   =>

   (assert (UI-state (display NoWantTotravelFarMessage)
                     (relation-asserted travel-far)
                     (response Back)
                     (valid-answers))))                 
;============================================================
(defrule midi-chlorian-question ""

   (logical (travel-far Yes))

   =>

   (assert (UI-state (display MidiChlorianQuestions)
                     (relation-asserted midi-chlorian)
                     (response OffTheCharts)
                     (valid-answers OffTheCharts NoMysticalEnergy wtfIsIt))))
;============================================================
(defrule off-the-charts-message ""

   (logical (midi-chlorian OffTheCharts))

   =>

   (assert (UI-state (display OffTheChartsMessage)
                     (relation-asserted midi-chlorian)
                     (response OffTheCharts)
                     (valid-answers))))               
;============================================================
(defrule off-the-charts-answer ""

   (logical (midi-chlorian OffTheCharts))

   =>

   (assert (UI-state (display SearchingOrHidingQuestion)
                     (relation-asserted hiding-or-searching)
                     (response Hiding)
                     (valid-answers Hiding Searching))))           
;============================================================
(defrule hiding-or-searching-searching-answer ""

   (logical (hiding-or-searching Searching))

   =>

   (assert (UI-state (display SearchingOrScavengingQuestion)
                     (relation-asserted searching-or-scaving)
                     (response Scavenging)
                     (valid-answers Scavenging Searching))))              
;============================================================
(defrule from-what-question ""

   (logical (hiding-or-searching Hiding))

   =>

   (assert (UI-state (display FromWhatQuestion)
                     (relation-asserted from-what)
                     (response DontWorry)
                     (valid-answers DontWorry JarJarBinks WormRiddenFilth ThePast))))        
;============================================================
(defrule fromWhat-WormRiddenFilth-answer ""

   (logical (from-what WormRiddenFilth))
   
   =>

   (assert (UI-state (display WormriddenFilthMessage)
                     (relation-asserted from-what)
                     (response WormRiddenFilth)
                     (valid-answers ))))             
;============================================================
(defrule fromWhat-ThePast-answer ""

   (logical (from-what ThePast))

   =>

   (assert (UI-state (display WhatHappenedQuestion)
                     (relation-asserted what-happened)
                     (response Order66)
                     (valid-answers Order66 CharredRemaind))))                      
;============================================================
(defrule what-happened-CharredRemaind-answer ""

   (logical (what-happened CharredRemaind))

   =>

   (assert (UI-state (display FlyAwayQuestion)
                     (relation-asserted fly-away)
                     (response Yes)
                     (valid-answers Yes LivingRemoteDesert))))   
;============================================================
(defrule fly-away-yes-answer ""

   (logical (fly-away Yes))

   =>

   (assert (UI-state (display BeforeYourHouseBurnedQuestion)
                     (relation-asserted favourite-toy)
                     (response ChemistrySet)
                     (valid-answers ChemistrySet RcCar SuperSoaker Magic8Ball Furby))))   
;============================================================
(defrule favourite-toy-Furby-answer ""

   (logical (favourite-toy Furby))
   
   =>

   (assert (UI-state (display GluttionForPainQuestion)
                     (relation-asserted glutton-for-pain)
                     (response Yes)
                     (valid-answers Yes No)))) 
                                    
;============================================================
(defrule glutton-for-pain-yes-answer ""

   (logical (glutton-for-pain Yes))

   =>

   (assert (UI-state (display WhichFateQuestion)
                     (relation-asserted fate)
                     (response BeingFrozen)
                     (valid-answers BeingFrozen BeingSlowly))))            
                               
;============================================================
(defrule fate-being-frozen-answer ""

   (logical (fate BeingFrozen))

   =>

   (assert (UI-state (display ILoveYouQuestion)
                     (relation-asserted fate)
                     (response BeingFrozen)
                     (valid-answers Iknow))))                    
;============================================================
(defrule favourite-toy-magic8ball-answer ""

   (logical (favourite-toy Magic8Ball))

   =>

   (assert (UI-state (display TrueFalseQuestion)
                     (relation-asserted true-false)
                     (response True)
                     (valid-answers True False)))) 
;============================================================
(defrule what-happened-order66-message ""

   (logical (what-happened  Order66))

   =>

   (assert (UI-state (display noVacationMessage)
                     (relation-asserted what-happened)
                     (response Order66)
                     (valid-answers))))    
;============================================================
(defrule fromWhat-JarJarBinks-answer ""

   (logical (from-what JarJarBinks))

   =>

   (assert (UI-state (display JarJarBinksMessage)
                     (relation-asserted from-what)
                     (response JarJarBinks)
                     (valid-answers ))))             
;============================================================
(defrule searching-answer ""

   (logical (searching-or-scaving Searching))
   
   =>

   (assert (UI-state (display SearchingForAdventureQuestion)
                     (relation-asserted for-adventure)
                     (response Yes)
                     (valid-answers Yes AdventureExcitement))))        
;============================================================
(defrule for-adventure-excitement-answer ""

   (logical (for-adventure AdventureExcitement))

   =>

   (assert (UI-state (display AdegenCrystalsQuestion)
                     (relation-asserted now-you-talking)
                     (response NowYouTalking)
                     (valid-answers NowYouTalking))))   
;============================================================
(defrule for-adventure-yes-answer ""

   (logical (for-adventure Yes))

   =>

   (assert (UI-state (display HowLikeBlueMilkQuestion)
                     (relation-asserted warm-vs-cold-blue-milk)
                     (response Warm)
                     (valid-answers Warm Cold))))     
;============================================================
(defrule warm-blue-milk-message ""

   (logical (warm-vs-cold-blue-milk Warm))
   
   =>

   (assert (UI-state (display WarmBlueMilkMessage)
                     (relation-asserted warm-vs-cold-blue-milk)
                     (response Warm)
                     (valid-answers)))) 
;============================================================
(defrule cold-blue-milk-message ""

   (logical (warm-vs-cold-blue-milk Cold))

   =>

   (assert (UI-state (display ColdBlueMilkMessage)
                     (relation-asserted warm-vs-cold-blue-milk)
                     (response Cold)
                     (valid-answers))))             
;============================================================
(defrule no-mystical-energy-answer ""

	(logical (midi-chlorian NoMysticalEnergy))

   	=>

   (assert (UI-state (display YourDestinyQuestion)
                     (relation-asserted what-control-your-destiny)
                     (response Money)
                     (valid-answers Money Adrenaline Love))))

;============================================================                
(defrule my-destiny-money-answer-message ""

	(logical (what-control-your-destiny Money))

   =>

   (assert (UI-state (display MoneyMessage)
                     (relation-asserted what-control-your-destiny)
                     (response Money)
                     (valid-answers))))     
;============================================================                
(defrule my-destiny-money-answer ""

	(logical (what-control-your-destiny Money))

   =>

   (assert (UI-state (display GamblingTypeQuestion)
                     (relation-asserted are-you-gambling)
                     (response YesGambling)
                     (valid-answers YesGambling No))))
;============================================================                
(defrule my-destiny-love-answer ""

	(logical (what-control-your-destiny Love))

   =>

   (assert (UI-state (display RelationShipQuestion)
                     (relation-asserted are-you-in-realtionship)
                     (response NoRelationShip)
                     (valid-answers NoRelationShip IdontKnow Yes))))
;============================================================                
(defrule relationship-no-answer-message ""

	(logical (are-you-in-realtionship NoRelationShip))

   =>

   (assert (UI-state (display RelationshipMessage)
                     (relation-asserted are-you-in-realtionship)
                     (response NoRelationShip)
                     (valid-answers))))
;============================================================                
(defrule relationship-idk-answer-message ""

	(logical (are-you-in-realtionship IdontKnow))

   =>

   (assert (UI-state (display KissYourSiblingQuestion)
                     (relation-asserted kiss-your-sibling)
                     (response Yes)
                     (valid-answers Yes No))))
;============================================================                
(defrule yes-kiss-your-sibling ""

	(logical (kiss-your-sibling Yes))

   =>

   (assert (UI-state (display KissYourSiblingMessage)
                     (relation-asserted kiss-your-sibling)
                     (response Yes)
                     (valid-answers))))
;============================================================                
(defrule relationship-no-answer ""

	(logical (are-you-in-realtionship NoRelationShip))

   =>

   (assert (UI-state (display FinishThePhraseQuestion)
                     (relation-asserted are-you-in-realtionship)
                     (response Suffering)
                     (valid-answers Suffering Revenge))))                 
;============================================================                
(defrule relationship-yes-answer ""

	(logical (are-you-in-realtionship Yes))

   =>

   (assert (UI-state (display LoveOfYourLifeQuestion)
                     (relation-asserted prisoner-love-of-your-life)
                     (response NoBetterThanMe)
                     (valid-answers NoBetterThanMe HoldingThermalDetonator))))            
;============================================================                
(defrule better-them-than-me-answer ""

	(logical (prisoner-love-of-your-life NoBetterThanMe))

   =>

   (assert (UI-state (display ShotFirstQuestion)
                     (relation-asserted who-shot-first)
                     (response Greedo)
                     (valid-answers Greedo Han))))    
;============================================================                
(defrule holding-thermal-detonatior-answer ""

	(logical (prisoner-love-of-your-life HoldingThermalDetonator))

   =>

   (assert (UI-state (display SoundsAdventureQuestion)
                     (relation-asserted you-on-adventure)
                     (response Yes)
                     (valid-answers Yes DaysLongBehindUs))))  
;============================================================                
(defrule greedo-shot-first-answer ""

	(logical (who-shot-first Greedo ))

   =>

   (assert (UI-state (display GreedoMessage)
                     (relation-asserted who-shot-first)
                     (response Han)
                     (valid-answers))))         
;============================================================                
(defrule han-shot-first-answer ""

	(logical (who-shot-first Han ))

   =>

   (assert (UI-state (display WretchedHiveQuestion)
                     (relation-asserted wretched-hive)
                     (response Yes)
                     (valid-answers Yes No))))                                     
;============================================================                
(defrule gambling-no-answer ""

	(logical (are-you-gambling No))

   =>

   (assert (UI-state (display AreYouHoldingQuestion)
                     (relation-asserted are-you-holding)
                     (response No)
                     (valid-answers No WhoAsking))))
;============================================================                
(defrule gambling-yes-answer ""

	(logical (are-you-holding WhoAsking))

   =>

   (assert (UI-state (display RethinkLifeChoicesQuestion)
                     (relation-asserted beware-anger)
                     (response YourJediMindTricks)
                     (valid-answers YourJediMindTricks HelpObiWanKenobi))))
;============================================================
(defrule vacation-cantina ""

   (logical (breaks-from Cantina))

   =>

   (assert (UI-state (display SelfDestructiveQuestion)
                     (relation-asserted self-descructive)
                     (response Yes)
                     (valid-answers Yes No))))
;============================================================
(defrule the-city ""

   (logical (breaks-from TheCity))

   =>

   (assert (UI-state (display CommuneWithNatureQuestion)
                     (relation-asserted commune-with-nature)
                     (response Yes)
                     (valid-answers Yes NotSleepingOutside))))
;============================================================
(defrule workLine ""

   (logical (breaks-from Work))

   =>

   (assert (UI-state (display LineOfWorkQuestion)
                     (relation-asserted line-of-work)
                     (response Business)
                     (valid-answers Business CreativeField Retail))))
;============================================================
(defrule retail-line""

   (logical (line-of-work CreativeField))
   =>

   (assert (UI-state (display WhatMoreInspiredQuestion)
                     (relation-asserted more-inspirated-by)
                     (response GreatArtist)
                     (valid-answers GreatArtist Posters))))
;============================================================
(defrule inspirated-by ""

   (logical (more-inspirated-by GreatArtist))

   =>

   (assert (UI-state (display WhosePaintingQuestion)
                     (relation-asserted whose-painting-on-wall)
                     (response Escher)
                     (valid-answers Escher Hokusai))))
;============================================================
(defrule motto-question ""

   (logical (more-inspirated-by Posters))

   =>

   (assert (UI-state (display WhichMottoQuestion)
                     (relation-asserted which-motoo)
                     (response BiggerFish)
                     (valid-answers BiggerFish HokeyReligions LiveLongProsper))))
;============================================================
(defrule rather-blast-question ""

   (logical (which-motoo HokeyReligions))

   =>

   (assert (UI-state (display WhatRatherBlastQuestion)
                     (relation-asserted rather-blast)
                     (response Dug)
                     (valid-answers Dug Wampa WompRats))))
;============================================================
(defrule line-retail ""

   (logical (line-of-work Retail))

   =>

   (assert (UI-state (display WhatTheOneThingQuestion)
                     (relation-asserted travel-without)
                     (response GoPro)
                     (valid-answers GoPro HologramPhone Camera GoodBook))))
;============================================================
(defrule travel-without-thing ""

   (logical (travel-without GoodBook))

   =>

   (assert (UI-state (display WhatGenreQuestion)
                     (relation-asserted book-genre)
                     (response NonFiction)
                     (valid-answers NonFiction Fantasy))))
;============================================================
(defrule line-business ""

   (logical (line-of-work Business))

   =>

   (assert (UI-state (display NeverDoBusinessQuestion)
                     (relation-asserted never-do-business-with)
                     (response Alderaan)
                     (valid-answers Alderaan TalkingSquid DugsOrToydarians))))
;============================================================
(defrule business ""

   (logical (never-do-business-with Alderaan))

   =>

   (assert (UI-state (display AlderaanMessage)
                     (relation-asserted never-do-business-with)
                     (response Alderaan)
                     (valid-answers))))
;============================================================
(defrule descructive ""

   (logical (self-descructive Yes))

   =>

   (assert (UI-state (display MentallyOrPhysicallyQuestion)
                     (relation-asserted mentally-physically)
                     (response Mentally)
                     (valid-answers Mentally Physically))))
;============================================================
(defrule beware-anger-answer ""

   (logical (mentally-physically Mentally))

   =>

   (assert (UI-state (display BewareAngerQuestion)
                     (relation-asserted beware-anger)
                     (response HelpObiWanKenobi)
                     (valid-answers HelpObiWanKenobi DarkSide))))
;============================================================
(defrule help-obi-wan-kenobi-answer ""

   (logical (beware-anger HelpObiWanKenobi))

   =>

   (assert (UI-state (display ClearYourMindQuestion)
                     (relation-asserted unwind-mind)
                     (response OilBath)
                     (valid-answers OilBath BraidMyHair Sports ListenMusic))))
;============================================================
(defrule listen-to-music-answer ""

   (logical (unwind-mind ListenMusic))

   =>

   (assert (UI-state (display WhatTypeOfMusicQuestion)
                     (relation-asserted type-of-music)
                     (response Rock)
                     (valid-answers Rock Pop Instrumental))))
;============================================================
(defrule sports-answer ""

   (logical (unwind-mind Sports))

   =>

   (assert (UI-state (display PlayOrWatchQuestion)
                     (relation-asserted play-vs-watch)
                     (response WatchSport)
                     (valid-answers WatchSport PlaySport))))
;============================================================
(defrule play-watch-sport-answer ""
	(or
	   	(logical (play-vs-watch PlaySport))
		(logical (are-you-gambling YesGambling))
	)
   =>

   (assert (UI-state (display RacersTypeQuestion)
                     (relation-asserted podracers-vs-lavaracers)
                     (response Podracers)
                     (valid-answers Podracers Lavaracers))))
;============================================================
(defrule instrumental-type-of-music ""

   (logical (type-of-music Instrumental))

   =>

   (assert (UI-state (display JohnWilliamsVsQuestion)
                     (relation-asserted john-vs-danny)
                     (response JohnWilliams)
                     (valid-answers JohnWilliams DannyElfman))))
;============================================================
(defrule no-descructive ""
   (logical (self-descructive No))

   =>

   (assert (UI-state (display AreYouSocialQuestion)
                     (relation-asserted social-answer)
                     (response Yes)
                     (valid-answers Yes No PreferAnimals)))) 
;============================================================
(defrule death-wish-question ""

	(or
   		(logical (mentally-physically Physically))
		(logical (what-control-your-destiny Adrenaline))
	)
	
   =>

   (assert (UI-state (display DeathWishQuestion)
                     (relation-asserted death-wish)
                     (response Yes)
                     (valid-answers Yes No))))
;============================================================
(defrule drink-no-answer ""

	(or
		(logical (are-you-holding No))
	   	(logical (death-wish No))
	)

   =>

   (assert (UI-state (display DrinkQuestion)
                     (relation-asserted drink)
                     (response Yes)
                     (valid-answers Yes blueMilkCount))))
;============================================================
(defrule drink-yes-answer ""

   (logical (drink Yes))

   =>

   (assert (UI-state (display WhereYouDrinkQuestion)
                     (relation-asserted where-you-drink)
                     (response Clubs)
                     (valid-answers Clubs Bars))))             
;============================================================
(defrule drink-in-bars ""

   (logical (where-you-drink Bars))

   =>

   (assert (UI-state (display WhatYourOrderingQuestion)
                     (relation-asserted what-you-ordering)
                     (response KnockbackRum)
                     (valid-answers KnockbackRum MaiTai FireballShots OakyScotch))))
;============================================================
(defrule death-wish-yes-answer ""

   (logical (death-wish Yes))

   =>

   (assert (UI-state (display HowWantToDieQuestion)
                     (relation-asserted type-of-death)
                     (response FieryExplosion)
                     (valid-answers FieryExplosion KnifeFight))))
;============================================================
(defrule physically-answer ""

   (logical (mentally/physically Physically))

   =>

   (assert (UI-state (display DeathWishQuestion)
                     (relation-asserted death-wish)
                     (response Yes)
                     (valid-answers Yes No))))
;============================================================
(defrule prefering-animals ""
   (logical (social-answer PreferAnimals))

   =>

   (assert (UI-state (display ChooseAnimalQuestion)
                     (relation-asserted which-animal)
                     (response Squid)
                     (valid-answers Squid Bear)))) 
;============================================================
(defrule choice-question ""
   (logical (social-answer No))

   =>

   (assert (UI-state (display ByChoiceQuestion)
                     (relation-asserted by-choice)
                     (response No)
                     (valid-answers YesByChoice NoByChoice)))) 
;============================================================
(defrule choice-answer-yes ""
   (logical (by-choice YesByChoice))

   =>

   (assert (UI-state (display WhatColorQuestion)
                     (relation-asserted what-color)
                     (response Blue)
                     (valid-answers Blue Red)))) 
;============================================================
(defrule choice-answer-no ""
   (logical (by-choice NoByChoice))

   =>

   (assert (UI-state (display MostOfMyFriendsMessage)
   (relation-asserted what-color)
                     (response Blue)
                     (valid-answers)))) 
;============================================================
(defrule choice-answer-no ""
   (logical (by-choice No))

   =>

   (assert (UI-state (display MostOfMyFriendsMessage)
   (relation-asserted what-color)
                     (response Blue)
                     (valid-answers))))              
;============================================================
(defrule describe-friend ""
   (or
   		(logical (by-choice NoByChoice))
   		(logical (social-answer Yes))
   	)

   =>

   (assert (UI-state (display DescribeYourFriendQuestion)
  					 (relation-asserted friend)
                     (response Bunch)
                     (valid-answers Bunch Ton Tight)))) 
;============================================================
(defrule friend-ton ""
   (logical (friend Ton))

   =>

   (assert (UI-state (display PickYourPersonQuestion)
  					 (relation-asserted person)
                     (response Glyterrill)
                     (valid-answers Glyterrill DeathSticks Rhyll))))        
;============================================================
(defrule friend-ton ""
   (logical (friend Tight))

   =>

   (assert (UI-state (display SpendYourTimeQuestion)
  					 (relation-asserted spend-time)
                     (response EatSushi)
                     (valid-answers EatSushi LongTalks Playing))))                  

;*****************
;*	  FINAL		 *
;*****************

;==================================================
(defrule mon-cala ""
   (or
   		(logical (spend-time EatSushi))
   		(logical (which-animal Squid))
   		(logical (commune-with-nature NotSleepingOutside))
   		(logical (whose-painting-on-wall Hokusai))
   		(logical (which-motoo BiggerFish))
   		(logical (what-you-ordering MaiTai))
   		(logical (warm-vs-cold-blue-milk Warm))
   		(logical (favourite-toy SuperSoaker))
   )
   
   =>

   (assert (UI-state (display MonCala)
                     (state final))))
;===================================================
(defrule endor ""
	(or
   		(logical (which-animal Bear))
   		(logical (commune-with-nature Yes))
   		(logical (unwind-mind BraidMyHair))
   		(logical (john-vs-danny JohnWilliams))
   		(logical (what-you-ordering OakyScotch))
   		(logical (wretched-hive No))
   		(logical (from-what WormRiddenFilth))
   		
   	)
   	
   =>

   (assert (UI-state (display Endor)
                     (state final))))
;===================================================   
(defrule Malastare ""

   (or
   		(logical (friend Bunch))
   		(logical (person Glyterrill))
   		(logical (rather-blast Dug))
   		(logical (type-of-music Rock))
   		(logical (podracers-vs-lavaracers Podracers))
   		(logical (type-of-death KnifeFight))
   		(logical (are-you-holding YourJediMindTricks))
   		(logical (are-you-in-realtionship Revenge))
   		(logical (wretched-hive Yes))
   		(logical (favourite-toy RcCar))
   )
   
   =>

   (assert (UI-state (display Malastare)
                     (state final))))         
;===================================================   
(defrule path-to-Naboo ""

   (or
	   (logical (drink blueMilkCount))
	   (logical (spend-time LongTalks))
	   (logical (never-do-business-with Alderaan))
	   (logical (book-genre NonFiction))
	   (logical (you-on-adventure DaysLongBehindUs))
	   (logical (kiss-your-sibling No))
   )
   
   =>

   (assert (UI-state (display Naboo)
                     (state final))))
;===================================================
(defrule choice-yes-red ""
  	(or
		(logical (what-color Blue))
		(logical (rather-blast Wampa))
		(logical (warm-vs-cold-blue-milk Cold))
		(logical (favourite-toy ChemistrySet))
		(logical (fate BeingFrozen))
   	)
   =>

   (assert (UI-state (display Ilum)
                     (state final))))
;===================================================
(defrule Jakku ""
	(or
   		(logical (what-color Red))
   		(logical (rather-blast WompRats))
   		(logical (play-vs-watch WatchSport))
   		(logical (what-you-ordering KnockbackRum))
   		(logical (are-you-in-realtionship Suffering))
   		(logical (searching-or-scaving Scavenging))
   		(logical (now-you-talking NowYouTalking))
   		(logical (from-what DontWorry))
   		(logical (from-what JarJarBinks))
   		(logical (fly-away LivingRemoteDesert))
   		
   		(logical (fate BeingSlowly))
   	
   	)
   =>

   (assert (UI-state (display Jakku)
                     (state final))))   
;===================================================
(defrule coruscant ""
	(or
   		(logical (person DeathSticks))
   		(logical (never-do-business-with DugsOrToydarians))
   		(logical (travel-without HologramPhone))
   		(logical (unwind-mind OilBath))
   		(logical (type-of-music Pop))
   		(logical (john-vs-danny DannyElfman))
   		(logical (where-you-drink Clubs))
   		(logical (true-false True))
   		(logical (glutton-for-pain No))
   	)
   =>

   (assert (UI-state (display Coruscant)
                     (state final))))   
;===================================================
(defrule Ryloth ""
   (or
   		(logical (person Rhyll))
   		(logical (spend-time Playing))
   		(logical (travel-without Camera))
   		(logical (book-genre Fantasy))
   		(logical (whose-painting-on-wall Escher))
   		(logical (you-on-adventure Yes))
   		(logical (kiss-your-sibling Yes))
   		(logical (true-false False))
   )
   
   =>

   (assert (UI-state (display Ryloth)
                     (state final))))              
;===================================================
(defrule choice-yes-blue ""
   (or
	   (logical (never-do-business-with TalkingSquid))
	   (logical (travel-without GoPro))
	   (logical (podracers-vs-lavaracers Lavaracers))
	   (logical (type-of-death FieryExplosion))
	   (logical (what-you-ordering FireballShots))
   )
   
   =>

   (assert (UI-state (display Mustafar)
                     (state final))))                                           
;============================================================
(defrule live-long-prosper ""

	(or
	   	(logical (which-motoo LiveLongProsper))
		(logical (midi-chlorian wtfIsIt))
	)
   =>

     (assert (UI-state (display ThisIsNotFlowchartMessage)
                     (state final))))      
;============================================================  
(defrule im-dark-side ""

   (logical (beware-anger DarkSide))

   =>

   (assert (UI-state (display DarkSideMessage)
                     (state final))))  
;============================================================  
(defrule im-dark-side ""

   (logical (what-happened  Order66))

   =>

   (assert (UI-state (display NooooMessage)
                     (state final))))                     
  
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
