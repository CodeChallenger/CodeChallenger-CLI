cc=$(pwd)/codechallenger
cc_dir_path=../codechallenger-cli-tests


fancy_echo(){
	printf "\033[1;%sm%s\033[0m\n" "$1" "$2"
}

test_cmd_pass(){
	yes | $cc "$@" --path=$cc_dir_path
	if [ $? -ne 0 ]; then
		clean_up
		exit 1
	else
		fancy_echo 32 "Pass: $1        [OK]"
	fi
}

test_cmd_fail(){
	yes | $cc "$@" --path=$cc_dir_path
	if [ $? -ne 1 ]; then
		clean_up
		exit 1
	else
		fancy_echo 32 "Fail: $1        [OK]"
	fi
}

clean_up(){
	rm -rf $cc_dir_path
}


# create folder to run tests in
mkdir $cc_dir_path
cd $cc_dir_path

# add file to gitignore
echo ".codechallenger.json" >> .gitignore

# config Git (for Travis)
git config user.email "k.vendrik@gmail.com"
git config user.name "Koen Vendrik"

# run tests
test_cmd_pass init
test_cmd_pass deploy -m "unit test commit" -p --repository "https://github.com/CodeChallenger/CodeChallenger-CLI-test-repo.git"
test_cmd_pass uninit

test_cmd_fail deploy
test_cmd_fail uninit

fancy_echo 32 "
✔ Yeey! You passed all tests!"
clean_up
exit 0