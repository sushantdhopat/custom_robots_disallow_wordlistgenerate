echo -e "\e[1;32m "
target=$1
target1=$2

echo -e "\e[1;34m [+] finding robots.txt file from subdomain \e[0m"
httpx -l $1 -paths /robots.txt -silent -o robots-url.txt

echo -e "\e[1;34m [+] finding disallow paths from the robots.txt \e[0m"
for url in $(cat robots-url.txt);do http -b $url | grep 'Disallow' | awk -F ' ' '{print $2}' | cut -c 2- | anew robot-words.txt;done

echo -e "\e[1;34m [+] pasing this file to dirsearch  for the fuzzing \e[0m"
sudo dirsearch -l $target1 -w /home/sushant/robot-words.txt --extensions=EXTENSIONS -o newresult
echo -e "\e[1;34m [+] Finished all recon \e[0m"
