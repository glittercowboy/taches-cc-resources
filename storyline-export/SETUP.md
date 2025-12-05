# Setup Instructions

This file contains instructions for creating the GitHub repository and pushing your Storyline project.

## Step 1: Create GitHub Repository

### Option A: Via GitHub Web Interface (Recommended)

1. Go to https://github.com/new
2. Fill in the details:
   - **Repository name:** `storyline`
   - **Description:** `Story-driven development workflow for Claude Code`
   - **Visibility:** Public
   - **Do NOT initialize with README, .gitignore, or license** (we already have these)
3. Click "Create repository"
4. Copy the repository URL (e.g., `https://github.com/prillcode/storyline.git`)

### Option B: Via GitHub CLI (if available)

```bash
gh repo create storyline --public --description "Story-driven development workflow for Claude Code" --source=.
```

## Step 2: Push to GitHub

After creating the repository on GitHub, run these commands:

```bash
cd /home/user/storyline

# Add the remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/storyline.git

# Rename branch to main (if you prefer main over master)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 3: Verify on GitHub

1. Visit your repository: `https://github.com/YOUR_USERNAME/storyline`
2. Verify all files are present
3. Check that README.md displays properly
4. Verify CREDITS.md shows attribution to glittercowboy

## Step 4: Create First Release (Optional)

To create a v1.0.0 release:

```bash
cd /home/user/storyline

# Create and push a tag
git tag -a v1.0.0 -m "Initial release: Story-driven development workflow"
git push origin v1.0.0
```

Then on GitHub:
1. Go to Releases
2. Click "Draft a new release"
3. Select tag `v1.0.0`
4. Title: "v1.0.0 - Initial Release"
5. Description:
   ```markdown
   # Storyline v1.0.0

   Story-driven development workflow for Claude Code.

   ## Features
   - 📝 Epic creation from PRDs
   - 📖 User story generation
   - 🔧 Technical spec creation
   - ⚡ Automated implementation

   ## Installation
   See README.md for installation instructions.

   ## Credits
   Built on taches-cc-resources by glittercowboy.
   ```
6. Click "Publish release"

## Step 5: Test Installation (Optional)

Test that users can install your CLI:

```bash
# In a different directory
cd /tmp
git clone https://github.com/YOUR_USERNAME/storyline.git
cd storyline
./install.sh

# Start new Claude Code session and test
/epic-creator examples/sample-workflow/PRD.md
```

## Step 6: Share Your Project

Once published, you can:
- Share on GitHub Discussions
- Post in Claude Code community
- Link from your cc-resources fork
- Add topics to your repo: `claude-code`, `ai-development`, `story-driven-development`

## Updating the README

After pushing, you may want to update the README with:
- Your actual GitHub URL (replace prillcode with your username)
- Installation command with your repo
- Badges (optional): stars, license, version

---

**You're all set!** 🚀

Your Storyline CLI is ready to ship.
