#!/bin/bash
set -e

# Gemのインストール
bundle install

# データベースのマイグレーション
rails db:migrate RAILS_ENV=production

# アセットのプリコンパイル
rails assets:precompile
