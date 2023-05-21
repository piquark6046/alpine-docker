# Set location of Npm installed globally
npm config set prefix /usr/local
curl --proto '=https' --tlsv1.3  https://sh.rustup.rs -sSf | sh -s -- -y

# Clone Git repo
cd /gitcache
RepoName=("AdguardFilters" "List-KR" "easylist" "easylistgermany" "listefr" "easylistdutch" "easylistchina")
RepoURL=("https://github.com/AdguardTeam/AdguardFilters" "https://github.com/List-KR/List-KR" "https://github.com/easylist/easylist" "https://github.com/easylist/easylistgermany" "https://github.com/easylist/listefr" "https://github.com/easylist/easylistdutch" "https://github.com/easylist/easylistchina")
for i in "${RepoURL[@]}"
do
  git clone "$i"
done
cd /
for i in "${RepoName[@]}"
do
  cd /gitcache/"$i"
  git maintenance run --task=commit-graph --task=loose-objects --task=incremental-repack --task=pack-refs --task=gc
done
