Given /^GIT repository "([^"]*)"/ do |repo|
  pending "Implement me."
end

Given /^integration name "([^"]*)"/ do |name|
  pending "Implement me."
end

When /^it is cloned$/ do
  pending "Implement me too"
end

Then /^there should be files in the "([^"]*)" folder/ do |name|
  Dir.exists?(Digest::SHA1(name).hexdigest)
end

Then /^it should contain a GIT repository$/ do
  pending
end
