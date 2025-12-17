#!/usr/bin/env python3
import re
from pathlib import Path

# Configuration
MAX_SHORT_COMMENT = 50
EXTENSIONS = ['.dart', '.py', '.yaml', '.yml', '.sh']

ROOT = Path(__file__).resolve().parents[1]

def process_dart(text: str) -> str:
    # Remove block comments /* ... */
    text = re.sub(r'/\*.*?\*/', '', text, flags=re.S)
    lines = text.splitlines()
    out_lines = []
    for line in lines:
        if '//' in line:
            idx = line.find('//')
            prefix = line[:idx]
            comment = line[idx+2:]
            if prefix.strip() == '':
                # full-line comment
                if len(comment.strip()) <= MAX_SHORT_COMMENT:
                    out_lines.append('//' + comment)
                else:
                    out_lines.append('')
            else:
                # inline comment
                if len(comment.strip()) <= MAX_SHORT_COMMENT:
                    out_lines.append(prefix + '//' + comment)
                else:
                    out_lines.append(prefix.rstrip())
        else:
            out_lines.append(line)
    return '\n'.join(out_lines) + ('\n' if text.endswith('\n') else '')


def process_hash_comments(text: str) -> str:
    lines = text.splitlines()
    out_lines = []
    for i, line in enumerate(lines):
        stripped = line.lstrip()
        if stripped.startswith('#'):
            comment = stripped[1:]
            if len(comment.strip()) <= MAX_SHORT_COMMENT:
                out_lines.append(line)
            else:
                out_lines.append('')
        else:
            # inline #
            if '#' in line:
                idx = line.find('#')
                prefix = line[:idx]
                comment = line[idx+1:]
                if len(comment.strip()) <= MAX_SHORT_COMMENT:
                    out_lines.append(prefix + '#' + comment)
                else:
                    out_lines.append(prefix.rstrip())
            else:
                out_lines.append(line)
    return '\n'.join(out_lines) + ('\n' if text.endswith('\n') else '')


def should_process(path: Path) -> bool:
    return path.suffix in EXTENSIONS


def process_file(path: Path):
    text = path.read_text(encoding='utf-8')
    original = text
    if path.suffix == '.dart':
        new = process_dart(text)
    elif path.suffix in ['.py', '.sh']:
        # for scripts and python use hash processing and also remove block comments /* */ just in case
        text2 = re.sub(r'/\*.*?\*/', '', text, flags=re.S)
        new = process_hash_comments(text2)
    elif path.suffix in ['.yaml', '.yml']:
        new = process_hash_comments(text)
    else:
        return False

    if new != original:
        # write backup
        bak = path.with_suffix(path.suffix + '.bak')
        bak.write_text(original, encoding='utf-8')
        path.write_text(new, encoding='utf-8')
        print(f'Updated {path}')
        return True
    return False


def main():
    changed = 0
    for p in ROOT.rglob('*'):
        if p.is_file() and should_process(p):
            try:
                if process_file(p):
                    changed += 1
            except Exception as e:
                print(f'Failed to process {p}: {e}')
    print(f'Done. Files changed: {changed}')

if __name__ == '__main__':
    main()
