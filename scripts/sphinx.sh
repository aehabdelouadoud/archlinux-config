#!/usr/bin/env bash
# sphinx - Encrypted note manager
# Usage: sphinx [init|create|view|list|delete|search] [note-name] [content]

set -euo pipefail

### Configuration
NOTES_DIR="${HOME}/.sphinx"          # Storage directory
GPG_ID="${SPHINX_GPG_ID:-}"          # Use env var or default GPG key
TEXT_EDITOR="${EDITOR:-nano}"        # User's preferred text editor

### Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

### Helpers
die() { echo -e "${RED}Error: ${1}${RESET}" >&2; exit 1; }
validate_gpg() { gpg --list-keys "${GPG_ID}" &>/dev/null || die "GPG key not found: ${GPG_ID}"; }
sanitize_name() { echo "$1" | tr ' ' '_' | tr -cd '[:alnum:]-_'; }  # Basic sanitization

### Commands
cmd_init() {
  mkdir -p "${NOTES_DIR}" || die "Couldn't create ${NOTES_DIR}"
  chmod -R 700 "${NOTES_DIR}"
  
  if [[ -z "${GPG_ID}" ]]; then
    echo -e "${YELLOW}No SPHINX_GPG_ID set. Using default GPG key.${RESET}"
    GPG_ID=$(gpg --list-secret-keys | grep -E "^\s+" | head -n1 | xargs)
  fi
  
  validate_gpg
  echo -e "${GREEN}Sphinx vault initialized in ${NOTES_DIR} (GPG ID: ${GPG_ID})${RESET}"
}

cmd_create() {
  [[ -z "$2" ]] && die "Usage: sphinx create [note-name] [content/text-editor]"
  validate_gpg

  local note_name=$(sanitize_name "$2")
  local note_path="${NOTES_DIR}/${note_name}.gpg"
  
  if [[ -f "${note_path}" ]]; then
    read -p "Note exists. Overwrite? (y/N) " -n 1 -r
    [[ ! $REPLY =~ ^[Yy]$ ]] && exit 1
  fi

  if [[ "$3" == "text-editor" ]]; then
    temp_file=$(mktemp)
    ${TEXT_EDITOR} "${temp_file}"
    gpg --encrypt --armor --recipient "${GPG_ID}" --output "${note_path}" "${temp_file}"
    rm -f "${temp_file}"
  else
    echo "${*:3}" | gpg --encrypt --armor --recipient "${GPG_ID}" --output "${note_path}"
  fi
  
  echo -e "${GREEN}Note '${note_name}' sealed in the vault!${RESET}"
}

cmd_view() {
  [[ -z "$2" ]] && die "Usage: sphinx view [note-name]"
  validate_gpg

  local note_name=$(sanitize_name "$2")
  local note_path="${NOTES_DIR}/${note_name}.gpg"
  [[ -f "${note_path}" ]] || die "Note not found: ${note_name}"
  
  gpg --decrypt "${note_path}" 2>/dev/null || die "Decryption failed"
}

cmd_list() {
  find "${NOTES_DIR}" -type f -name "*.gpg" | sed "s|${NOTES_DIR}/||g; s/\.gpg$//g" | sort
}

cmd_delete() {
  [[ -z "$2" ]] && die "Usage: sphinx delete [note-name]"
  local note_name=$(sanitize_name "$2")
  local note_path="${NOTES_DIR}/${note_name}.gpg"
  
  [[ -f "${note_path}" ]] || die "Note not found: ${note_name}"
  read -p "Destroy note forever? (y/N) " -n 1 -r
  [[ $REPLY =~ ^[Yy]$ ]] && rm -vf "${note_path}"
}

cmd_search() {
  [[ -z "$2" ]] && die "Usage: sphinx search [query]"
  validate_gpg
  
  while IFS= read -r note; do
    if gpg --decrypt "${note}" 2>/dev/null | grep -iq "$2"; then
      echo -e "${BLUE}Match found: $(basename "${note}" .gpg)${RESET}"
    fi
  done < <(find "${NOTES_DIR}" -type f -name "*.gpg")
}

### Main
case "$1" in
  init)    cmd_init "$@" ;;
  create)  cmd_create "$@" ;;
  view)    cmd_view "$@" ;;
  list)    cmd_list "$@" ;;
  delete)  cmd_delete "$@" ;;
  search)  cmd_search "$@" ;;
  *)
    echo -e "${YELLOW}Sphinx - Guardian of Encrypted Notes${RESET}"
    echo "Commands:"
    echo "  init                  Initialize vault"
    echo "  create [name] [text]  Store note (or 'text-editor' to write)"
    echo "  view [name]           Read note"
    echo "  list                  List all notes"
    echo "  delete [name]         Remove note"
    echo "  search [query]        Search note contents"
    exit 1
    ;;
esac

