# frozen_string_literal: true

survey_1 = Survey.create(title: 'Survey 1')
survey_2 = Survey.create(title: 'Survey 2')

# SURVEY_1
question_1 = Question.create(survey: survey_1, title: 'What is your feeling today?', type: 0)
question_2 = Question.create(survey: survey_1, title: 'What is your favorite color?', type: 1)

option_1 = Option.create(question: question_2, title: 'Red')
option_2 = Option.create(question: question_2, title: 'Blue')
option_3 = Option.create(question: question_2, title: 'Green')

feedback_by_furkan = Feedback.create(survey: survey_1)

response_for_question_1 = Response.create(question: question_1, feedback: feedback_by_furkan, body: 'I am feeling good today')
response_for_question_2 = Response.create(question: question_2, feedback: feedback_by_furkan, option: option_2)


# SURVEY_2
question_3 = Question.create(survey: survey_2, title: 'How was your day?', type: 0)
question_4 = Question.create(survey: survey_2, title: 'What is your favorite team?', type: 1)

option_5 = Option.create(question: question_4, title: 'Arsenal')
option_6 = Option.create(question: question_4, title: 'Manchester United')
option_7 = Option.create(question: question_4, title: 'Liverpool')

feedback_by_emre = Feedback.create(survey: survey_2)

response_for_question_3 = Response.create(question: question_3, feedback: feedback_by_emre, body: 'I was very happy today')
response_for_question_4 = Response.create(question: question_4, feedback: feedback_by_emre, option: option_5)