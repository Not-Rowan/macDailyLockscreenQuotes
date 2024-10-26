import random
import subprocess

def selectRandQuote():
    # get length of file
    with open(r"/Users/rowan/automations/quoteGenerator/quotes.csv", 'r') as fp:
        fileContents = fp.readlines() # read contents of file
        randQuoteLine = random.randint(1, len(fileContents)) # select random line (exclude labels on line 1)
        quoteLine = fileContents[randQuoteLine]

    # split author and quote apart
    splitLine = quoteLine.split("\",")

    author = splitLine[0]
    quote = splitLine[1]

    # get rid of newline at the end of the quote
    quote = quote.replace("\n", "")

    # get rid of first quotation mark in author
    author = author[1:]

    # if there are quotes or double quotes in the quote, escape them
    quote = quote.replace("\"", "\\\"")
    quote = quote.replace("'", "\\'")

    # if author is empty, put "Author Unknown"
    if author == '':
        author = "Author Unknown"

    # format the full quote
    quoteString = quote + " - " + author

    return quoteString

def writeStringToLockscreen(string):
    # sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Your Lock Screen Message"
    command = ["sudo", "defaults", "write", "/Library/Preferences/com.apple.loginwindow", "LoginwindowText", f"'{quoteString}'"]
    subprocess.run(command, check=True)

quoteString = selectRandQuote()
writeStringToLockscreen(quoteString)
print(f"Wrote string to lock screen: '{quoteString}'")
