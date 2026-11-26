#!/usr/bin/env ruby
# Checks every skill in skills/ for valid front matter, broken links and
# references to skills that don't exist. Run from the repo root:
#   ruby scripts/lint-skills.rb

require "yaml"
require "json"
require "pathname"

ROOT = Pathname.new(__dir__).parent
SKILLS_DIR = ROOT / "skills"
MAX_DESCRIPTION = 400
CATEGORIES = %w[product dev-loop utility].freeze
REQUIRED_METADATA = %w[author version molten-version molten-suite molten-category molten-tier].freeze
SUITE_VERSION_FILE = ROOT / "VERSION"
PLUGIN_MANIFEST = ROOT / ".claude-plugin" / "plugin.json"

errors = []
error = ->(path, msg) { errors << "#{path.relative_path_from(ROOT)}: #{msg}" }

# One suite version, shared by VERSION, the Claude Code plugin and every skill.
# mt-guide compares the installed molten-version with VERSION on main to offer updates.
suite_version = SUITE_VERSION_FILE.exist? ? SUITE_VERSION_FILE.read.strip : nil
unless suite_version&.match?(/\A\d+\.\d+\.\d+\z/)
  error.(SUITE_VERSION_FILE, "must exist and hold a semver like 3.1.0")
  suite_version = nil
end
if PLUGIN_MANIFEST.exist?
  plugin_version = JSON.parse(PLUGIN_MANIFEST.read)["version"] rescue nil
  error.(PLUGIN_MANIFEST, "version '#{plugin_version}' must match VERSION (#{suite_version})") if suite_version && plugin_version != suite_version
else
  error.(PLUGIN_MANIFEST, "is missing")
end

skill_dirs = SKILLS_DIR.children.select(&:directory?).sort
skill_names = skill_dirs.map { |d| d.basename.to_s }
versions = {}

skill_dirs.each do |dir|
  file = dir / "SKILL.md"
  unless file.exist?
    error.(dir, "missing SKILL.md")
    next
  end

  text = file.read
  match = text.match(/\A---\n(.*?)\n---\n/m)
  unless match
    error.(file, "front matter must start the file and be fenced with ---")
    next
  end

  begin
    meta = YAML.safe_load(match[1])
  rescue Psych::Exception => e
    error.(file, "front matter is not valid YAML (#{e.message.lines.first.strip})")
    next
  end
  unless meta.is_a?(Hash)
    error.(file, "front matter must be a YAML mapping")
    next
  end

  name = meta["name"]
  error.(file, "name '#{name}' must match the folder name '#{dir.basename}'") unless name == dir.basename.to_s
  error.(file, "name must look like mt-<name>") unless name.to_s.match?(/\Amt-[a-z0-9-]+\z/)

  desc = meta["description"]
  if !desc.is_a?(String) || desc.strip.empty?
    error.(file, "description is missing")
  elsif desc.length > MAX_DESCRIPTION
    error.(file, "description is #{desc.length} characters (max #{MAX_DESCRIPTION})")
  end

  md = meta["metadata"]
  if md.is_a?(Hash)
    missing = REQUIRED_METADATA.reject { |k| md[k].to_s.strip != "" }
    error.(file, "metadata is missing: #{missing.join(', ')}") unless missing.empty?
    error.(file, "metadata.version '#{md['version']}' must be a quoted semver string like \"1.2.0\"") unless md["version"].is_a?(String) && md["version"].match?(/\A\d+\.\d+\.\d+\z/)
    error.(file, "metadata.molten-version '#{md['molten-version']}' must match VERSION (#{suite_version})") if suite_version && md["molten-version"] != suite_version
    error.(file, "metadata.molten-category must be one of #{CATEGORIES.join(', ')}") if md["molten-category"] && !CATEGORIES.include?(md["molten-category"])
    versions[name] = md["version"]
  else
    error.(file, "metadata block is missing")
  end
end

# Links, file mentions and skill names in every Markdown file we ship.
docs = SKILLS_DIR.glob("**/*.md") + [ROOT / "README.md"]
docs.each do |file|
  text = file.read
  # Ignore fenced code blocks: they hold templates and examples, not real links.
  prose = text.gsub(/^```.*?^```/m, "")
  skill_dir = file.ascend.find { |p| p.parent == SKILLS_DIR }

  prose.gsub(/`[^`\n]*`/, "").scan(/\]\(([^)\s]+)\)/).flatten.each do |target|
    next if target.match?(%r{\A(https?:|mailto:|#)})
    path = target.split("#").first
    next if path.nil? || path.empty?
    error.(file, "broken link: #{target}") unless (file.dirname / path).exist?
  end

  prose.scan(/`((?:mt-[a-z0-9-]+\/)?references\/[A-Za-z0-9_.\/-]+\.md)`/).flatten.uniq.each do |ref|
    base = ref.start_with?("mt-") ? SKILLS_DIR : (skill_dir || file.dirname)
    error.(file, "mentions missing file: #{ref}") unless (base / ref).exist?
  end

  prose.scan(/(?<![\w\/.-])mt-([a-z][a-z0-9-]*[a-z0-9])(?![\w\/-])/).flatten.uniq.each do |n|
    error.(file, "mentions unknown skill: mt-#{n}") unless skill_names.include?("mt-#{n}")
  end

  # Loop docs live in molten-docs/loop/<slug>/; only an "Older layout" section may name the old folders.
  current = text.gsub(/^### Older layout\n.*?(?=^##? )/m, "")
  current.scan(%r{molten-docs/(?:discovery|prototype|mockup|spec|plan|verify|review|ship|retro)/}).uniq.each do |old|
    error.(file, "uses the pre-v3 doc layout: #{old} (use molten-docs/loop/<slug>/)")
  end
end

# The per-skill version table in CHANGELOG.md must match the front matter.
changelog = ROOT / "CHANGELOG.md"
if changelog.exist?
  table = changelog.read.scan(/^\| (mt-[a-z0-9-]+) \| (\d+\.\d+\.\d+) \|$/).to_h
  versions.each do |name, version|
    if !table.key?(name)
      error.(changelog, "version table is missing #{name}")
    elsif table[name] != version
      error.(changelog, "version table lists #{name} #{table[name]}, but its SKILL.md says #{version}")
    end
  end
  (table.keys - skill_names).each { |n| error.(changelog, "version table lists #{n}, which has no skill folder") }
end

if errors.empty?
  puts "All #{skill_dirs.size} skills pass."
else
  puts errors
  puts "\n#{errors.size} problem(s) found."
  exit 1
end
