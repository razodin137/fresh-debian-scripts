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

### 2. [Antigravity Repositories](./antigravity-repos.sh)
- Installs basic prerequisites (`curl`, `git`, `gpg`, `wget`).
- Adds **Antigravity** repository.

### 3. [GitHub CLI](./gh-install.sh)
- Installs **GitHub CLI** (`gh`) and its repository.

### 4. [Dropbox](./drobox_install.sh)
- Installs **Dropbox** Headless CLI.


### 5. [Setup Aliases](./setup_aliases.sh)
Easily add the `gnew`, `gnew-p`, and `gconnect` aliases to your `.bashrc`.

Run the script:
```bash
./setup_aliases.sh
```

**Alternatively**, you can manually copy-paste the aliases from [gnew-aliases.md](./gnew-aliases.md) into your `~/.bashrc`.

### 6. Disable [Middle Click](./disable_middle_click.sh) (Recommended for Laptops)

Linux laptops often have issues with accidental middle clicks. This script disables middle-click emulation and the 3-finger middle click.

## How to use
```bash
git clone https://github.com/razodin137/fresh-debian-scripts-local-development.git
cd fresh-debian-scripts-local-development
./01_setup_debian_testing.sh
./antigravity-repos.sh
./gh-install.sh
./drobox_install.sh
./disable_middle_click.sh (ONLY RUN ON LAPTOPS)

```
