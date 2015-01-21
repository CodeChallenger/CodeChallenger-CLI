require 'json'

class Challenger

  def initialize(argvOptions)
    @argvOptions = argvOptions

    # open frameworks and challengers files
    @frameworksInfo = JSON.parse(read_file('data/frameworks.json'))
    @challenges = JSON.parse(read_file('data/challenges.json'))
  end

  def new_challenge()
    challengeDetails = {}

    argvOptions = @argvOptions
    frameworksInfo = @frameworksInfo
    challenges = @challenges

    # get language to use
    inputMatch = frameworksInfo.select { |key, value| key.downcase == argvOptions[:language] }
    if inputMatch.keys.size > 0
      challengeDetails['language'] = inputMatch.keys[0]
    else
      challengeDetails['language'] = frameworksInfo.keys[rand(frameworksInfo.keys.size)]
    end

    # get array of frameworks
    frameworks = frameworksInfo[challengeDetails['language']].keys

    # get framework to use
    inputMatch = frameworks.select { |value| value.downcase == argvOptions[:framework] }
    if inputMatch.size > 0
      challengeDetails['framework'] = { 'name' => inputMatch[0] }
    else
      challengeDetails['framework'] = { 'name' => frameworks[rand(frameworks.size)] }
    end

    challengeDetails['framework']['details'] = frameworksInfo[challengeDetails['language']][challengeDetails['framework']['name']]

    # get the challenge details
    challengeDetails['details'] = challenges.values[rand(challenges.values.size)]

    # save to class
    @challengeDetails = challengeDetails;
  end

  def construct_str()
    if @challengeDetails != nil

      challengeDetails = @challengeDetails
      language = challengeDetails['language']
      framework = challengeDetails['framework']['name']
      frameworkDetails = challengeDetails['framework']['details']
      challengeDetails = challengeDetails['details']
      
      outputStr = "#{challengeDetails['description']} in #{language} with #{framework}."

      frameworkDetails.each do |key, val|
        if val != '' && val != nil
          outputStr += "\n"+val
        end
      end

      return outputStr

    end
  end

  def get_details()
    return @challengeDetails
  end

end