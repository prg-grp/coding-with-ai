# 16 API - Application Programming Interface

An API - Application Programming Interface - is a way for two or more computer programs or components to communicate with each other. Usually a component *offers a service* to other pieces of software, and a document or standard describes how to build or use such a connection or interface (API *specification*).


## 16.1 Task: Yahoo Finance API

Yahoo Finance (https://finance.yahoo.com/) provides an API to retrieve data from the stock market using Python. The API is described, for example, here: https://pypi.org/project/yfinance/.
The following is a program that uses the API to retrieve the value of Apple stocks in the last 6 months and plot it.

The program *calls* the Yahoo API. For example, the call

```
# Get the stock data
stock = yf.Ticker(ticker_symbol)
```

retrieves the data for the Apple stocks. Programmers need to know how to interact with the API. For example, they need to know that to retrieve the data for a stock, they need to call `yf.Ticker(...)` and that the argument should be a string with the stock identifier and the return value is a `Ticker` object. Also, programmers need to know what to do with a `Ticker` object.



```python
import yfinance as yf
import matplotlib.pyplot as plt

# Define the stock ticker symbol
ticker_symbol = 'AAPL'

# Get the stock data
stock = yf.Ticker(ticker_symbol)

# Retrieve historical market data for the past 6 months
historical_data = stock.history(period="6mo")

# Print the historical data
print(historical_data)

# Plot the historical closing prices
historical_data['Close'].plot(title=f'{ticker_symbol} Closing Prices')
plt.show()
```

- After running the program, use the AI to explore API of the `Ticker` object, i.e., the things you can do with a `Ticker` object. The program demonstrates how to use `stock.history` to access the data of the stock over a certain period of time. But there is much more, such as `stock.` followed by `info, actions, dividends, splits, financials, quarterly_financials, major_holders, institutional_holders, balance_sheet, quarterly_balance_sheet, cashflow, quarterly_cashflow, earnings, quarterly_earnings, sustainability, recommendations, calendar, isin, options, option_chain, news`.

- Write a program that uses the API. We suggest to do that manually, to better test the knowledge that the AI provided about the API. For example, you can sketch the interaction with the API of the following program and complete it using the AI.

The *Sustainable Investment Analyzer* is a Python application that helps users evaluate the sustainability performance of companies by using Environmental, Social, and Governance (ESG) metrics. The program will retrieve ESG scores and other relevant financial data for a given company from Yahoo Finance, allowing users to assess the sustainability of their investments. The application will provide insights through visualizations and generate reports on the sustainability performance of selected companies.



```python

```

## 16.2 Task: Lyrics API

Lyrics.ovh (https://lyrics.ovh/) is a service that provides the lyrics of a specified song. Besides the website, there is also a public API that you can integrate into your Python programs to do the same.

- Using the AI explore the API of lyrics.ovh

- Write a simple program that fetches and prints the lyrics of a song using the lyrics.ovh API



```python

```

## 16.3 Task: Public APIs

There are many publicly available APIs. Some of them are listed here:
https://github.com/public-apis/public-apis?tab=readme-ov-file

- Pick an API that can be interesting for you and explore it using the AI

- Write a simple program using the API



```python

```
