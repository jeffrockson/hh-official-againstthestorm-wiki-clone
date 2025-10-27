#!/usr/bin/env python3
"""
Upload module script for Against the Storm wiki.
Uploads a file to MediaWiki as a Module page.
"""

import argparse
import sys
from pathlib import Path
from mediawiki_client import create_client

def main():
    """Main entry point for the upload module script."""
    parser = argparse.ArgumentParser(
        description="Upload a file to MediaWiki as a Module page",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python upload_module.py my_script.lua -u username -p password
  python upload_module.py path/to/module.py -u admin -p secret
        """
    )
    
    parser.add_argument('file_path', help='Path to the file to upload')
    parser.add_argument('-u', '--username', help='MediaWiki username for authentication')
    parser.add_argument('-p', '--password', help='MediaWiki password for authentication')
    parser.add_argument('--base-url', default='http://localhost:4000', 
                       help='Base URL of the MediaWiki instance (default: http://localhost:4000)')
    
    args = parser.parse_args()
    
    # Validate file path
    file_path = Path(args.file_path)
    if not file_path.exists():
        print(f"Error: File '{file_path}' does not exist.")
        sys.exit(1)
    
    if not file_path.is_file():
        print(f"Error: '{file_path}' is not a file.")
        sys.exit(1)
    
    # Extract module name from filename (without extension)
    module_name = file_path.stem
    page_title = f"Module:{module_name}"
    
    # Read file content
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except UnicodeDecodeError:
        print(f"Error: Could not read file '{file_path}' as UTF-8 text.")
        sys.exit(1)
    except Exception as e:
        print(f"Error: Failed to read file '{file_path}': {e}")
        sys.exit(1)
    
    # Create MediaWiki client
    client = create_client(
        base_url=args.base_url,
        username=args.username,
        password=args.password
    )
    
    # Authenticate if credentials provided
    if not args.username or not args.password:
        print("Warning: No credentials provided. Upload may fail if authentication is required.")
        sys.exit(1)
    
    # Upload the content
    summary = f"Uploaded {file_path.name} via upload_module.py"
    success = client.update_page_content(page_title, content, summary)
    
    if success:
        print(f"Successfully uploaded '{file_path}' to '{page_title}'")
        sys.exit(0)
    else:
        print(f"Failed to upload '{file_path}' to '{page_title}'")
        sys.exit(1)

if __name__ == '__main__':
    main()
