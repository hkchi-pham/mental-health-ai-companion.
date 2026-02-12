#!/bin/bash

# Configuration
OLD_EMAIL="anhdh0115@gmail.com" # We will match ALL emails by default in the script logic below if not specified carefully, but let's be aggressive since user said "ALL"
CORRECT_NAME="hkchi-pham"
CORRECT_EMAIL="khanhchi.phamha@gmail.com"

echo "⚠️  WARNING: This script will rewrite the entire Git history."
echo "⚠️  This will change commit hashes and might cause issues for other collaborators."
echo "⚠️  Make sure you have a backup of your repository before proceeding."
echo ""
read -p "Type 'YES' to continue: " confirm

if [ "$confirm" != "YES" ]; then
    echo "❌ Operation cancelled."
    exit 1
fi

# Use git filter-branch to rewrite env details
git filter-branch --env-filter '
    export GIT_COMMITTER_NAME="'"$CORRECT_NAME"'"
    export GIT_COMMITTER_EMAIL="'"$CORRECT_EMAIL"'"
    export GIT_AUTHOR_NAME="'"$CORRECT_NAME"'"
    export GIT_AUTHOR_EMAIL="'"$CORRECT_EMAIL"'"
' --tag-name-filter cat -- --branches --tags

echo ""
echo "✅ History rewritten."
echo "💡 To push the changes (force push required):"
echo "   git push --force origin --all"
echo "   git push --force origin --tags"
