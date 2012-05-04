class Magic8Ball
  def initialize
    @answers = loadAnswers
  end
  
  def loadAnswers
    answerFile = NSBundle.mainBundle.pathForResource('answers', ofType:'json')
    
    errorPointer = Pointer.new(:object)
    
    data = NSData.alloc.initWithContentsOfFile(answerFile, options:NSDataReadingUncached, error:errorPointer)
    
    unless data
      printError errorPointer[0]
      return defaultAnswers
    end
    
    json = NSJSONSerialization.JSONObjectWithData(data, options:NSDataReadingUncached, error:errorPointer)
    
    unless json
      printError errorPointer[0]
      return defaultAnswers
    end
    
    json['answers']
  end
  
  def printError(error)
    $stderr.puts "Error: #{error.description}"
  end
  
  def randomAnswer
    @answers.sample
  end
  
  def defaultAnswers
    ['Yes', 'No', 'Maybe', 'Try Again']
  end
end