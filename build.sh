#!/bin/bash
# Master build script for Mia Agents documentation
# Usage: ./build.sh [all|semantic|both]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_usage() {
    cat << EOF
Usage: ./build.sh [OPTION]

Options:
  all       Build complete agent collection (mia-agents-all.md)
  semantic  Build semantic category groups
  both      Build both all and semantic groups (default)
  help      Show this help message

Examples:
  ./build.sh              # Build everything
  ./build.sh all          # Build only complete collection
  ./build.sh semantic     # Build only semantic groups
EOF
}

build_all() {
    echo "🚀 Building complete agent collection..."
    bash "${SCRIPT_DIR}/build-all-agents.sh"
}

build_semantic() {
    echo "🚀 Building semantic groups..."
    bash "${SCRIPT_DIR}/build-semantic-groups.sh"
}

# Main logic
case "${1:-both}" in
    all)
        build_all
        ;;
    semantic)
        build_semantic
        ;;
    both)
        build_all
        echo ""
        build_semantic
        ;;
    help|--help|-h)
        print_usage
        exit 0
        ;;
    *)
        echo "❌ Unknown option: $1"
        echo ""
        print_usage
        exit 1
        ;;
esac

echo ""
echo "✨ Build process complete!"
echo ""
