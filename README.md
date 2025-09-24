# NASDAQ_parser
# 📡 NASDAQ-Style Ethernet Packet Parser
# 📖 Intro

Working on this as a personal project to explore the potential of FPGAs for high-speed networking and data processing. I'm creating an Ethernet packet parser in SystemVerilog to extract price updates of specific stocks from high-speed financial feeds (e.g., NASDAQ) to familiarise myself with FPGA applications in finance.

The parser sits downstream of the MAC and uses AXI-Stream interfaces (with tkeep and tlast) between every module. Each layer realigns the payload and parses packets based on relevent fields in layer headers. The IP module reads the header length (IHL) to strip the header and forward only the payload.

To test it, I wrote a C++ program that generates complete network stack packets and writes them word by word (64bit) like they'd come from a MAC, in a Verilog-friendly format for testbenches. This lets me easily simulate traffic, see if the modules correctly parse packets, and make sure everything behaves correctly.

# ✨ Key Features

🛠️ Modular SystemVerilog Parser

Separate modules for each layer: Ethernet → IP → UDP → MOLDUDP64 → ITCH

Each module communicates via pipelined AXI-Stream interfaces with tkeep & tlast,


💻 C++ Packet Generator

Generates full network stack packets subject to user input (with customisable values in header fields) - with headers and payloads

Used to test filtering of packets of each layer

🎯 Layered Parsing Logic

Ethernet parses packets based on source MAC addresses and ethernet type

IP module reads header length to forward only the payload

Payloads are realigned at every layer for proper processing downstream

⚡ High-Speed Parsing

Designed for low-latency processing of financial-style Ethernet feeds

AXI-Stream pipelining ensures each module can operate independently and continuously

# 🛠️ Current Status & Roadmap

✅ Implemented: Ethernet and IP layers

🔜 Next:

UDP

MOLDUDP64 → will read packet sequence numbers to flag missed packets

ITCH → will track order and price updates of selected shares using the stock symbol field

Goal: Complete full network stack parser for high-speed financial applications that updates stock prices for selected stocks.
