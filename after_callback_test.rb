# frozen_string_literal: true

require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"

  git_source(:github) { |repo| "https://github.com/#{repo}.git" }

  gem "rails", github: "rails/rails", branch: "main"
  gem "sqlite3"
  gem "debug"
end

require "active_record"
require "minitest/autorun"
require "logger"

# This connection will do for database-independent bug reports.
ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
  end

  create_table :comments, force: true do |t|
    t.integer :post_id
  end
end

class Post < ActiveRecord::Base
  has_many :comments, ->() { where("1=1") }, inverse_of: :post
  # Using a scope-less association like this works
  #has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :post, ->() { where("1=1") }
  # Using a scope-less association like this works
  #belongs_to :post
end

class BugTest < Minitest::Test
  def test_association_stuff
    post = Post.create!
    comment = post.comments.create!
    # Explicitly passing the post object works
    # comment = post.comments.create!(post: post)

    assert_equal 1, post.comments.count
    assert_equal 1, Comment.count
    assert_equal post.id, Comment.first.post.id
    assert_equal post.id, comment.post.id
    # Problematic test:
    assert_equal post.object_id, comment.post.object_id
  end
end