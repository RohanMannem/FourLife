//
//  HealthyEatingTipsViewController.swift
//  FourLife
//
//  Created by Philip Cheng on 3/20/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class HealthyEatingTipsViewController: UIViewController {
    
    // 100 Healthy Eating Tips (Source: https://www.prevention.com/weight-loss/weight-loss-tips/diet-and-healthy-weight-loss-advice)
    
    let healthyEatingTips : [String] = [
        "Add just one fruit or veggie serving daily. Get comfortable with that, then add an extra serving until you reach 8 to 10 a day.",
        "Eat at least two servings of a fruit or veggie at every meal.",
        "Resolve never to supersize your food portions—unless you want to supersize your clothes.",
        "Make eating purposeful, not mindless. Whenever you put food in your mouth, peel it, unwrap it, plate it, and sit. Engage all of the senses in the pleasure of nourishing your body.",
        "Start eating a big breakfast. It helps you eat fewer total calories throughout the day.",
        "Make sure your plate is half veggies and/or fruit at both lunch and dinner.",
        "Eating out? Halve it, and bag the rest. A typical restaurant entree has 1,000 to 2,000 calories, not even counting the bread, appetizer, beverage, and dessert.",
        "When dining out, make it automatic: Order one dessert to share.",
        "Use a salad plate instead of a dinner plate.",
        "See what you eat. Plate your food instead of eating out of the jar or bag.",
        "Eat the low-cal items on your plate first, then graduate. Start with salads, veggies, and broth soups, and eat meats and starches last. By the time you get to them, you'll be full enough to be content with smaller portions of the high-calorie choices.",
        "Instead of whole milk, switch to 1%. If you drink one 8-oz glass a day, you'll lose 5 lb in a year.",
        "Juice has as many calories, ounce for ounce, as soda. Set a limit of one 8-oz glass of fruit juice a day.",
        "Get calories from foods you chew, not beverages. Have fresh fruit instead of fruit juice.",
        "Keep a food journal. It really works wonders for healthy weight loss.",
        "Follow the Chinese saying: Eat until you are eight-tenths full.",
        "Use mustard instead of mayo. Eat more soup. The noncreamy ones are filling but low-cal.",
        "Cut back on or cut out caloric drinks such as soda, sweet tea, lemonade, etc. People have had weight loss by making just this one change. If you have a 20-oz bottle of Coca-Cola every day, switch to Diet Coke. You should lose 25 lb in a year.",
        "Take your lunch to work.",
        "Sit when you eat.",
        "Dilute juice with water.",
        "Have mostly veggies for lunch.",
        "Eat at home.",
        "Limit alcohol to weekends.",
        "Have a V8 or tomato juice instead of a Diet Coke at 3 pm.",
        "Doctor your veggies to make them delicious: Dribble maple syrup over carrots, and sprinkle chopped nuts on green beans.",
        "Mix three different cans of beans and some diet Italian dressing. Eat this three-bean salad all week.",
        "Don't forget that vegetable soup counts as a vegetable.",
        "Re-discover the sweet potato.",
        "Use prebagged baby spinach everywhere: as 'lettuce' in sandwiches, heated in soups, wilted in hot pasta, and added to salads.",
        "Spend the extra few dollars to buy vegetables that are already washed and cut up.",
        "Really hate veggies? Relax. If you love fruits, eat plenty of them; they are just as healthy (especially colorful ones such as oranges, mangoes, and melons).",
        "Keep seven bags of your favorite frozen vegetables on hand. Mix any combination, microwave, and top with your favorite low-fat dressing. Enjoy 3 to 4 cups a day. Makes a great quick dinner on all healthy weight loss programs.",
        
        "Adopt the Mantra: 'The best portion of high-calorie foods is the smallest one. The best portion of vegetables is the largest one. Period.'",
        "Adopt the Mantra: 'I'll ride the wave. My cravings will disappear after 10 minutes if I turn my attention elsewhere.'",
        "Adopt the Mantra: 'I want to be around to see my grandchildren, so I can forgo a cookie now.'",
        "Adopt the Mantra: 'I am a work in progress.'",
        "Adopt the Mantra: 'It's more stressful to continue being fat than to stop overeating.'",
        
        "Avoid: Skipping meals. Many people on healthy weight loss programs 'diet by day and binge by night.'",
        "Avoid: Don't 'graze' yourself fat. You can easily munch 600 calories of pretzels or cereal without realizing it.",
        "Avoid: Eating pasta like crazy. A serving of pasta is 1 cup, but some people routinely eat 4 cups.",
        "Avoid: Eating supersize bagels of 400 to 500 calories for snacks.",
        "Avoid: Ignoring 'Serving Size' on the Nutrition Facts panel.",
        "Avoid: Snacking on bowls of nuts. Nuts are healthy but dense with calories. Put those bowls away, and use nuts as a garnish instead of a snack.",
        "Avoid: Thinking all energy bars and fruit smoothies are low-cal.",
        
        "What to eat if you don't want to cook: A smoothie made with fat-free milk, frozen fruit, and wheat germ.",
        "What to eat if you don't want to cook: The smallest fast-food burger (with mustard and ketchup, not mayo) and a no-cal diet beverage. Then at home, have an apple or baby carrots.",
        "What to eat if you don't want to cook: A peanut butter sandwich on whole wheat bread with a glass of 1% milk and an apple.",
        "What to eat if you don't want to cook: Precooked chicken strips and microwaved frozen broccoli topped with Parmesan cheese.",
        "What to eat if you don't want to cook: A healthy frozen entree with a salad and a glass of 1% milk.",
        "What to eat if you don't want to cook: Scramble eggs in a nonstick skillet. Pop some asparagus in the microwave, and add whole wheat toast. If your cholesterol levels are normal, you can have seven eggs a week!",
        "What to eat if you don't want to cook: A bag of frozen vegetables heated in the microwave, topped with 2 tablespoons of Parmesan cheese and 2 tablespoons of chopped nuts.",
        "What to eat if you don't want to cook: Prebagged salad topped with canned tuna, grape tomatoes, shredded reduced-fat cheese, and low-cal Italian dressing.",
        "What to eat if you don't want to cook: Keep lean sandwich fixings on hand: whole wheat bread, sliced turkey, reduced-fat cheese, tomatoes, mustard with horseradish.",
        "What to eat if you don't want to cook: Heat up a can of good soup.",
        "What to eat if you don't want to cook: Cereal, fruit, and fat-free milk makes a good meal anytime.",
        "What to eat if you don't want to cook: Try a veggie sandwich from Subway.",
        "What to eat if you don't want to cook: Precut fruit for a salad and add yogurt.",
    
        "Holiday Advice: Don't tell yourself, 'It's okay, it's the holidays.' That opens the door to 6 weeks of splurging.",
        "Holiday Advice:  Remember, EAT before you meet. Have this small meal before you go to any parties: a hardboiled Egg, Apple, and a Thirst quencher (water, seltzer, diet soda, tea).",
        "Holiday Advice: As obvious as it sounds, don't stand near the food at parties. Make the weight loss effort, and you'll find you eat less.",
        "Holiday Advice: At a buffet? Eating a little of everything guarantees high calories. Decide on three or four things, only one of which is high in calories. Save that for last so there's less chance of overeating.",
        "Holiday Advice: For the duration of the holidays, wear your snuggest clothes that don't allow much room for expansion. Wearing sweats is out until January.",
        "Holiday Advice: Give it away! After company leaves, give away leftover food to neighbors, doormen, or delivery people, or take it to work the next day.",
        "Holiday Advice: Walk around the mall three times before you start shopping.",
        "Holiday Advice: Make exercise a nonnegotiable priority.",
        "Holiday Advice: Dance to music with your family in your home. One dietitian reported that when she asks her patients to do this, initially they just smile, but once they've done it, they say it is one of the easiest ways to involve the whole family in exercise.",

        "Once in a while, have a lean, mean salad for lunch or dinner, and save the meal's calories for a full dessert.",
        "Are you the kind of person who does better if you make up your mind to do without sweets and just not have them around? Or are you going to do better if you have a limited amount of sweets every day? One RD reported that most of her clients pick the latter and find they can avoid bingeing after a few days.",
        "If your family thinks they need a very sweet treat every night, try to strike a balance between offering healthy choices but allowing them some 'free will.' Compromise with low-fat ice cream and fruit, or sometimes just fruit with a dollop of whipped cream.",
        "Try 2 weeks without sweets. It's amazing how your cravings vanish.",
        "Eat more fruit. A person who gets enough fruit in his diet doesn't have a raging sweet tooth.",
        "Eat your sweets, just eat them smart! Carve out about 150 calories per day for your favorite sweet. That amounts to about an ounce of chocolate, half a modest slice of cake, or 1/2 cup of regular ice cream.",
        "Try these smart little sweets: sugar-free hot cocoa, frozen red grapes, fudgsicles, sugar-free gum, Nutri-Grain chocolate fudge twists, Tootsie Rolls, and hard candy.",
        "Eat breakfast, lunch, and dinner. The large majority of people who struggle with night eating are those who skip meals or don't eat balanced meals during the day. This is a major setup for overeating at night.",
        "Eat your evening meal in the kitchen or dining room, sitting down at the table.",
        "Drink cold unsweetened raspberry tea. It tastes great and keeps your mouth busy.",
        "Change your nighttime schedule. It will take effort, but it will pay off. You need something that will occupy your mind and hands.",
        "If you're eating at night due to emotions, you need to focus on getting in touch with what's going on and taking care of yourself in a way that really works. Find a nonfood method of coping with your stress.",
        "Put a sign on the kitchen and refrigerator doors: 'Closed after Dinner.'",
        "Brush your teeth right after dinner to remind you of your weight loss goals: No more food.",
        "Eat without engaging in any other simultaneous activity. No reading, watching TV, or sitting at the computer.",
        "Eating late at night won't itself cause weight gain on healthy weight loss programs. It's how many calories—not when you eat them—that counts.",
        "Dietor fat-free isn't always your best bet. Research has found that none of the lycopene or alpha- or beta-carotene that fight cancer and heart disease is absorbed from salads with fat-free dressing. Only slightly more is absorbed with reduced-fat dressing; the most is absorbed with full-fat dressing. But remember, use your dressing in moderate amounts.",
        "Skipping breakfast will leave you tired and craving naughty foods by midmorning. To fill up healthfully and tastefully, try this sweet, fruity breakfast full of antioxidants. In a blender, process 1 c nonfat plain or vanilla yogurt, 1 1/3 c frozen strawberries (no added sugar), 1 peeled kiwi, and 1 peeled banana. Pulse until mixture is milkshake consistency. Makes one 2-cup serving; 348 calories and 1.5 fat grams.",
        "If you're famished by 4 p.m. and have no alternative but an office vending machine, reach for the nuts--. The same goes if your only choices are what's available in the hotel minibar.",
        "Next time you're feeling wiped out in late afternoon, forgo that cup of coffee and reach for a cup of yogurt instead. The combination of protein, carbohydrate, and fat in an 8-ounce serving of low-fat yogurt will give you a sense of fullness and well-being that coffee can't match, as well as some vital nutrients. If you haven't eaten in 3 to 4 hours, your blood glucose levels are probably dropping, so eating a small amount of nutrient-rich food will give your brain and your body a boost.",
        "Making just a few diet changes to your pantry shelves can get you a lot closer to your weight loss goals. Here's what to do: If you use corn and peanut oil, replace it with olive oil. Same goes for breads—go for whole wheat. Trade in those fatty cold cuts like salami and bologna and replace them canned tuna, sliced turkey breast, and lean roast beef. Change from drinking whole milk to fat-free milk or low-fat soy milk. This is hard for a lot of people so try transitioning down to 2 percent and then 1% before you go fat-free.",
        "Nothing's less appetizing than a crisper drawer full of mushy vegetables. Frozen vegetables store much better, plus they may have greater nutritional value than fresh. Food suppliers typically freeze veggies just a few hours after harvest, locking in the nutrients. Fresh veggies, on the other hand, often spend days in the back of a truck before they reach your supermarket.",
        "Worried about the trans-fat content in your peanut butter? Good news: In a test done on Skippy, JIF, Peter Pan, and a supermarket brand, the levels of trans fats per 2-tablespoon serving were far lower than 0.5 gram—low enough that under proposed laws, the brands can legally claim zero trans fats on the label. They also contained only 1 gram more sugar than natural brands—not a significant difference.",
        "Overeating is not the result of exercise. Vigorous exercise won't stimulate you to overeat. It's just the opposite. Exercise at any level helps curb your appetite immediately following the workout.",
        "When you're exercising, you shouldn't wait for thirst to strike before you take a drink. By the time you feel thirsty, you're already dehydrated. Try this: Drink at least 16 ounces of water, sports drinks, or juices two hours before you exercise. Then drink 8 ounces an hour before and another 4 to 8 ounces every 15 to 20 minutes during your workout. Finish with at least 16 ounces after you're done exercising.",
        "Tune in to an audio book while you walk. It'll keep you going longer and looking forward to the next walk—and the next chapter! Check your local library for a great selection. Look for a whodunit; you might walk so far you'll need to take a cab home!",
        "Think yoga's too serene to burn calories? Think again. You can burn 250 to 350 calories during an hour-long class (that's as much as you'd burn from an hour of walking)! Plus, you'll improve muscle strength, flexibility, and endurance.",
        "Drinking too few can hamper your healthy weight loss programs' efforts. That's because dehydration can slow your metabolism by 3%, or about 45 fewer calories burned a day, which in a year could mean weighing 5 pounds more. The key to water isn't how much you drink, it's how frequently you drink it. Small amounts sipped often work better than 8 ounces gulped down at once.",
        "A registered dietitian (RD) can help you find healthy ways to manage your weight loss with food. To find one in your area who consults with private clients call (800) 366-1655.",
        "The best place to drop pounds may be your own house of worship. Researchers set up exercise and healthy weight loss programs in 16 Baltimore churches. More than 500 women participated and after a year the most successful lost an average of 20 lb. Weight loss programs based on faith are so successful because there's a built-in community component that people can feel comfortable with.",
        "Here's another reason to keep level-headed all the time: Pennsylvania State University research has found that women less able to cope with stress--shown by blood pressure and heart rate elevations--ate twice as many fatty snacks as stress-resistant women did, even after the stress stopped (in this case, 25 minutes of periodic jackhammer-level noise and an unsolvable maze).",
        "Sitting at a computer may help you slim down. When researchers at Brown University School of Medicine put 92 people on online healthy weight loss programs for a year, those who received weekly e-mail counseling shed 5 1/2 more pounds than those who got none. Counselors provided weekly feedback on diet and exercise logs, answered questions, and cheered them on. Most major online diet programs offer many of these features."
    ]

    
    // Outlet - Output TextView
    @IBOutlet var healthyEatingTipText: UITextView!
    
    // Action - Generate a Healthy Eating Tip
    @IBAction func healthyEatingTipButtonClick(_ sender: Any) {
        healthyEatingTipText.text =  healthyEatingTips[Int(arc4random()) % healthyEatingTips.count]
    }
    
    /* viewDidLoad */
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /* didReceiveMemoryWarning */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
