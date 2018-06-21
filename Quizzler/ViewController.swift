
import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0
        
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    let rand = Int(arc4random_uniform(UInt32(QuestionBank.init().list.count)))
    let firstQuestion = allQuestions.list[rand]
    questionLabel.text = firstQuestion.questionText
        
    }
    
    
    @available(iOS 10.0, *)
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }else {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber = questionNumber+1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
        
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(QuestionBank.init().list.count+1) ) * CGFloat(questionNumber + 1)
        
    }
    
    
    func nextQuestion() {
        
            let rand = Int(arc4random_uniform(UInt32(QuestionBank.init().list.count)))
            let firstQuestion = allQuestions.list[rand]
            questionLabel.text = firstQuestion.questionText
        
    }
    
    
    @available(iOS 10.0, *)
    func checkAnswer() {
        let realAnswer = allQuestions.list[questionNumber].answer
        
        if realAnswer == pickedAnswer {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            ProgressHUD.showSuccess("Awesome")
            score += 10
            updateUI()
        } else {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            ProgressHUD.showError("Try again")
            
            score = score - 10
            
            updateUI()
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            sleep(1)
        }
        
    }
    
    
    func startOver() {
        
        score = 0
        questionNumber = 0
        nextQuestion()
        
    }
    
    
    
}

