from setuptools import setup, find_packages

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setup(
    name="dark-templarat",
    version="2.0.0",
    author="Anonymous",
    author_email="security@bedusec.com",
    description="Advanced Security Testing Framework",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/BeduSec/TemplarRAT",
    packages=find_packages(),
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Security Professionals",
        "Topic :: Security",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Programming Language :: Python :: 3",
        "Operating System :: Android",
        "Operating System :: Linux",
    ],
    python_requires=">=3.8",
    install_requires=[
        "flask>=2.0.0",
        "cryptography>=36.0.0",
        "requests>=2.27.0",
    ],
    entry_points={
        "console_scripts": [
            "dark-templarat=core.dark_c2:main",
        ],
    },
)
