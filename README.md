# Fresh Debian Scripts

Setup scripts for a fresh Debian Testing (Unstable/Sid) environment.

## Repository
[fresh-debian-scripts-local-development](https://github.com/razodin137/fresh-debian-scripts-local-development)

## Scripts

### 1. [01_setup_debian_testing.sh](./01_setup_debian_testing.sh)
- Configuration for Debian Unstable/Testing.
- Updates `sources.list`.

##### Check [Shopping List](./shopping-list.md)

Shopping list has some helpful utilities that you'll probably need when setting the rest of this up. 

### 2. [02_setup_repos.sh](./02_setup_repos.sh)
- Installs prerequisites (`curl`, `git`, `gpg`).
- Adds **Antigravity** and **GitHub CLI** repositories.


### 3. nano ~/.bashrc [gnew-aliases](./gnew-aliases.md) 


Copy-paste those gnew-alises to get some nice commands for Github creation..

### 4. Disable [Middle Click](./disable_middle_click.sh) (Only run if on a laptop) on a l


Linux laptops have a rough time with middle click. Getting rid of it is preferrable. 

## How to use
```bash
git clone https://github.com/razodin137/fresh-debian-scripts-local-development.git
cd fresh-debian-scripts-local-development
sudo ./01_setup_debian_testing.sh
sudo ./02_git_plus_antigrav.sh.
sudo .disable_middle_click.sh (ONLY RUN ON LAPTOPS)
```
