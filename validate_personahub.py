#!/usr/bin/env python3
"""
PersonaHub Framework Validation Script

This script validates the PersonaHub framework implementation by checking:
- Agent file structure and format consistency
- Framework documentation completeness
- Configuration validity
- Integration with existing agent patterns
"""

import os
import yaml
import re
from pathlib import Path

class PersonaHubValidator:
    def __init__(self, repo_path="/home/runner/work/mia-agents/mia-agents"):
        self.repo_path = Path(repo_path)
        self.personahub_agents = [
            "persona-hub-architect.md",
            "persona-corpus-generator.md", 
            "synthetic-data-composer.md",
            "poly-modal-persona-designer.md",
            "persona-synthesis-orchestrator.md"
        ]
        self.framework_files = [
            "framework/personahub/README.md",
            "framework/personahub/configuration.md",
            "framework/personahub/examples.md"
        ]
        
    def validate_agent_files(self):
        """Validate PersonaHub agent file structure and content"""
        print("🧠 Validating PersonaHub Agent Files...")
        results = {}
        
        for agent_file in self.personahub_agents:
            file_path = self.repo_path / agent_file
            results[agent_file] = self.validate_single_agent(file_path)
            
        return results
    
    def validate_single_agent(self, file_path):
        """Validate individual agent file"""
        if not file_path.exists():
            return {"valid": False, "error": "File does not exist"}
            
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Check for YAML frontmatter
            if not content.startswith('---'):
                return {"valid": False, "error": "Missing YAML frontmatter"}
                
            # Extract frontmatter
            parts = content.split('---', 2)
            if len(parts) < 3:
                return {"valid": False, "error": "Malformed YAML frontmatter"}
                
            try:
                frontmatter = yaml.safe_load(parts[1])
            except yaml.YAMLError as e:
                return {"valid": False, "error": f"Invalid YAML: {e}"}
                
            # Validate required frontmatter fields
            required_fields = ['name', 'description', 'model']
            missing_fields = [field for field in required_fields if field not in frontmatter]
            if missing_fields:
                return {"valid": False, "error": f"Missing required fields: {missing_fields}"}
                
            # Check for PersonaHub-specific content
            content_checks = {
                "creative_orientation": any(phrase in content for phrase in [
                    "creative orientation", "advancing pattern", "structural tension"
                ]),
                "personahub_concepts": any(phrase in content for phrase in [
                    "PersonaHub", "petascale", "multi-modal", "poly-modal", "elastic synthesis"
                ]),
                "mia_miette_integration": any(phrase in content for phrase in [
                    "🧠", "🌸", "Mia", "Miette"
                ])
            }
            
            return {
                "valid": True,
                "frontmatter": frontmatter,
                "content_checks": content_checks,
                "file_size": len(content)
            }
            
        except Exception as e:
            return {"valid": False, "error": f"Error reading file: {e}"}
    
    def validate_framework_files(self):
        """Validate framework documentation files"""
        print("📚 Validating Framework Documentation...")
        results = {}
        
        for framework_file in self.framework_files:
            file_path = self.repo_path / framework_file
            results[framework_file] = self.validate_framework_file(file_path)
            
        return results
    
    def validate_framework_file(self, file_path):
        """Validate individual framework file"""
        if not file_path.exists():
            return {"valid": False, "error": "File does not exist"}
            
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Check for key sections based on filename
            filename = file_path.name
            if filename == "README.md":
                required_sections = [
                    "Framework Architecture", "Core Components", "Creative Orientation"
                ]
            elif filename == "configuration.md":
                required_sections = [
                    "personahub_framework", "quality_framework", "scaling"
                ]
            elif filename == "examples.md":
                required_sections = [
                    "Basic Persona Generation", "Multi-Modal Generation", "Integration"
                ]
            else:
                required_sections = []
                
            missing_sections = []
            for section in required_sections:
                if section not in content:
                    missing_sections.append(section)
                    
            # Check for Mermaid diagrams in README
            has_mermaid = "```mermaid" in content if filename == "README.md" else True
            
            return {
                "valid": len(missing_sections) == 0 and has_mermaid,
                "missing_sections": missing_sections,
                "has_mermaid": has_mermaid,
                "file_size": len(content)
            }
            
        except Exception as e:
            return {"valid": False, "error": f"Error reading file: {e}"}
    
    def validate_readme_integration(self):
        """Validate that main README includes PersonaHub documentation"""
        print("🔗 Validating README Integration...")
        
        readme_path = self.repo_path / "README.md"
        if not readme_path.exists():
            return {"valid": False, "error": "Main README.md not found"}
            
        try:
            with open(readme_path, 'r', encoding='utf-8') as f:
                content = f.read()
                
            personahub_mentions = content.count("PersonaHub")
            has_framework_link = "framework/personahub" in content
            has_agent_mentions = any(agent.replace('.md', '') in content for agent in self.personahub_agents)
            
            return {
                "valid": personahub_mentions > 0 and has_framework_link,
                "personahub_mentions": personahub_mentions,
                "has_framework_link": has_framework_link,
                "has_agent_mentions": has_agent_mentions
            }
            
        except Exception as e:
            return {"valid": False, "error": f"Error reading README: {e}"}
    
    def validate_file_naming_consistency(self):
        """Validate that file naming follows established patterns"""
        print("📝 Validating File Naming Consistency...")
        
        # Check that PersonaHub agents follow kebab-case naming
        naming_issues = []
        for agent_file in self.personahub_agents:
            if not re.match(r'^[a-z]+(-[a-z]+)*\.md$', agent_file):
                naming_issues.append(f"{agent_file} doesn't follow kebab-case pattern")
                
        return {
            "valid": len(naming_issues) == 0,
            "naming_issues": naming_issues
        }
    
    def run_full_validation(self):
        """Run complete validation suite"""
        print("🌸 PersonaHub Framework Validation")
        print("=" * 50)
        
        validation_results = {
            "agent_files": self.validate_agent_files(),
            "framework_files": self.validate_framework_files(),
            "readme_integration": self.validate_readme_integration(),
            "naming_consistency": self.validate_file_naming_consistency()
        }
        
        # Generate summary
        print("\n📊 Validation Summary:")
        print("-" * 30)
        
        total_checks = 0
        passed_checks = 0
        
        # Agent files summary
        for agent, result in validation_results["agent_files"].items():
            total_checks += 1
            if result["valid"]:
                passed_checks += 1
                print(f"✅ {agent}")
            else:
                print(f"❌ {agent}: {result['error']}")
                
        # Framework files summary
        for framework_file, result in validation_results["framework_files"].items():
            total_checks += 1
            if result["valid"]:
                passed_checks += 1
                print(f"✅ {framework_file}")
            else:
                print(f"❌ {framework_file}: Missing {result.get('missing_sections', result.get('error', 'Unknown error'))}")
                
        # Integration checks
        total_checks += 2
        if validation_results["readme_integration"]["valid"]:
            passed_checks += 1
            print(f"✅ README.md integration")
        else:
            print(f"❌ README.md integration: {validation_results['readme_integration']['error']}")
            
        if validation_results["naming_consistency"]["valid"]:
            passed_checks += 1
            print(f"✅ File naming consistency")
        else:
            print(f"❌ File naming consistency: {validation_results['naming_consistency']['naming_issues']}")
            
        print(f"\n🎯 Overall Result: {passed_checks}/{total_checks} checks passed")
        
        if passed_checks == total_checks:
            print("🎉 PersonaHub framework validation PASSED! All components are properly implemented.")
        else:
            print(f"⚠️  PersonaHub framework validation needs attention. {total_checks - passed_checks} issues found.")
            
        return validation_results

if __name__ == "__main__":
    validator = PersonaHubValidator()
    results = validator.run_full_validation()