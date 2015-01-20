class Challenger

  def initialize(argvOptions)

    # read a file
    def read_file(file_name)
      file = File.open(file_name, "r")
      data = file.read
      file.close
      return data
    end

    # open frameworks and challengers files
    frameworksInfo = JSON.parse(read_file("data/frameworks.json"))
    challenges = JSON.parse(read_file("data/challenges.json"))

    challengeDetails = {}

    # get language to use
    inputMatch = frameworksInfo.select { |key, value| key.downcase == argvOptions[:language] }
    if inputMatch.keys.size > 0
      challengeDetails["language"] = inputMatch.keys[0]
    else
      challengeDetails["language"] = frameworksInfo.keys[rand(frameworksInfo.keys.size)]
    end

    # get array of frameworks
    frameworks = frameworksInfo[challengeDetails["language"]].keys

    # get framework to use
    inputMatch = frameworks.select { |value| value.downcase == argvOptions[:framework] }
    if inputMatch.size > 0
      challengeDetails["framework"] = inputMatch[0]
    else
      challengeDetails["framework"] = frameworks[rand(frameworks.size)]
    end

    challengeDetails["frameworkDetails"] = frameworksInfo[challengeDetails["language"]][challengeDetails["framework"]]

    # get the challenge
    challengeDetails["challengeDetails"] = challenges.values[rand(challenges.values.size)]

    # save to class
    @challengeDetails = challengeDetails;

  end

  def construct_str()
    challengeDetails = @challengeDetails
    framework = challengeDetails["framework"]
    frameworkDetails = challengeDetails["frameworkDetails"]
    language = challengeDetails["language"]
    challengeDetails = challengeDetails["challengeDetails"]
    return "#{challengeDetails['description']} in #{language} with #{framework}.\n#{frameworkDetails['homepage']}\n#{challengeDetails['homepage']}"
  end

end