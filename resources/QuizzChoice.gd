# Quizz based on a single or multiple choice form.
class_name QuizzChoice
extends Quizz

signal choice_type_changed(is_multiple_choice)

const ERROR_NO_VALID_ANSWERS := "No valid answers set for QuizzChoice resource, can't test answers."

export var answer_options := []
export var valid_answers := []
export var is_multiple_choice := true setget set_is_multiple_choice
export var do_shuffle_answers := true


func test_answer(answers: Array) -> AnswerTestResult:
	assert(not valid_answers.empty(), ERROR_NO_VALID_ANSWERS)
	var result := AnswerTestResult.new()
	result.is_correct = answers.size() == valid_answers.size()
	if result.is_correct:
		for answer in answers:
			if not answer in valid_answers:
				result.is_correct = false
				break
	return result


func set_is_multiple_choice(value: bool) -> void:
	is_multiple_choice = value
	emit_signal("choice_type_changed", is_multiple_choice)