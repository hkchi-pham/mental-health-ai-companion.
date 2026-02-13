#!/bin/bash

echo "🧹 Cleaning .env from git history..."

git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .env" \
  --prune-empty --tag-name-filter cat -- --all

echo "✅ .env removed from history."
echo "💡 Now try pushing again:"
echo "   git push --force origin --all"
