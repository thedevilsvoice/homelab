import setuptools

with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

setuptools.setup(name='homelab',
                 version='1.0',
                 description='my home lab files',
                 author='franklin',
                 author_email='@theDevilsVoice',
                 url='https://github.com/thedevilsvoice/homelab/',
                 python_requires=">=3.6"
                 )
