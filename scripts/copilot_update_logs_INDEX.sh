
target_file=logs/INDEX.md
subdir=logs/

copilot -p "create or update $target_file with for all the Mission you can find in @$subdir and summarize the end-result of the human after that mission is.  the $target_file should be made within a markdown table with a link to the existing mission file" \
	--yolo \
	--model gpt-5-mini \
	--share-gist
