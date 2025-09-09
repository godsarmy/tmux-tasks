#!/usr/bin/env bash

project_output() {
  local projects
  local output
  output=""
  projects="${1:-}"

  for project in $projects; do
    count=$(task count status:pending project:"$project")
    if [[ "$output" == "" ]]; then
      output="$project:$count"
    else
      output="$output,$project:$count"
    fi
  done

  echo "$output"
}

main() {
  local projects
  local output
  output=""
  projects="${1:-}"

  # Make sure task is available.
  if type task >/dev/null 2>&1; then
    if [[ "$projects" == "*" ]]; then
      projects="$(task _projects)"
      output=$(project_output "$projects")
    elif [[ "$projects" != "" ]]; then
      output=$(project_output "$projects")
    fi
  fi

  echo "$output"
}

main "$@"
